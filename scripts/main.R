library(plyr)
library(rjson)
library(tidyr)
library(data.table)
library(purrr)
library(forcats)
library(lubridate)


# -------------------------------------------------------------------------------------

# F U N C T I O N S

# add_time_columns(times, "my_time", "etc", tz = "UTC", hours=TRUE, format="%Y-%m-%d %H:%M:%S")

add_time_columns <- function(df, column, prefix, format="%Y-%m-%d", tz="America/Los_Angeles", hours = FALSE) {
  colname <- paste0(prefix, "_std")
  # to create quotation: https://thisisnic.github.io/2018/04/16/how-do-i-make-my-own-dplyr-style-functions/
  # column <- enquo(column)
  #browser()
  df <- df %>%
    dplyr::mutate(
      # remember !! is for evaluating right away
      # remember sym is for converting strings to symbols
      !!colname := as.POSIXct(!!rlang::sym(column), format=format, tz=tz, usetz=TRUE),
      !!paste0(prefix, "_day") := day(!!rlang::sym(colname)),
      !!paste0(prefix, "_month") := month(!!rlang::sym(colname)),
      !!paste0(prefix, "_month_name") := factor(!!rlang::sym(paste0(prefix, "_month")), levels = 1:12, labels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")),
      !!paste0(prefix, "_year") := year(!!rlang::sym(colname)),
      !!paste0(prefix, "_weekday") := wday(!!rlang::sym(colname), week_start = getOption("lubridate.week.start", 7)),
      !!paste0(prefix, "_weekday_name") := factor(!!rlang::sym(paste0(prefix, "_weekday")), levels = 1:7, labels = c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")),
      !!paste0(prefix, "_weekday_name") := forcats::fct_explicit_na(!!rlang::sym(paste0(prefix, "_weekday_name")), na_level = "NA")
    )
  
  if (hours) {
    df <- df %>% 
      dplyr::mutate(
        # remember !! is for evaluating right away
        # remember sym is for converting strings to symbols
        # format = "%Y-%m-%d %h:%m"
        !!colname := as.POSIXct(!!rlang::sym(column), format=format, tz=tz, usetz=TRUE),
        !!paste0(prefix, "_hour") := hour(!!rlang::sym(colname)),
        !!paste0(prefix, "_minute") := minute(!!rlang::sym(colname)),
        !!paste0(prefix, "_second") := second(!!rlang::sym(colname))
      )
  }
  
  df
}


slugify <- function(x, alphanum_replace="", space_replace="-", tolower=TRUE) {
  x <- gsub("/", "-", x)
  x <- gsub("[^[:alnum:] -]", alphanum_replace, x)
  x <- gsub(" ", space_replace, x)
  if (tolower) { 
    x <- tolower(x) 
  }
  
  x <- gsub("á", "a", x)
  x <- gsub("é", "e", x)
  x <- gsub("í", "i", x)
  x <- gsub("ó", "o", x)
  x <- gsub("ú", "u", x)
  x <- gsub("ñ", "n", x)
  
  return(x)
}


create_files_lookup <- function(files) {
  files_lookup <- names(files) %>% as.data.frame()
  colnames(files_lookup) <- c("file_id")
  
  files_lookup %>% 
    dplyr::mutate(temp = gsub("([a-z]+)_(.*)", "\\1.\\2", file_id)) %>%
    tidyr::separate(temp, c("type", "file_date"), sep="\\.") %>%
    add_time_columns("file_date", prefix="file_date", format="%Y_%m_%d") %>%
    dplyr::mutate(
      file_id = as.character(file_id)
    )
}


map_tables <- function(yesterday, today) {

  case_ids_new_cases <- today %>% 
    dplyr::anti_join(yesterday, by="patient_id")
  
  case_ids_deleted_cases = yesterday %>% 
    dplyr::anti_join(today, by="patient_id")
  
  new_df = yesterday
  
  # first remove from yesterday the deleted cases
  for (case in rownames(case_ids_deleted_cases)) {
    row_id <- as.integer(case_ids_deleted_cases[case, 1])
    
    new_df <- rbind(
      new_df[1:row_id-1,], new_df[-(1:row_id),]
    )
  }   
  
  # then add new cases
  for (case in rownames(case_ids_new_cases)) {
    row_id <- as.integer(case_ids_new_cases[case, 1]) - 1
    patient_id <- case_ids_new_cases[case, 2] %>% as.character()
    
    new_df <- rbind(
      new_df[1:row_id,], c(NA, patient_id), new_df[-(1:row_id),]
    )
  }  
  
  col_prefix <- colnames(new_df)[1]
  col_case_id <- colnames(today)[1]
  col_patient_id <- paste0("patient_id_", col_case_id)
  
  new_df <- new_df %>% 
    dplyr::mutate(!!col_case_id := dplyr::row_number()) %>%
    dplyr:::rename(!!col_patient_id := patient_id) %>%
    # convert to symbol and evaluate
    dplyr::mutate(!!col_prefix := as.integer(!!rlang::sym(col_prefix)))
  
  return(
    list(
      case_ids_new_cases=case_ids_new_cases,
      case_ids_deleted_cases=case_ids_deleted_cases,
      new_df=new_df
    )
  )
}


get_ids_for_type <- function(file_type="positivos", rows, files_lookup) {
  my_unique_files <- files_lookup %>% 
    dplyr::filter(type == file_type) %>% 
    dplyr::pull(file_id) %>% 
    unique()
  
  ids_positivos = list()
  
  for (f in my_unique_files) {
    file_rows = rows %>% 
      dplyr::filter(file_id == f)
    
    ids_positivos[[f]] <- file_rows %>% 
      dplyr::select(Caso, patient_id) %>% 
      # remember !! is for evaluating right away
      # so we evaluate the index and set it as string
      dplyr::rename(!!f := Caso) %>%
      dplyr::mutate()
  }
  
  return(ids_positivos)
}


# -------------------------------------------------------------------------------------

filenames <- list.files(
  path = "../static/data/results/csv", 
  pattern="*.csv", 
  full.names=TRUE
)

indexes <- basename(filenames)
indexes <- gsub("[A-z0-9-]+(positivos|sospechosos)-(.*?)([0-9-]+).csv", "\\1\\3", indexes)
names(filenames) <- gsub("-+", "_", indexes)

files <- lapply(filenames, read.csv, header=TRUE, na.strings="")
files[["sospechosos_2020_02_25"]] <- NULL

str(files)
files_lookup <- create_files_lookup(files)

rows_orig <- do.call(rbind, files)
rows_orig <- setDT(rows_orig, keep.rownames = TRUE)[]

# we create an ID per patient based on different factors that stay constant between all files
rows <- rows_orig %>% 
  tidyr::separate(rn, into = c("file_id", "row"), sep = "\\.") %>%
  dplyr::rowwise() %>%
  dplyr::mutate(
    patient_id = paste0(
      slugify(c(
        as.character(Estado), 
        as.character(Sexo), 
        Edad,
        as.character(FechaInicioSintomas), 
        as.character(Procedencia), 
        as.character(FechaLlegada), 
        as.character(Contacto)
      )), collapse="_"
    ),
    file_id = as.character(file_id)
  ) %>% 
  as.data.frame() %>%
  dplyr::inner_join(
    files_lookup, 
    by=c("file_id" = "file_id")
  ) %>%
  dplyr::arrange(file_date_std)

# fixing cuba...
rows[
  rows$patient_id=="ciudad-de-mexico_m_64_10-03-2020_cuba_10-03-2020_si",
]$patient_id = "ciudad-de-mexico_m_64_10-03-2020_NA_10-03-2020_si"


rows <- rows %>%
  dplyr::group_by(
    file_id, patient_id
  ) %>%
  dplyr::mutate(
    patient_id_row = dplyr::row_number()
  ) %>%
  dplyr::ungroup() %>%
  dplyr::rowwise() %>%
  dplyr::mutate(
    patient_id_bak = patient_id,
    patient_id = paste0(patient_id, patient_id_row, collapse = "_")
  ) %>%
  as.data.frame()
  

# we add how many rows we find per file
rows <- rows %>%
  dplyr::group_by(
    file_id
  ) %>%
  tidyr::nest() %>%
  dplyr::mutate(
    rows_per_file = purrr::map_int(data, ~nrow(.x)),
  ) %>%
  tidyr::unnest(
    cols=data
  ) %>% 
  dplyr::ungroup()

# double check numbers
rows %>%
  dplyr::group_by(
    file_id
  ) %>% dplyr::slice(1) %>% 
  dplyr::select(
    file_id, rows_per_file
  ) %>%
  View()

ids_positivos = get_ids_for_type("positivos", rows, files_lookup)

ids_positivos_colnames <- names(ids_positivos)
my_map <- ids_positivos[[ids_positivos_colnames[1]]]

for (i in 2:length(ids_positivos_colnames)) {
  yesterday <- ids_positivos_colnames[i-1]
  today <- ids_positivos_colnames[i]
  
  mapped_table <- map_tables(
    ids_positivos[[yesterday]], 
    ids_positivos[[today]]
  )
  
  my_map <- my_map %>%
    dplyr::full_join(
      mapped_table$new_df, by=c(yesterday), na_matches="never"
    )
}





# we extract all the files where PatientX is listed
rows <- rows %>%
  dplyr::group_by(patient_id) %>%
  tidyr::nest() %>%
  dplyr::mutate(
    files_per_patient = map_chr(data, function(.x) {
      .x$file %>% paste0(collapse=", ")
    }),
  ) %>%
  tidyr::unnest(cols=data) %>%
  dplyr::ungroup()

rows %>%
  dplyr::group_by(patient_id) %>%
  tidyr::nest() %>%
  dplyr::mutate(
    files_per_patient = map_chr(data, function(.x) {
      .x$file %>% paste0(collapse=", ")
    }),
  ) %>%
  tidyr::unnest(cols=data) %>%
  dplyr::ungroup()

rows %>%
  dplyr::group_by(patient_id) %>%
  dplyr::slice(1) %>% 
  dplyr::select(patient_id, files_per_patient) %>%
  View()

rows %>%
  dplyr::group_by(file_id, patient_id) %>%
  dplyr::summarise(
    rows_per_file_and_patient = n()
  ) %>% 
  View()

