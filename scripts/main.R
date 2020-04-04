library(plyr)
library(rjson)
library(tidyr)
library(data.table)
library(purrr)
library(forcats)
library(lubridate)


source("_functions.R")

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
  dplyr::select(-row)

colnames(rows) <- c(
  "file_id", "case", "state", "city", "sex",
  "age", "date_symptoms", "situation", "origin", "date_arrival",
  "is_recovered", "date_symptoms_fixed"
)

rows <- rows %>% 
  dplyr::mutate(
    age_fixed = NA,
    date_age_fixed = NA,
    origin_fixed = NA,
    date_origin_fixed = NA,
    sex_fixed = NA,
    date_age_fixed = NA,
    removed_at = NA
  )

rows <- rows %>%
  dplyr::rowwise() %>%
  dplyr::mutate(
    patient_id = paste0(
      slugify(c(
        as.character(state), 
        as.character(sex), 
        age,
        as.character(date_symptoms), 
        as.character(origin), 
        as.character(date_arrival)
      )), "_", collapse=""
    ),
    file_id = as.character(file_id)
  ) %>% 
  as.data.frame() %>%
  dplyr::inner_join(
    files_lookup, 
    by=c("file_id" = "file_id")
  ) %>%
  dplyr::arrange(file_date_std)

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
    patient_id_unique = patient_id,
    patient_id = paste0(patient_id, patient_id_row, sep="")
  ) %>%
  as.data.frame()
  
# todo - add file with "original"

rows_before_fix <- rows

source("_fixes.R")

rows <- rows %>%
  dplyr::mutate(
    age_id = ifelse(is.na(age_fixed), age, age_fixed),
    sex_id = ifelse(is.na(sex_fixed), as.character(sex), as.character(sex_fixed)),
    origin_id = ifelse(is.na(origin_fixed), as.character(origin), as.character(origin_fixed)),
    patient_id_bak = patient_id
  ) %>%
  dplyr::rowwise() %>%
  dplyr::mutate(
    patient_id = paste0(
      slugify(c(
        as.character(state), 
        as.character(sex_id), 
        age_id,
        as.character(date_symptoms), 
        as.character(origin_id), 
        as.character(date_arrival),
        as.character(removed_at)
      )), "_", collapse=""
    ),
    file_id = as.character(file_id)
  ) %>% 
  as.data.frame() %>%
  dplyr::arrange(file_date_std)

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
    patient_id_unique = patient_id,
    patient_id = paste0(patient_id, patient_id_row, sep="")
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


positive_ids = get_ids_for_type("positivos", rows, files_lookup)

positive_ids_colnames <- names(positive_ids)

for (i in 1:length(positive_ids_colnames)) {
  yesterday <- ifelse(i > 1, positive_ids_colnames[i-1], NA)
  today <- positive_ids_colnames[i]
  
  new_col <- paste0("status_", today)
  new_data_col <- paste0("data_", today)

  mapped_table <- map_tables(
    today, yesterday, positive_ids
  )
  
  if (i == 1) {
    my_map <- positive_ids[[positive_ids_colnames[1]]]
  } else {
    my_map <- my_map %>% 
      dplyr::full_join(
        positive_ids[[today]], by="patient_id", na_matches="never"
      )    
  }
  
  my_map <- my_map %>%
    dplyr::mutate(
      !!new_col := dplyr::case_when(
        patient_id %in% mapped_table$new_rows$patient_id ~ "ADDED", 
        patient_id %in% mapped_table$deleted_rows$patient_id ~ "REMOVED",
        is.na(!!rlang::sym(today)) ~ "NOT EXISTENT",
        TRUE ~ "SAME"
      )
    ) %>%
    dplyr::rowwise() %>%
    dplyr::mutate(
      !!new_data_col := purrr::pmap(
        .l = list(!!rlang::sym(today), !!rlang::sym(new_col)),
        .f = function(x, y) { 
          tibble(x=x, y=y)
        }
      )
    )
}



my_map <- my_map %>%
  dplyr::select(-starts_with("positivos"), -starts_with("status")) %>%
  tidyr::gather(date, data, -patient_id, -starts_with("status"), -starts_with("positivos")) %>%
  tidyr::unnest(cols = data)

#checking things that were removed
my_map %>%
  dplyr::arrange(date) %>%
  dplyr::group_by(patient_id) %>%
  tidyr::nest() %>%
  dplyr::mutate(
    date_added = map_chr(data, function(.x) { 
      temp <- .x %>% dplyr::filter(y == "ADDED") %>% dplyr::pull(date) %>% paste0(., "", collapse=NULL)
      if (length(temp) > 1) {
        return("CHECK")
      } 
      temp
    }),
    date_removed = map_chr(data, function(.x) { 
      temp <- .x %>% dplyr::filter(y == "REMOVED") %>% dplyr::pull(date) %>% paste0(., "", collapse=NULL)
      if (length(temp) > 1) {
        return("CHECK")
      } 
      temp 
    })
  ) %>% 
  tidyr::unnest(cols=data) %>%
  dplyr::filter(
    date_removed != "" & y != "NOT EXISTENT"
  ) %>%
  View()

View(my_map)



# we extract all the files where PatientX is listed
rows <- rows %>%
  dplyr::group_by(patient_id) %>%
  tidyr::nest() %>%
  dplyr::mutate(
    files_per_patient = map_chr(data, function(.x) {
      .x$file_id %>% paste0(collapse=", ")
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

