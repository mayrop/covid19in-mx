---
author: "Mayra Valdes"
date: 2020-04-10
linktitle: Normalization for the Sex (Gender) column
title: Gender Normalization
weight: 2
lang:
    es: /datos/comunicado-tecnico-diario/normalizacion/genero/
bookToc: false
---

## Format
The format for the gender column _Sexo_ will have a value of `M` for Masculine Gender and `F` for Femenine.

## Inconsistencies with the column `Sex`

Apparently, the Sex columns are not consistents, they have different values:
```r
> table(rows$Sexo)
        F         M  FEMENINO MASCULINO 
    32830     32347     22507     22453 
```

The column `Sexo_Normalizado` will have the normalized values `F` y `M`:
```r
> table(rows$Sexo_Normalizado)
    F     M 
55337 54800 
```

We can check that the inconsistency started after April 6 in both, positive and suspected tables:
```r
rows %>%
+   dplyr::filter(Sexo %in% c("MASCULINO", "FEMENINO")) %>%
+   dplyr::pull(File_Id) %>%
+   unique()
[1] "positivos_2020_04_06"   "positivos_2020_04_07"   "positivos_2020_04_08"  
[4] "positivos_2020_04_09"   "sospechosos_2020_04_06" "sospechosos_2020_04_07"
[7] "sospechosos_2020_04_08" "sospechosos_2020_04_09"
```

