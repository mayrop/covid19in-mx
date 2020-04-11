---
author: "Mayra Valdes"
date: 2020-04-10
linktitle: Normalización de la columna Estado
title: Normalización del Estado
weight: 1
bookToc: false
---

## Formato
El formato del estado para la columna _Estado_ se encontrará en código de 3 letras en [formato ISO](https://www.iso.org/obp/ui/#iso:code:3166:MX).

## Inconsistencias del formato de Estado

En algunos documentos originales, los nombres de las entidades federativas publicados diferían en acentos y nombres. Hasta hoy (10 de Abril) existen 66 valores diferentes en la columna Estado. Las diferencias mas notables es que en algunos documentos las entidades estan en mayúscula, en otras en minúscula, en algunas se agregan acento y en otras no. 

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

Del día 12 al 15 de Marzo se agregó un `*` a los casos como una medida para definir que dicho caso se habia recuperado. Lo que llama la atención es que la tabla de sospechosos del día [12 de Marzo](https://datos.covid19in.mx/tablas-diarias/sospechosos/202003/20200312.pdf) tenía declarado un caso de Sinaloa como recuperado antes de declararlo como positivo:
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

Si leyemos la leyenda al final del PDF podemos encontrar `*Recuperado al dar negativo en su muestra a los 14 días de seguimiento`. Si la fecha de los síntomas empezó el 8 de marzo, los 14 días de la leyenda no hacen mucho sentido. Este parece un error del archivo original.

Uno cambio de los importantes es que el día [6 de Abril](https://datos.covid19in.mx/tablas-diarias/positivos/202004/20200406.pdf) se cambió por primera vez `Ciudad de México` a `Distrito Federal`:

```r
> rows %>% 
+   dplyr::filter(
+     grepl("Distrito", Estado, ignore.case=TRUE)
+   ) %>%
+   dplyr::pull(File_Id) %>%
+   unique()
[1] "positivos_2020_04_06"   "sospechosos_2020_04_06"
```

Y podemos observar que no hay referencia de `Ciudad de México` en dichos archivos:
```r
> rows %>% 
+   dplyr::filter(
+     grepl("Ciudad", Estado, ignore.case=TRUE) &
+       File_Id %in% c("positivos_2020_04_06", "sospechosos_2020_04_06")
+   ) %>% nrow() 
[1] 0
```

Por esta razón, se agregó una columna `Estado_Normalizado` que contiene el [código ISO](https://www.iso.org/obp/ui/#iso:code:3166:MX) de tres letras de cada estado.
