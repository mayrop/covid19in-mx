---
author: "Mayra Valdes"
date: 2020-04-04
linktitle: Series de Tiempo
title: Series de Tiempo
weight: 10
js: "/js/series-de-tiempo.js"
bookCollapseSection: true
---

# Series de Tiempo

Como se ha mencionado anteriormente, la Secretaría de Salud de México publica diariamente los casos positivos y sospechosos en [esta URL](https://www.gob.mx/salud/documentos/coronavirus-covid-19-comunicado-tecnico-diario-238449). Sin embargo, no publica en formato abierto la cantidad de casos negativos y defunciones desagregados por estado. Por otro lado, publican en este mapa se puede apreciar la cantidad de casos negativos y defunciones por estado. La información de este mapa (JSON) es [extraída y parseada](https://github.com/mayrop/datos-covid19in-mx/blob/master/scripts/processing/parse_ajax.py), para después poder proporcionar la información en diferentes formatos. 

**Nota:** La información de casos negativos se ha obtenido solo desde el [4 de Abril, 2020](https://github.com/mayrop/datos-covid19in-mx/tree/master/scripts/cache/mapa). Se planea publicar pronto una API con dicha información.

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
