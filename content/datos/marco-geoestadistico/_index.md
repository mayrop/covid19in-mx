---
author: "Mayra Valdes"
date: 2020-04-23
linktitle: Marco Geoestadístico de México
title: Marco Geoestadístico
weight: 5
---

{{< hint info >}}
**Nota:** Datos disponibles a través del [Paquete R](https://github.com/mayrop/datosmx)! :)
{{< /hint >}}

Como se menciona en las [fuentes de información](/fuentes-de-informacion/), se tiene una base de datos de 2458 municipios de México, y otra de las 32 entidades federativas en México (31 estados y la Ciudad de México). Los datos presentados están en formato CSV con las coordenadas (centroides) correspondientes cada municipio (y estado), obtenidos a partir del Marco Geoestadístico, junio 2017, diseñado por el INEGI. 

Se tiene además datos en formato SHP, las cuales contienen las siguientes capas de información: 32 polígonos de las Áreas Geoestadísticas Estatales (AGEE), 2458 polígonos de las Áreas Geoestadísticas Municipales (AGEM) en las que se incluyen las 16 Demarcaciones de la Ciudad de México. Cada elemento de estas capas cuenta con atributos de nombre y clave geoestadística. Dichos archivos [fueron simplificados](https://github.com/mayrop/datos-covid19in-mx/blob/master/scripts/analysis/geo_simplify.R) para disminuir su tamaño.

Los datos originales en formato SHP pueden encontrarse en la [fuente oficial](https://www.inegi.org.mx/app/biblioteca/ficha.html?upc=889463142683).

**Fuente oficial**: [INEGI](https://www.inegi.org.mx/app/biblioteca/ficha.html?upc=889463142683).

## Datos Disponibles
* [Municipios de México](https://raw.githubusercontent.com/mayrop/datos-covid19in-mx/master/www/otros/municipios.csv)
* [Entidades Federativas de México](https://raw.githubusercontent.com/mayrop/datos-covid19in-mx/master/www/otros/estados.csv)
* [SHP de Municipios de México](https://github.com/mayrop/datos-covid19in-mx/blob/master/www/geo/municipios.zip?raw=true)
* [SHP de Entidades Federativas de México](https://github.com/mayrop/datos-covid19in-mx/blob/master/www/geo/estados.zip?raw=true)

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
| Clave | Nombre              | Nombre_Mayuscula    | Nombre_Completo                 | Abreviatura | ISO_3 | RENAPO | Longitud     | Latitud    | Poblacion_2019 |
|-------|---------------------|---------------------|---------------------------------|-------------|-------|-------|--------------|------------|----------------|
| 1     | Aguascalientes      | AGUASCALIENTES      | Aguascalientes                  | Ags.        | AGU   | AS    | -102.3619377 | 22.0064411 | 1415421        |
| 2     | Baja California     | BAJA CALIFORNIA     | Baja California                 | B. C.       | BCN   | BC    | -115.0970657 | 30.5515922 | 3578561        |
| 3     | Baja California Sur | BAJA CALIFORNIA SUR | Baja California Sur             | B. C. S.    | BCS   | BS    | -112.0662031 | 25.9187109 | 788119         |
| 4     | Campeche            | CAMPECHE            | Campeche                        | Camp.       | CAM   | CC    | -90.3602773  | 18.8405542 | 984046         |
| 5     | Coahuila            | COAHUILA            | Coahuila de Zaragoza            | Coah.       | COA   | CL    | -102.0440387 | 27.295443  | 3175643        |

### Municipios de México (formato SHP)
```r
> cities_shp
Simple feature collection with 2458 features and 5 fields
geometry type:  MULTIPOLYGON
dimension:      XY
bbox:           xmin: -118.3651 ymin: 14.5321 xmax: -86.72224 ymax: 32.71865
CRS:            +proj=longlat +ellps=WGS84 +datum=WGS84
# A tibble: 2,458 x 6
   CVE_ENT CVE_MUN NOM_MUN      LONGITUDE LATITUDE                                      geometry
     <dbl>   <dbl> <fct>            <dbl>    <dbl>                            <MULTIPOLYGON [°]>
 1       1       1 Aguascalien…     -102.     21.8 (((-102.3239 21.93653, -102.3229 21.93665, -…
 2       1       2 Asientos         -102.     22.1 (((-101.9994 22.21951, -102.001 22.16811, -1…
 3       1       3 Calvillo         -103.     21.9 (((-102.5763 21.96778, -102.5844 21.95277, -…
 4       1       4 Cosío            -102.     22.4 (((-102.2532 22.37449, -102.2533 22.37046, -…
 5       1       5 Jesús María      -102.     21.9 (((-102.3239 21.93653, -102.3243 21.93627, -…
 6       1       6 Pabellón de…     -102.     22.1 (((-102.3103 22.03716, -102.3194 22.04042, -…
 7       1       7 Rincón de R…     -102.     22.3 (((-102.189 22.36244, -102.1941 22.35064, -1…
 8       1       8 San José de…     -103.     22.1 (((-102.3538 22.12064, -102.3543 22.11699, -…
 9       1       9 Tepezalá         -102.     22.2 (((-102.1621 22.34851, -102.1498 22.34718, -…
10       1      10 El Llano         -102.     21.9 (((-101.8978 21.95839, -101.8904 21.95095, -…
# … with 2,448 more rows
```

### Entidades Federativas de México (formato SHP)
```r
> states_shp
Simple feature collection with 32 features and 4 fields
geometry type:  MULTIPOLYGON
dimension:      XY
bbox:           xmin: -118.3651 ymin: 14.5321 xmax: -86.7184 ymax: 32.71865
CRS:            +proj=longlat +ellps=WGS84 +datum=WGS84
First 10 features:
   CVE_ENT              NOM_ENT  LONGITUDE LATITUDE                       geometry
1        1       Aguascalientes -102.36194 22.00644 MULTIPOLYGON (((-101.8617 2...
2        2      Baja California -115.09707 30.55159 MULTIPOLYGON (((-114.8136 3...
3        3  Baja California Sur -112.06620 25.91871 MULTIPOLYGON (((-109.8004 2...
4        4             Campeche  -90.36028 18.84055 MULTIPOLYGON (((-89.29656 1...
5        5 Coahuila de Zaragoza -102.04404 27.29544 MULTIPOLYGON (((-99.84322 2...
6        6               Colima -104.11512 19.13068 MULTIPOLYGON (((-114.7373 1...
7        7              Chiapas  -92.47291 16.48524 MULTIPOLYGON (((-91.4397 17...
8        8            Chihuahua -106.46894 28.80854 MULTIPOLYGON (((-103.307 29...
9        9     Ciudad de México  -99.13941 19.27689 MULTIPOLYGON (((-99.09089 1...
10      10              Durango -104.91340 24.92361 MULTIPOLYGON (((-103.6991 2...
```
