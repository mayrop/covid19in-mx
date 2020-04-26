---
author: "Mayra Valdes"
date: 2020-04-23
linktitle: Series de Tiempo
title: Series de Tiempo
weight: 4
js: /js/series-de-tiempo.js
lang:
    en: /en/data/time-series/
---

Como se detalla en la sección de [fuentes de información](/datos/fuentes-de-informacion/), los datos de este sitio provienen de fuentes oficiales. 

**Nota:** Las series de tiempo se generan a partir de los [datos abiertos](/datos/datos-abiertos-covid-19/) desde el 12 de Abril de 2020. Los datos anteriores provienen del [Mapa Interactivo de México Coronavirus (COVID-19)](https://covid19.sinave.gob.mx/). 

**Nota:** Es importante hacer notar que los datos segregados por estado provienen de la columna `ENTIDAD_UM`, la cuál identifica la entidad donde se ubica la unidad medica que brindó la atención. Esta misma columna es la que usaba la Secretaría de Salud en sus datos diarios hasta el 21 de Abril de 2020, cuando cambiaron su manera de reportar por estado a la columna `ENTIDAD_RES`, que identifica la entidad federativa de residencia de cada paciente. Hablo más al respecto [aquí](https://twitter.com/mayrop/status/1253101360830124033).

{{< custom-element "mySeries" >}}{{< /custom-element >}}

## Datos para Descargar

### Por Fecha
{{< timeseries-aggr "uniqueid" >}}
{{< /timeseries-aggr >}}

### Por Estado
{{< timeseries-state "uniqueid" >}}
{{< /timeseries-state >}}

### Por Fecha
{{< timeseries-date "uniqueid" >}}
{{< /timeseries-date >}}

## Formato

### Por Fecha (totales a nivel nacional)
| Fecha      | Positivos | Positivos_Delta | Sospechosos | Sospechosos_Delta | Negativos | Negativos_Delta | Defunciones_Positivos | Defunciones_Positivos_Delta | Defunciones_Sospechosos | Defunciones_Sospechosos_Delta | Defunciones_Negativos | Defunciones_Negativos_Delta | Positivos_Sintomas_14_Dias | Sospechosos_Sintomas_14_Dias | Negativos_Sintomas_14_Dias | Positivos_Sintomas_7_Dias | Sospechosos_Sintomas_7_Dias | Negativos_Sintomas_7_Dias |
|------------|-----------|-----------------|-------------|-------------------|-----------|-----------------|-----------------------|-----------------------------|-------------------------|-------------------------------|-----------------------|-----------------------------|----------------------------|------------------------------|----------------------------|---------------------------|-----------------------------|---------------------------|
| 2020-02-27 | 1         | 0               | 1           | 0                 | 22        | 0               | 0                     | 0                           | 0                       | 0                             | 0                     | 0                           | 0                          | 0                            | 0                          | 0                         | 0                           | 0                         |
| 2020-02-28 | 3         | 2               | 3           | 2                 | 37        | 15              | 0                     | 0                           | 0                       | 0                             | 0                     | 0                           | 0                          | 0                            | 0                          | 0                         | 0                           | 0                         |
| 2020-02-29 | 4         | 1               | 8           | 5                 | 46        | 9               | 0                     | 0                           | 0                       | 0                             | 0                     | 0                           | 0                          | 0                            | 0                          | 0                         | 0                           | 0                         |
| 2020-03-01 | 5         | 1               | 11          | 3                 | 60        | 14              | 0                     | 0                           | 0                       | 0                             | 0                     | 0                           | 0                          | 0                            | 0                          | 0                         | 0                           | 0                         |
| 2020-03-02 | 5         | 0               | 21          | 10                | 69        | 9               | 0                     | 0                           | 0                       | 0                             | 0                     | 0                           | 0                          | 0                            | 0                          | 0                         | 0                           | 0                         |
| 2020-03-03 | 5         | 0               | 39          | 18                | 75        | 6               | 0                     | 0                           | 0                       | 0                             | 0                     | 0                           | 0                          | 0                            | 0                          | 0                         | 0                           | 0                         |


### Por Fecha (todos los datos fecha/estado)
| Fecha      | Estado | Positivos | Positivos_Delta | Sospechosos | Sospechosos_Delta | Negativos | Negativos_Delta | Defunciones_Positivos | Defunciones_Positivos_Delta | Defunciones_Sospechosos | Defunciones_Sospechosos_Delta | Defunciones_Negativos | Defunciones_Negativos_Delta | Positivos_Sintomas_14_Dias | Sospechosos_Sintomas_14_Dias | Negativos_Sintomas_14_Dias | Positivos_Sintomas_7_Dias | Sospechosos_Sintomas_7_Dias | Negativos_Sintomas_7_Dias |
|------------|--------|-----------|-----------------|-------------|-------------------|-----------|-----------------|-----------------------|-----------------------------|-------------------------|-------------------------------|-----------------------|-----------------------------|----------------------------|------------------------------|----------------------------|---------------------------|-----------------------------|---------------------------|
| 2020-02-27 | AGU    | 0         | 0               |             | 0                 |           | 0               | 0                     | 0                           | 0                       | 0                             | 0                     | 0                           | 0                          | 0                            | 0                          | 0                         | 0                           | 0                         |
| 2020-02-27 | BCN    | 0         | 0               |             | 0                 |           | 0               | 0                     | 0                           | 0                       | 0                             | 0                     | 0                           | 0                          | 0                            | 0                          | 0                         | 0                           | 0                         |
| 2020-02-27 | BCS    | 0         | 0               |             | 0                 |           | 0               | 0                     | 0                           | 0                       | 0                             | 0                     | 0                           | 0                          | 0                            | 0                          | 0                         | 0                           | 0                         |
| 2020-02-27 | CAM    | 0         | 0               |             | 0                 |           | 0               | 0                     | 0                           | 0                       | 0                             | 0                     | 0                           | 0                          | 0                            | 0                          | 0                         | 0                           | 0                         |
| 2020-02-27 | CHH    | 0         | 0               |             | 0                 |           | 0               | 0                     | 0                           | 0                       | 0                             | 0                     | 0                           | 0                          | 0                            | 0                          | 0                         | 0                           | 0                         |
