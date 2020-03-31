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
  tidyr::separate(rn, into = c("File", "Row"), sep = "\\.") %>%
  dplyr::rowwise() %>%
  dplyr::mutate(
    Type = ifelse(grepl("positivos", File), "Positive", "Suspected"),
    PatientId = paste0(
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
    File
  ) %>%
  tidyr::nest() %>%
  dplyr::mutate(
    RowsPerFile = purrr::map_int(data, ~nrow(.x)),
  ) %>%
  tidyr::unnest(
    cols=data
  ) %>% 
  dplyr::ungroup()

# we extract all the files where PatientX is listed
rowsPerPatient <- rows %>%
  dplyr::group_by(PatientId) %>%
  dplyr::mutate(
    FilesForPatient = map_chr(data, function(.x) {
      .x$File %>% paste0(collapse=", ")
    }),
  ) %>%
  tidyr::unnest(
    cols=data
  ) %>% 
  dplyr::ungroup()

dplyr::slice(1) %>% 
  dplyr::select(PatientId, FilesForPatient) %>%
  View()

rows %>%
  dplyr::group_by(
    File
  ) %>% dplyr::slice(1) %>% 
  dplyr::select(
    File, RowsPerFile
  ) %>%
  View()
