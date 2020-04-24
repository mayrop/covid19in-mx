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
