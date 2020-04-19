---
author: "Mayra Valdes"
date: 2020-04-18
linktitle: Fuentes de Información
title: Fuentes de Información
weight: 10
bookFlatSection: true
js: /js/series-de-tiempo.js
lang:
    en: /en/data/time-series/
---

Las bases de datos (o datasets) encontrados en este sitio provienen de fuentes oficiales:
* [Datos Abiertos Coronavirus (COVID-19)](#datos-abiertos-coronavirus-covid-19)
* [Comunicado Técnico Diario Coronavirus (COVID-19)](#comunicado-técnico-diario-coronavirus-covid-19) 
* [Mapa Interactivo de México Coronavirus (COVID-19)](#mapa-interactivo-de-méxico-coronavirus-covid-19) 
* [Marco Geoestadístico de México](#marco-geoestadístico-de-méxico-)
* [Población de México a Nivel Municipal y Estatal](#población-de-méxico-a-nivel-municipal-y-estatal-)

-------------------------------------------------------------------------------

### Datos Abiertos Coronavirus (COVID-19)
Fuente Oficial: [Secretaría de Salud de México](https://www.gob.mx/salud/documentos/datos-abiertos-152127), Dirección General de Epidemiología

El día [13 de Abril de 2020](https://twitter.com/RicardoDGPS/status/1249864573936644096), la Secretaría de Salud de México, a través de la Dirección General de Epidemiología, publicó datos abiertos sobre casos asociados a COVID-19 con el propósito de facilitar a todos los usuarios que la requieran, el acceso, uso, reutilización y redistribución de la misma.

Disponibilidad:
* Datos disponibles en formato ZIP desde el 13/04/2020 después de que el Director General de Promoción de la Salud del Gobierno de México, [Ricardo Cortes Alcala](https://twitter.com/RicardoDGPS) anunciara [su disponibilidad](https://twitter.com/RicardoDGPS/status/1249864573936644096).

--------------------------------------------------------

### Comunicado Técnico Diario Coronavirus (COVID-19) 
Fuente Oficial: [Secretaría de Salud de México](https://www.gob.mx/salud/documentos/coronavirus-covid-19-comunicado-tecnico-diario-238449), Dirección General de Epidemiología

{{< hint warning >}}
**Nota** Se recomienda usar los datos abiertos, dado que los datos ese dataset es más completa.
{{< /hint >}}

Usado para las tablas diarias de casos positivos y sospechosos. Detalles [aquí](https://www.covid19in.mx/docs/datos/tablas-casos/).
Disponibilidad: 
* Datos diarios en formato PDF, CSV y TXT para casos positivos, desde el 13 de Marzo de 2020.
* Datos diarios en formato PDF, CSV y TXT para casos sospechosos, desde el 11 de Marzo de 2020. Se cuenta ademas con la tabla del dia 8 de Marzo, 2020.

**Notas:**
* **8 de Marzo**: Tabla de casos sospechosos. El documento fue encontrado en formato original PDF [aquí](https://slp.gob.mx/SSALUD/Documentos%20compartidos/Coronavirus/marzo/Tabla_casos_sospechosos_COVID-19_2020.03.08.pdf). Fue encontrado a través de exhaustas búsquedas en Google hasta encontrar [una interfaz](https://slp.gob.mx/SSALUD/Documentos%20compartidos/Forms/AllItems.aspx?RootFolder=%2FSSALUD%2FDocumentos%20compartidos%2FCoronavirus&FolderCTID=0x0120002C4A6E2BDD73D34899963849CA684C1C&View=%7BFA81CA67%2D551E%2D4BDD%2D9C03%2DCA3F799D0382%7D) del gobierno que probablemente no debería estar pública.
* **13 de Marzo**: Tabla de casos positivos. El documento fue encontrado en formato PNG [aquí](https://www.scribd.com/document/452680821/Tabla-casos-positivos-resultado-InDRE-2020-03-13).
* **14 al 28 de Marzo**: Dado que los documentos originales en formato PDF fueron removidos del sitio oficial de la Secretaría de Salud de México, los mismos fueron recopilados los repositorios de [Serendipia](https://serendipia.digital/2020/03/datos-abiertos-sobre-casos-de-coronavirus-covid-19-en-mexico/), [@guzmart](https://github.com/guzmart/covid19_mex) y [@carranco-sga](https://github.com/carranco-sga/Mexico-COVID-19), quienes inteligentemente archivaron una copia.

Los casos positivos en México empezaron el [27 de Febrero de 2020](https://twitter.com/HLGatell/status/1233245568668966913). Sin embargo, no se cuenta con datos anteriores a los que se están publicando dado que los documentos oficiales han sido removidos del sitio.

--------------------------------------------------------

### Mapa Interactivo de México Coronavirus (COVID-19)

Fuente Oficial: [Secretaría de Salud de México](https://covid19.sinave.gob.mx/), Dirección General de Epidemiología

Usado para obtener las series diarias de datos. Detalles [aquí](https://www.covid19in.mx/docs/datos/series-de-tiempo/).

Disponibilidad: 
* Datos segregados por fecha y estados en formato CSV para casos positivos y sospechosos están disponibles desde el 13/03/2020. Dichos datos fueron obtenidos a partir del Comunicado Técnico Diario.
* Datos segregados por fecha y estados en formato CSV por fecha y estados para casos positivos, sospechosos, negativos y defunciones a partir del mapa están disponibles desde el 4 de Abril de 2020. Los datos acumulados para los casos negativos y defunciones antes del 4 de Abril fueron capturados manualmente a partir del Comunicado Técnico Diario. Favor de reportar cualquier error via  [Twitter](https://twitter.com/mayrop) o como un issue en Github.

--------------------------------------------------------

### Marco Geoestadístico de México 🇲🇽 
* Fuente oficial: [INEGI](https://www.inegi.org.mx/app/biblioteca/ficha.html?upc=889463142683)

Se tiene una base de datos de [2458 municipios](https://raw.githubusercontent.com/mayrop/datos-covid19in-mx/master/www/otros/municipios.csv) de México, y otra de las [32 entidades federativas](https://raw.githubusercontent.com/mayrop/datos-covid19in-mx/master/www/otros/estados.csv) en México (31 estados y la Ciudad de México). Los datos presentados están en formato CSV con las coordenadas (centroides) correspondientes cada municipio (o estado), obtenidos a partir del Marco Geoestadístico, junio 2017, diseñado por el INEGI. Los mismos datos en formato SHP pueden encontrarse en la fuente oficial.

--------------------------------------------------------

### Población de México a Nivel Municipal y Estatal 🇲🇽 
* Fuente oficial: [CONAPO](https://datos.gob.mx/busca/dataset/proyecciones-de-la-poblacion-de-mexico-y-de-las-entidades-federativas-2016-2050/resource/0cda121e-5e8f-48a0-9468-d2cc921f3f3c?inner_span=True)

Se tiene una base datos en formato CSV de la población de [2457 municipios](https://raw.githubusercontent.com/mayrop/datos-covid19in-mx/master/www/otros/municipios.csv) y [32 entidades federativas](https://raw.githubusercontent.com/mayrop/datos-covid19in-mx/master/www/otros/estados.csv) de México del año 2019. Obtenida a partir de las [Proyecciones de la Población de los Municipios de México, 2015-2030](https://datos.gob.mx/busca/dataset/proyecciones-de-la-poblacion-de-mexico-y-de-las-entidades-federativas-2016-2050/resource/0cda121e-5e8f-48a0-9468-d2cc921f3f3c?inner_span=True) generada por el Consejo Nacional de Población (CONAPO). Descargada el día 15 de Abril de 2020 (en donde los datos tienen fecha última de actualización del 23 de Agosto de 2019). **_Nota:_** _Existe un municipio (Puerto Morelos, Quintana Roo), el cual no esta disponible en la base de datos de las proyecciones de población (pero se puede encontrar en la base de datos del marco geoestadístico). Al parecer se encuentra [en vigor desde](https://es.wikipedia.org/wiki/Municipio_de_Puerto_Morelos) el 2016 (documento [oficial](https://web.archive.org/web/20151222080644/http://www.congresoqroo.gob.mx/historial/14_legislatura/decretos/3anio/1PO/dec342/D1420151029342.pdf))_.
