---
author: "Mayra Valdes"
date: 2020-04-10
linktitle: Normalización de la Procedencia
title: Normalización de la Procedencia
weight: 4
bookToc: false
---

## Inconsistencias de formato de Procedencia
Hasta el día de hoy (10 de Abril), existen 65 valores distintos en la columna de Procedencia. Dudo que este número vaya a cambiar en un futuro (a menos de que se publiquen datos diferentes), dado que la columna Procedencia fue eliminada el 8 de Abril. Si sólo tomamos los valores de las tablas de positivos, entonces vemos que hay solo 36 valores. Lo que es interesante es que hasta el 5 de Abril solo existían 8 valores diferentes tanto en las tablas de casos positivos como en la tabla de casos sospechosos:

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

El día 6 de Abril subió a 36 dado que el formato completo cambió. Estaré escribiendo más al respecto muy pronto. Por ahora me bastará decir que la columna `Procedencia_Normalizado` se encuentra el mejor intento de normalización de los países de procedencia.

