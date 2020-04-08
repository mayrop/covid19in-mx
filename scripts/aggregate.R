library(plyr)
library(rjson)
library(tidyr)
library(data.table)
library(purrr)
library(forcats)
library(lubridate)

source("_functions.R")

processed <- read.csv("../static/data/positivos.csv")

# adding states
states <- read.csv("../static/data/estados.csv")
states <- states %>%
  dplyr::mutate_all(as.character)

# processing federal
federal <- read.csv("../static/data/timeseries/federal.csv")

federal <- federal %>%
  dplyr::mutate(
    Positivos = ifelse(is.na(Positivos), 0, Positivos),
    Defunciones = ifelse(is.na(Defunciones), 0, Defunciones)
  )

customFun  = function(DF) {
  write.csv(DF, paste0("federal_", gsub("-", "", unique(DF$Fecha)),".csv"), row.names = FALSE, na = "")
  return(DF)
}

federal %>% 
  dplyr::group_by(Fecha) %>% 
  dplyr::do(customFun(.))

customFun  = function(DF) {
  write.csv(DF, paste0("estatal_", tolower(unique(DF$Estado)),".csv"), row.names = FALSE, na = "")
  return(DF)
}

federal %>% 
  dplyr::group_by(Estado) %>% 
  dplyr::do(customFun(.))

write.csv(federal, 'federal.csv', row.names = FALSE, na = "")

all <- federal %>% 
  dplyr::group_by(Fecha) %>% 
  dplyr::summarise(
    Positivos=sum(Positivos, na.rm = TRUE),
    Sospechosos=sum(Sospechosos, na.rm = TRUE),
    Negativos=sum(Negativos, na.rm = TRUE),
    Defunciones=sum(Defunciones, na.rm = TRUE),
    Inconsistencias=sum(Inconsistencias, na.rm = TRUE)
  )

write.csv(all, 'totales.csv', row.names = FALSE)
