---
author: "Mayra Valdes"
date: 2020-04-18
linktitle: Población de México a Nivel Municipal y Estatal (2019)
title: Población
weight: 6
---

{{< hint info >}}
**Nota:** Datos disponibles a través del [Paquete R](https://github.com/mayrop/datosmx)! :)
{{< /hint >}}

Como se menciona en las [fuentes de información](/fuentes-de-informacion/), se tiene una base datos en formato CSV de la población de [2457 municipios](https://raw.githubusercontent.com/mayrop/datos-covid19in-mx/master/www/otros/municipios.csv) y [32 entidades federativas](https://raw.githubusercontent.com/mayrop/datos-covid19in-mx/master/www/otros/estados.csv) de México del año 2019. Obtenida de las [Proyecciones de la Población de los Municipios de México, 2015-2030](https://datos.gob.mx/busca/dataset/proyecciones-de-la-poblacion-de-mexico-y-de-las-entidades-federativas-2016-2050/resource/0cda121e-5e8f-48a0-9468-d2cc921f3f3c?inner_span=True) generada por el Consejo Nacional de Población (CONAPO). Descargada el día 15 de Abril de 2020 (en donde los datos tienen fecha última de actualización del 23 de Agosto de 2019). **_Nota:_** _Existe un municipio (Puerto Morelos, Quintana Roo), el cual no esta disponible en la base de datos de las proyecciones de población (pero se puede encontrar en la base de datos del marco geoestadístico). Al parecer se encuentra [en vigor desde](https://es.wikipedia.org/wiki/Municipio_de_Puerto_Morelos) el 2016 (documento [oficial](https://web.archive.org/web/20151222080644/http://www.congresoqroo.gob.mx/historial/14_legislatura/decretos/3anio/1PO/dec342/D1420151029342.pdf))_.

**Fuente oficial**: [CONAPO](https://datos.gob.mx/busca/dataset/proyecciones-de-la-poblacion-de-mexico-y-de-las-entidades-federativas-2016-2050/resource/0cda121e-5e8f-48a0-9468-d2cc921f3f3c?inner_span=True).

## Datos Disponibles
* [Municipios de México](https://raw.githubusercontent.com/mayrop/datos-covid19in-mx/master/www/otros/ciudades.csv)
* [Entidades Federativas de México](https://raw.githubusercontent.com/mayrop/datos-covid19in-mx/master/www/otros/estados.csv)

## Formato

### Municipios de México
| Clave_Entidad | Clave_Municipio | Nombre                                            | Longitud     | Latitud    | Poblacion_2019 |
|---------------|-----------------|---------------------------------------------------|--------------|------------|----------------|
| 1             | 1               | Aguascalientes                                    | -102.2958029 | 21.8114362 | 949277         |
| 1             | 2               | Asientos                                          | -102.0456381 | 22.1265082 | 50354          |
| 1             | 3               | Calvillo                                          | -102.7049039 | 21.9006945 | 60181          |
| 1             | 4               | Cosío                                             | -102.2970417 | 22.3606267 | 16766          |
| 1             | 5               | Jesús María                                       | -102.4456493 | 21.9321175 | 127835         |

### Entidades Federativas de México
| Clave | Nombre              | Nombre_Mayuscula    | Nombre_Completo                 | Abreviatura | ISO_3 | ISO_2 | Longitud     | Latitud    | Poblacion_2019 |
|-------|---------------------|---------------------|---------------------------------|-------------|-------|-------|--------------|------------|----------------|
| 1     | Aguascalientes      | AGUASCALIENTES      | Aguascalientes                  | Ags.        | AGU   | AS    | -102.3619377 | 22.0064411 | 1415421        |
| 2     | Baja California     | BAJA CALIFORNIA     | Baja California                 | B. C.       | BCN   | BC    | -115.0970657 | 30.5515922 | 3578561        |
| 3     | Baja California Sur | BAJA CALIFORNIA SUR | Baja California Sur             | B. C. S.    | BCS   | BS    | -112.0662031 | 25.9187109 | 788119         |
| 4     | Campeche            | CAMPECHE            | Campeche                        | Camp.       | CAM   | CC    | -90.3602773  | 18.8405542 | 984046         |
| 5     | Coahuila            | COAHUILA            | Coahuila de Zaragoza            | Coah.       | COA   | CL    | -102.0440387 | 27.295443  | 3175643        |
