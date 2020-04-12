---
author: "Mayra Valdes"
date: 2020-04-10
linktitle: Normalization for the State column
title: State Normalization
weight: 1
lang:
    es: /docs/datos/tablas-casos/normalizacion/estado/
bookToc: false
---

## Format
The format for the state for the column _Estado_ will be the 3-letter [ISO code](https://www.iso.org/obp/ui/#iso:code:3166:MX).

## Inconsistencies with the column `Estado`

In some of the original documents, the names of the Mexico state had different values. Some of them were published with uppercase letters, some others in lowercase, some of them had accents and so on. Today, (April 10th) there are 66 different values in the column `Estado`. 

```r
> rows %>% 
+   dplyr::filter(
+     grepl("SAN|San", Estado)
+   ) %>%
+   dplyr::pull(Estado) %>%
+   unique()
[1] SAN LUIS POTOSÍ SAN LUIS POTOSI San Luis Potosí
66 Levels: CHIAPAS CIUDAD DE MÉXICO COAHUILA DURANGO MÉXICO MÉXICO* NUEVO LEÓN ... 1
```

In addition, from March 12 to March 15, there is an additional `*` appended next to the state. This was as indication that the case was marked as recovered. What comes to my attention is that in the table of suspected cases for [March 12th](https://datos.covid19in.mx/tablas-diarias/sospechosos/202003/20200312.pdf), there was a case in Sinaloa that was marked as recovered before it was marked as positive:
```r
> rows %>% 
+   dplyr::filter(
+     grepl("\\*", Estado)
+   ) %>%
+   dplyr::select(
+     File_Id, Estado, Caso, Sexo, Edad,
+     Fecha_Sintomas_Normalizado
+   )
                 File_Id    Estado Caso Sexo Edad Fecha_Sintomas_Normalizado
1   positivos_2020_03_13  SINALOA*    2    M   41                 2020-02-22
2   positivos_2020_03_13   MÉXICO*    6    M   71                 2020-02-21
3   positivos_2020_03_14  SINALOA*    2    M   41                 2020-02-22
4   positivos_2020_03_14   MÉXICO*    6    M   71                 2020-02-21
5   positivos_2020_03_15  SINALOA*    2    M   41                 2020-02-22
6   positivos_2020_03_15 COAHUILA*    4    F   20                 2020-02-27
7   positivos_2020_03_15   MÉXICO*    6    M   71                 2020-02-21
8 sospechosos_2020_03_12  Sinaloa*   10    F   29                 2020-03-08
```

If we read the notes at the end of the PDF we can find: `*Recuperado al dar negativo en su muestra a los 14 días de seguimiento` (Recovered by testing negative on the sample after 14 days of follow-up). If the symptoms date started on March 8th, then the 14 days found in the footnotes do not make a lot of sense. This seems like an error in the original file.

One of the important changes is that on [April 6](https://datos.covid19in.mx/tablas-diarias/positivos/202004/20200406.pdf) the value of `Ciudad de México` was changed for the first time to `Distrito Federal`:

```r
> rows %>% 
+   dplyr::filter(
+     grepl("Distrito", Estado, ignore.case=TRUE)
+   ) %>%
+   dplyr::pull(File_Id) %>%
+   unique()
[1] "positivos_2020_04_06"   "sospechosos_2020_04_06"
```

And we can observe that there is no reference to `Ciudad de México` in such files:
```r
> rows %>% 
+   dplyr::filter(
+     grepl("Ciudad", Estado, ignore.case=TRUE) &
+       File_Id %in% c("positivos_2020_04_06", "sospechosos_2020_04_06")
+   ) %>% nrow() 
[1] 0
```

For these reasons, a new `Estado_Normalizado` column was added, which has the 3-letter [ISO code](https://www.iso.org/obp/ui/#iso:code:3166:MX) for each state.
