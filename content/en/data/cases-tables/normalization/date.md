---
author: "Mayra Valdes"
date: 2020-04-10
linktitle: Normalization for the Date columns
title: Date Normalization
lang:
    es: /datos/comunicado-tecnico-diario/normalizacion/fecha/
weight: 3
---

## Format
Dates for the _Inicio de Fecha de Síntomas_ and _Fecha de llegada a México_ columns will have the `YYYY-MM-DD` [ISO format](https://www.iso.org/iso-8601-date-and-time-format.html).


## Inconsistencies with the Date columns

The first challenge and terrible error with the original data, is that some of them have the date in a different format, with 5 numbers instead of the format that they usually publish: `DD/MM/YYYY`. For example, the following can be found in the table of positive cases published on [April 8](https://datos.covid19in.mx/tablas-diarias/positivos/202004/20200408.pdf) in the 2476 row. The date of first symptoms appears as `43911`:

![Case with the date in different format](/images/metodologia/caso01.png)

The documents that have at least one of this type of inconsistency are:
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

## Fixing the 5-digit date

Apparently, the numbers taht we find is not an error, it is simply the date in a different format from [Excel](https://gizmokid2005.com/2013/05/convert-excel-5-digit-serial-date-numbers-to-date), which represents the days since January 1st, 1900. The solution for the fix can be found in [Stack Overflow](https://stackoverflow.com/questions/14271791/converting-date-formats-python-unusual-date-formats-extract-ymd/30058862#30058862) to convert such number to a date with ISO format. Below you can find the code in Python code to fix such number:

```Python
def fix_date(text):
    if not is_date_in_excel_format(text):
        print("Date is not in excel format")
        return text
    
    delta = datetime.timedelta(int(text.strip())-2)
    date = datetime.date(1900, 1, 1) + delta
    date = str(date.strftime('%Y-%m-%d'))
    
    return date


def is_date_in_excel_format(text):
    return re.search(r'^(\d{5})$', text)

print(fix_date('43911'))
> 2020-03-21
```

Now we can proceed to verify that the dates that we are updating are actually correct. We can find in the [CSV file](https://datos.covid19in.mx/tablas-diarias/positivos/202004/20200408.csv) from the same date how the date was fixed in the `Fecha_Sintomas_Normalizado` column, with a value of `2020-03-21`:
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


## Solution Verification
We can verify that the data was fixed correctly since, on April 9, the dates were fixed in the original source. The same case can be found in the row `2666`. 

![Case with the date in fixed format](/images/metodologia/caso02.png)

We can check that this case is the only one with the same characteristics
(M, age of 71, from Yucatán):
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
