---
author: "Mayra Valdes"
date: 2020-04-10
linktitle: Normalización de la columnas con Fechas 
title: Normalización de Fechas
weight: 3
---

## Formato
Las fechas para las columnas _Inicio de Fecha de Síntomas_ y _Fecha de llegada a México_ se encontrarán en [formato ISO](https://www.iso.org/iso-8601-date-and-time-format.html) `YYYY-MM-DD`.


## Inconsistencias en las columnas de Fecha

El primer reto y terrible error de los documentos originales, es que algunos de ellos tienen la fecha en un formato diferente, con 5 numeros en vez del formato que comunmente publican `MM/DD/YYYY`. Por ejemplo, lo siguiente se puede encontrar en el documento de la tabla de positivos publicado el [8 de Abril](https://datos.covid19in.mx/tablas-diarias/positivos/202004/20200408.pdf) en la fila 2476. La fecha de inicio de síntomas aparece como `43911`:

![Caso con la fecha en formato diferente](/images/metodologia/caso01.png)

Los documentos que tienen por lo menos una inconsistencia de este tipo son:
```r
> rows %>% 
+   dplyr::filter(Fecha_Sintomas_Corregido == TRUE) %>% 
+   dplyr::pull(File_Id) %>% 
+   unique()

 [1] "positivos_2020_04_07"   "positivos_2020_04_08"   "sospechosos_2020_03_13"
 [4] "sospechosos_2020_03_14" "sospechosos_2020_03_27" "sospechosos_2020_03_28"
 [7] "sospechosos_2020_03_29" "sospechosos_2020_03_31" "sospechosos_2020_04_01"
[10] "sospechosos_2020_04_02" "sospechosos_2020_04_03" "sospechosos_2020_04_04"
[13] "sospechosos_2020_04_06" "sospechosos_2020_04_07" "sospechosos_2020_04_08"
```

## Solución de las fechas en formato Excel

La solución que se uso se puede encontrar en el sitio de [Stack Overflow](https://stackoverflow.com/questions/14271791/converting-date-formats-python-unusual-date-formats-extract-ymd/30058862#30058862).

Ahora vamos a proceder a verificar que las fechas se esten actualizando correctamente. Podemos observar en el [archivo CSV](https://datos.covid19in.mx/tablas-diarias/positivos/202004/20200408.csv) de la misma fecha como se corrigió en la columna `Fecha_Sintomas_Normalizado` a `2020-03-21`. Esto se puede observar via código R:
```r
> rows %>%
+   dplyr::filter(
+     File_Id == "positivos_2020_04_08" &
+     Edad == 71 & 
+     Estado_Normalizado == "YUC"
+   ) %>%
+   dplyr::select(
+     File_Id, Caso, Estado, Sexo, Edad, 
+     Fecha_Sintomas, Fecha_Sintomas_Normalizado
+   )
  Caso  Estado      Sexo Edad Fecha_Sintomas Fecha_Sintomas_Normalizado
1 2476 YUCATÁN MASCULINO   71          43911                 2020-03-21
```


## Verificación de la solución
Podemos verificar que dichos datos fueron corregidos correctamente dado que, posteriormente, el día 9 de Abril, las fechas fueron corregidas en el documento aficial. El mismo caso puede observarse en la fila `2666`. 

![Caso con la fecha en formato corregido](/images/metodologia/caso02.png)

Podemos comprobar que dicho caso es el único con las caracteristicas (Sexo Masculino, Edad 71 del estado de Yucatán):
```r
> rows %>%
+   dplyr::filter(
+     File_Id == "positivos_2020_04_09" &
+       Edad == 71 & 
+       Estado_Normalizado == "YUC"
+   ) %>%
+   dplyr::select(
+     File_Id, Caso, Estado, Sexo, Edad, 
+     Fecha_Sintomas, Fecha_Sintomas_Normalizado
+   )
  Caso  Estado      Sexo Edad Fecha_Sintomas Fecha_Sintomas_Normalizado
1 2666 YUCATÁN MASCULINO   71     21/03/2020                 2020-03-21
```
