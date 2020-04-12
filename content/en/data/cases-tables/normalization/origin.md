---
author: "Mayra Valdes"
date: 2020-04-10
linktitle: Normalization for the Origin column
title: Origin Normalization
weight: 4
lang:
    es: /docs/datos/tablas-casos/normalizacion/procedencia/
bookToc: false
---

## Inconsistencies with the column `Origin`
Today (April 10th), there are 65 different values in the _Procedencia_ column. I really doubt this number will change in the future given that they removed the Origin column on April 8th. What it is interesting is that on April 5, there were only 8 different values in both, positive and suspected tables:

```r
> rows %>% 
+   dplyr::group_by(File_Date, Type) %>%
+   dplyr::summarise(
+     N=unique(Procedencia) %>% length()
+   ) %>%
+   tidyr::spread(Type, N) %>%
+   dplyr::filter(
+     File_Date > "2020-04-01"
+   )
# A tibble: 8 x 3
# Groups:   File_Date [8]
  File_Date  positivos sospechosos
  <date>         <int>       <int>
1 2020-04-02         7           8
2 2020-04-03         7           9
3 2020-04-04         8           8
4 2020-04-05         8           8
5 2020-04-06        36          31
6 2020-04-07        31          30
7 2020-04-08         1           1
8 2020-04-09         1           1
```

Then, on April 6th, the number was increased to 36 since the format changed completely. I will be writing more about it soon. For now, it is enough to say that the column `Procedencia_Normalizado` will have the best effort of normalization of Origin column.
