library(plyr)
library(rjson)
library(tidyr)
library(data.table)
library(purrr)

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

rows_orig <- do.call(rbind, files)
rows_orig <- setDT(rows_orig, keep.rownames = TRUE)[]

# we create an ID per patient based on different factors that stay constant between all files
rows <- rows_orig %>% 
  tidyr::separate(rn, into = c("file_id", "row"), sep = "\\.") %>%
  dplyr::rowwise() %>%
  dplyr::mutate(
    type = ifelse(grepl("positivos", file_id), "Positive", "Suspected"),
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
    )
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

rows %>%
  dplyr::group_by(
    File
  ) %>% dplyr::slice(1) %>% 
  dplyr::select(
    File, RowsPerFile
  ) %>%
  View()
