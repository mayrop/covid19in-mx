# fixing for rows %>% dplyr::filter(procedencia == 'EN INVESTIGACIÓN'), that person later shows up as "Contacto"
# see line 64 in http://localhost:1313/data/results/covid-19-resultado-positivos-indre-2020-03-21.pdf and
# http://localhost:1313/data/results/covid-19-resultado-positivos-indre-2020-03-20.pdf
rows[grepl("cuba", rows$patient_id, ignore.case=TRUE),]
rows[grepl("investiga", rows$origin, ignore.case=TRUE), ] 


# http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-03-20.txt
# http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-03-19.txt
# 64    CIUDAD DE MÉXICO   M   41   09/03/2020   confirmado   En investigación      NA
# 92    CIUDAD DE MÉXICO   M   41   09/03/2020 confirmado   En investigación NA

rows[
  rows$patient_id %in% c(
    "ciudad-de-mexico_m_41_09-03-2020_en-investigacion_NA_1"
  ) & rows$file_id %in% c(
    "positivos_2020_03_19", "positivos_2020_03_20"
  ), c("origin_fixed")
  ]  <- "CONTACTO"

rows[
  rows$patient_id %in% c(
    "ciudad-de-mexico_m_41_09-03-2020_en-investigacion_NA_1"
  ) & rows$file_id %in% c(
    "positivos_2020_03_19", "positivos_2020_03_20"
  ), c("date_origin_fixed")
  ]  <- "positivos_2020_03_21"


# line 

rows[
  rows$patient_id %in% c(
    "ciudad-de-mexico_m_64_10-03-2020_contacto---cuba_10-03-2020_1",
    "ciudad-de-mexico_m_64_10-03-2020_contacto-cuba_10-03-2020_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_13", "positivos_2020_03_14", "positivos_2020_03_15", 
      "positivos_2020_03_18", "positivos_2020_03_19"
    ), c("origin_fixed")
  ] <- "CONTACTO"

rows[
  rows$patient_id %in% c(
    "ciudad-de-mexico_m_64_10-03-2020_contacto---cuba_10-03-2020_1",
    "ciudad-de-mexico_m_64_10-03-2020_contacto-cuba_10-03-2020_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_13", "positivos_2020_03_14", "positivos_2020_03_15", 
      "positivos_2020_03_18", "positivos_2020_03_19"
    ), c("date_origin_fixed")
  ] <- "positivos_2020_03_20"


# http://localhost:1313/data/results/covid-19-resultado-positivos-indre-2020-03-22.pdf
# http://localhost:1313/data/results/covid-19-resultado-positivos-indre-2020-03-23.pdf
# 284 YUCATÁN M 0 17/03/2020 confirmado Contacto NA
# 287 YUCATÁN M 31 17/03/2020 confirmado Contacto NA
rows[
  rows$patient_id %in% c(
    "yucatan_m_0_17-03-2020_contacto_NA_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_22"
    ), c("age_fixed")
  ] <- 31

rows[
  rows$patient_id %in% c(
    "yucatan_m_0_17-03-2020_contacto_NA_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_22"
    ), c("date_age_fixed")
  ] <- "positivos_2020_03_23"


#http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-03-20.txt
#http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-03-23.txt
#line 142 was changd from contact to Estados Unidos
#142    QUINTANA ROO      M   45   15/03/2020   confirmado     Contacto       15/03/2020
#143    QUINTANA ROO      M   45   15/03/2020   confirmado   Estados Unidos   15/03/2020
rows[
  rows$patient_id %in% c(
    "quintana-roo_m_45_15-03-2020_contacto_15-03-2020_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_20", "positivos_2020_03_21", "positivos_2020_03_22"
    ), c("origin_fixed")
  ] <- "ESTADOS UNIDOS"

rows[
  rows$patient_id %in% c(
    "quintana-roo_m_45_15-03-2020_contacto_15-03-2020_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_20", "positivos_2020_03_21", "positivos_2020_03_22"
    ), c("date_origin_fixed")
  ] <- "positivos_2020_03_23"


#http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-03-19.txt
#http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-03-20.txt
# chihuahua_m_30_12-03-2020_alemania_12-03-2020_1
#edad was changed from 30 to 29
#67      CHIHUAHUA        M   29   12/03/2020   confirmado      Alemania        12/03/2020
#66    CHIHUAHUA          M   30   12/03/2020 confirmado   Alemania         12/03/2020
rows[
  rows$patient_id %in% c(
    "chihuahua_m_30_12-03-2020_alemania_12-03-2020_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_17", "positivos_2020_03_18", "positivos_2020_03_19"
    ), c("age_fixed")
  ] <- 29

rows[
  rows$patient_id %in% c(
    "chihuahua_m_30_12-03-2020_alemania_12-03-2020_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_17", "positivos_2020_03_18", "positivos_2020_03_19"
    ), c("date_age_fixed")
  ] <- "positivos_2020_03_20"

#http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-03-20.txt
#http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-03-23.txt
# line 66 was changed from contacto to Alemania
#166    QUINTANA ROO    M   35   15/03/2020  confirmado     Contacto      14/03/2020
#167    QUINTANA ROO    M   35   15/03/2020  confirmado     Alemania      14/03/2020  

rows[
  rows$patient_id %in% c(
    "quintana-roo_m_35_15-03-2020_contacto_14-03-2020_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_20", "positivos_2020_03_21", "positivos_2020_03_22"
    ), c("origin_fixed")
  ] <- "ALEMANIA"

rows[
  rows$patient_id %in% c(
    "quintana-roo_m_35_15-03-2020_contacto_14-03-2020_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_20", "positivos_2020_03_21", "positivos_2020_03_22"
    ), c("date_origin_fixed")
  ] <- "positivos_2020_03_23"


# http://localhost:1313/data/results/covid-19-resultado-positivos-indre-2020-03-21.pdf
# http://localhost:1313/data/results/covid-19-resultado-positivos-indre-2020-03-26.pdf
# 232 JALISCO M 56 17/03/2020 confirmado Estados Unidos 04/03/2020
# 240 JALISCO M 58 17/03/2020 confirmado Estados Unidos 04/03/2020

rows[
  rows$patient_id %in% c(
    "jalisco_m_56_17-03-2020_estados-unidos_04-03-2020_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_21", "positivos_2020_03_22", "positivos_2020_03_23", "positivos_2020_03_24",
      "positivos_2020_03_25"
    ), c("age_fixed")
  ] <- 58

rows[
  rows$patient_id %in% c(
    "jalisco_m_56_17-03-2020_estados-unidos_04-03-2020_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_21", "positivos_2020_03_22", "positivos_2020_03_23", "positivos_2020_03_24",
      "positivos_2020_03_25"
    ), c("date_age_fixed")
  ] <- "positivos_2020_03_26"


#http://localhost:1313/data/results/covid-19-resultado-positivos-indre-2020-03-22.pdf
#http://localhost:1313/data/results/covid-19-resultado-positivos-indre-2020-03-24.pdf
# 
#250 JALISCO M 0 09/03/2020 confirmado España 12/03/2020
#253 JALISCO M 55 09/03/2020 confirmado España 12/03/2020
rows[
  rows$patient_id %in% c(
    "jalisco_m_0_09-03-2020_espana_12-03-2020_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_22", "positivos_2020_03_23"
    ), c("age_fixed")
  ] <- 55

rows[
  rows$patient_id %in% c(
    "jalisco_m_0_09-03-2020_espana_12-03-2020_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_22", "positivos_2020_03_23"
    ), c("date_age_fixed")
  ] <- "positivos_2020_03_24"  


#http://localhost:1313/data/results/covid-19-resultado-positivos-indre-2020-03-22.pdf
#http://localhost:1313/data/results/covid-19-resultado-positivos-indre-2020-03-23.pdf
# jalisco_m_24_17-03-2020_NA_15-03-2020_si1 
# 304 JALISCO M 24 17/03/2020 confirmado Contacto 15/03/2020
# 311 JALISCO M 24 17/03/2020 confirmado Estados Unidos 15/03/2020

rows[
  rows$patient_id %in% c(
    "jalisco_m_24_17-03-2020_contacto_15-03-2020_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_22"
    ), c("origin_fixed")
  ] <- "ESTADOS UNIDOS"

rows[
  rows$patient_id %in% c(
    "jalisco_m_24_17-03-2020_contacto_15-03-2020_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_22"
    ), c("date_origin_fixed")
  ] <- "positivos_2020_03_23"


# 355 QUINTANA ROO F 21 18/03/2020 confirmado Contacto 18/03/2020


#http://localhost:1313/data/results/covid-19-resultado-positivos-indre-2020-03-24.pdf
#
#339 CIUDAD DE MÉXICO M 60 18/03/2020 confirmado Contacto NA

#http://localhost:1313/data/results/covid-19-resultado-positivos-indre-2020-03-26.pdf
#574 MÉXICO F 48 16/03/2020 confirmado Contacto NA


#http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-03-27.txt
#http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-04-03.txt
#614       TLAXCALA       M   56   22/03/2020   confirmado   Estados Unidos   21/03/2020
#629       TLAXCALA       F   56   22/03/2020   Confirmado   Estados Unidos   21/03/2020

rows[
  rows$patient_id %in% c(
    "tlaxcala_m_56_22-03-2020_estados-unidos_21-03-2020_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_27", "positivos_2020_03_28", "positivos_2020_03_29", 
      "positivos_2020_03_30", "positivos_2020_03_31", "positivos_2020_04_01",
      "positivos_2020_04_02"
    ), c("sex_fixed")
  ] <- "F"

rows[
  rows$patient_id %in% c(
    "tlaxcala_m_56_22-03-2020_estados-unidos_21-03-2020_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_27", "positivos_2020_03_28", "positivos_2020_03_29", 
      "positivos_2020_03_30", "positivos_2020_03_31", "positivos_2020_04_01",
      "positivos_2020_04_02"
    ), c("date_sex_fixed")
  ] <- "positivos_2020_04_03"



#http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-03-30.txt
#http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-03-31.txt
#1043       COAHUILA         F   46   24/03/2020   confirmado   Estados Unidos   22/03/2020
#1066       COAHUILA         F   76   24/03/2020   confirmado   Estados Unidos   22/03/2020
rows[
  rows$patient_id %in% c(
    "coahuila_f_46_24-03-2020_estados-unidos_22-03-2020_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_30"
    ), c("age_fixed")
  ] <- 76

rows[
  rows$patient_id %in% c(
    "coahuila_f_46_24-03-2020_estados-unidos_22-03-2020_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_30"
    ), c("date_age_fixed")
  ] <- "positivos_2020_03_31"


#http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-03-29.txt
#http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-03-31.txt
#892       SINALOA        M   55   22/03/2020   confirmado     Contacto          NA
#893           SINALOA        M   85   22/03/2020   confirmado     Contacto          NA

rows[
  rows$patient_id %in% c(
    "sinaloa_m_55_22-03-2020_contacto_NA_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_29", "positivos_2020_03_30"
    ), c("age_fixed")
  ] <- 85

rows[
  rows$patient_id %in% c(
    "sinaloa_m_55_22-03-2020_contacto_NA_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_29", "positivos_2020_03_30"
    ), c("date_age_fixed")
  ] <- "positivos_2020_03_31"



#http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-03-23.txt
#http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-03-24.txt
#355          QUINTANA ROO          F         21          18/03/2020             confirmado             Contacto       18/03/2020
#367     QUINTANA ROO        F   21   18/03/2020   confirmado   Estados Unidos   18/03/2020

rows[
  rows$patient_id %in% c(
    "quintana-roo_f_21_18-03-2020_contacto_18-03-2020_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_23"
    ), c("origin_fixed")
  ] <- "ESTADOS UNIDOS"

rows[
  rows$patient_id %in% c(
    "quintana-roo_f_21_18-03-2020_contacto_18-03-2020_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_23"
    ), c("date_origin_fixed")
  ] <- "positivos_2020_03_24"


#http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-04-02.txt
#http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-03-22.txt
#135       MÉXICO         F   52   10/03/2020   confirmado      España        12/03/2020
#156       MÉXICO         F   52   10/03/2020   Confirmado      España        12/03/2020
#mexico_f_52_10-03-2020_espana_12-03-2020_1  

rows[
  rows$patient_id %in% c(
    "mexico_f_52_10-03-2020_espana_12-03-2020_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_20",
      "positivos_2020_03_21", "positivos_2020_03_22", "positivos_2020_03_23", 
      "positivos_2020_03_24", "positivos_2020_03_25", "positivos_2020_03_26", 
      "positivos_2020_03_27", "positivos_2020_03_28", "positivos_2020_03_29", 
      "positivos_2020_03_30", "positivos_2020_03_31", "positivos_2020_04_01", 
      "positivos_2020_04_02"
    ), c("date_removed")
  ] <- "positivos_2020_04_03"


#http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-03-15.txt
#10 PUEBLA  M 47  08/03/2020  confirmado Italia 04/03/2020

rows[
  rows$patient_id %in% c(
    "puebla_m_47_08-03-2020_italia_04-03-2020_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_15"
    ), c("date_removed")
  ] <- "positivos_2020_03_16"


#http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-03-26.txt
#576  MÉXICO  F   33   22/03/2020   confirmado   Contacto      NA

rows[
  rows$patient_id %in% c(
    "mexico_f_33_22-03-2020_contacto_NA_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_26", "positivos_2020_03_27", "positivos_2020_03_28", 
      "positivos_2020_03_29", "positivos_2020_03_30", "positivos_2020_03_31",
      "positivos_2020_04_01"
    ), c("date_removed")
  ] <- "positivos_2020_04_02"


# 1184      JALISCO          M   46   17/03/2020   confirmado     Contacto          NA
# http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-03-31.txt
rows[
  rows$patient_id %in% c(
    "jalisco_m_46_17-03-2020_contacto_NA_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_31"
    ), c("date_removed")
  ] <- "positivos_2020_04_01"



# 585        CHIAPAS          F   32   20/03/2020   confirmado   Estados Unidos   07/03/2020
# http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-03-27.txt

rows[
  rows$patient_id %in% c(
    "chiapas_f_32_20-03-2020_estados-unidos_07-03-2020_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_27"
    ), c("date_removed")
  ] <- "positivos_2020_03_28"


# 640       MÉXICO         F   31   19/03/2020   confirmado     Contacto          NA
# http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-03-27.txt

rows[
  rows$patient_id %in% c(
    "mexico_f_31_19-03-2020_contacto_NA_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_26", "positivos_2020_03_27", "positivos_2020_03_28",
      "positivos_2020_03_29", "positivos_2020_03_30", "positivos_2020_03_31"
    ), c("date_removed")
  ] <- "positivos_2020_04_01"


# http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-03-26.txt
# 339   CIUDAD DE MÉXICO   M   60   18/03/2020   confirmado   Contacto      NA

rows[
  rows$patient_id %in% c(
    "ciudad-de-mexico_m_60_18-03-2020_contacto_NA_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_24", "positivos_2020_03_25", "positivos_2020_03_26"
    ), c("date_removed")
  ] <- "positivos_2020_03_27"


# http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-03-25.txt
# 302       JALISCO        M   31   18/03/2020   confirmado   Estados Unidos   08/03/2020
rows[
  rows$patient_id %in% c(
    "jalisco_m_31_18-03-2020_estados-unidos_08-03-2020_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_22", "positivos_2020_03_23", "positivos_2020_03_24",
      "positivos_2020_03_25"
    ), c("date_removed")
  ] <- "positivos_2020_03_26"


# http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-03-26.txt
# 574               MÉXICO                      F   48   16/03/2020   confirmado   Contacto      NA

rows[
  rows$patient_id %in% c(
    "mexico_f_48_16-03-2020_contacto_NA_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_26", "positivos_2020_03_27", "positivos_2020_03_28",
      "positivos_2020_03_29", "positivos_2020_03_30", "positivos_2020_03_31"
    ), c("date_removed")
  ] <- "positivos_2020_04_01"



# http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-03-26.txt
# 575 MÉXICO  M   60   20/03/2020   confirmado   Contacto      NA
rows[
  rows$patient_id %in% c(
    "mexico_m_60_20-03-2020_contacto_NA_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_26", "positivos_2020_03_27", "positivos_2020_03_28",
      "positivos_2020_03_29", "positivos_2020_03_30", "positivos_2020_03_31"
    ), c("date_removed")
  ] <- "positivos_2020_04_01"



#573  MÉXICO  F   31   21/03/2020   confirmado   Contacto      NA
#http://localhost:1313/data/results/txt/covid-19-resultado-positivos-indre-2020-03-26.txt
rows[
  rows$patient_id %in% c(
    "mexico_f_31_21-03-2020_contacto_NA_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_26", "positivos_2020_03_27", "positivos_2020_03_28",
      "positivos_2020_03_29", "positivos_2020_03_30", "positivos_2020_03_31",
      "positivos_2020_04_01"
    ), c("date_removed")
  ] <- "positivos_2020_04_02"



#1194 COAHUILA F 0 28/03/2020 Confirmado Contacto NA
#1189 COAHUILA F 37 28/03/2020 Confirmado Contacto NA
#http://localhost:1313/data/results/covid-19-resultado-positivos-indre-2020-04-03.pdf
#http://localhost:1313/data/results/covid-19-resultado-positivos-indre-2020-04-04.pdf
rows[
  rows$patient_id %in% c(
    "coahuila_f_0_28-03-2020_contacto_NA_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_31", "positivos_2020_04_01", "positivos_2020_04_02",
      "positivos_2020_04_03"
    ), c("age_fixed")
  ] <- 37

rows[
  rows$patient_id %in% c(
    "coahuila_f_0_28-03-2020_contacto_NA_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_31", "positivos_2020_04_01", "positivos_2020_04_02",
      "positivos_2020_04_03"
    ), c("date_age_fixed")
  ] <- "positivos_2020_04_04"



#638 MÉXICO M 37 21/03/2020 Confirmado Contacto NA
#http://localhost:1313/data/results/covid-19-resultado-positivos-indre-2020-04-03.pdf

rows[
  rows$patient_id %in% c(
    "mexico_m_37_21-03-2020_contacto_NA_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_26", "positivos_2020_03_27", "positivos_2020_03_28",
      "positivos_2020_03_29", "positivos_2020_03_30", "positivos_2020_03_31",
      "positivos_2020_04_01", "positivos_2020_04_02", "positivos_2020_04_03"
    ), c("date_removed")
  ] <- "positivos_2020_04_04"



# 633 MÉXICO F 22 24/03/2020 Confirmado Contacto NA
#http://localhost:1313/data/results/covid-19-resultado-positivos-indre-2020-04-03.pdf
rows[
  rows$patient_id %in% c(
    "mexico_f_22_24-03-2020_contacto_NA_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_26", "positivos_2020_03_27", "positivos_2020_03_28",
      "positivos_2020_03_29", "positivos_2020_03_30", "positivos_2020_03_31",
      "positivos_2020_04_01", "positivos_2020_04_02", "positivos_2020_04_03"
    ), c("date_removed")
  ] <- "positivos_2020_04_04"


# 634 MÉXICO F 22 16/03/2020 Confirmado Contacto 15/03/2020
#http://localhost:1313/data/results/covid-19-resultado-positivos-indre-2020-04-03.pdf
rows[
  rows$patient_id %in% c(
    "mexico_f_22_16-03-2020_contacto_15-03-2020_1"
  ) & 
    rows$file_id %in% c(
      "positivos_2020_03_26", "positivos_2020_03_27", "positivos_2020_03_28",
      "positivos_2020_03_29", "positivos_2020_03_30", "positivos_2020_03_31",
      "positivos_2020_04_01", "positivos_2020_04_02", "positivos_2020_04_03"
    ), c("date_removed")
  ] <- "positivos_2020_04_04"
