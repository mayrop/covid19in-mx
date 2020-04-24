---
author: "Mayra Valdes"
date: 2020-04-23
linktitle: Datos Abiertos COVID-19
title: Datos Abiertos COVID-19
weight: 1
bookToc: false
lang:
    en: /en/data/cases-tables/
---

{{< hint info >}}
**Nota:** Datos disponibles a través del [Paquete R](https://github.com/mayrop/datosmx)! :)
{{< /hint >}}

Existen datos abiertos desde el [12 de Abril de 2020](https://www.gob.mx/salud/documentos/datos-abiertos-bases-historicas-direccion-general-de-epidemiologia) publicados por la Secretaría de Salud de México. Los datos mas actuales pueden encontrarse [aquí](https://www.gob.mx/salud/documentos/datos-abiertos-152127). [Ricardo Cortes Alcalá](https://twitter.com/RicardoDGPS), Director General de Promoción de la Salud del Gobierno de México, anunció su disponibilidad el día [13 de Abril de 2020](https://twitter.com/RicardoDGPS/status/1249864573936644096).

**Fuente Oficial:** [Secretaría de Salud de México](https://www.gob.mx/salud/documentos/datos-abiertos-152127), Dirección General de Epidemiología. (Bases Históricas [aquí](https://www.gob.mx/salud/documentos/datos-abiertos-bases-historicas-direccion-general-de-epidemiologia)).

## Datos Disponibles
Ver en [Github](https://github.com/mayrop/datos-covid19in-mx/tree/master/www/abiertos/todos).

{{< opendata "todos" >}}
{{< /opendata >}}

## Diccionario de Datos

{{< tabs "diccionario" >}}
{{< tab "Descriptores" >}}
**Ultima Actualización**: 23 de Abril de 2020    
    {{< descriptors>}}{{< /descriptors >}}
{{< /tab >}}
{{< tab "Catálogos" >}} 
**Ultima Actualización**: 13 de Abril de 2020. [Descargar](https://github.com/mayrop/datos-covid19in-mx/tree/master/www/abiertos/catalogos).

{{< expand "Entidades" >}}
| CLAVE_ENTIDAD | ENTIDAD_FEDERATIVA              | ABREVIATURA |
|---------------|---------------------------------|-------------|
| 01            | AGUASCALIENTES                  | AS          |
| 02            | BAJA CALIFORNIA                 | BC          |
| 03            | BAJA CALIFORNIA SUR             | BS          |
| ...           | ...                             | ...         |
| 97            | NO APLICA                       | NA          |
| 98            | SE IGNORA                       | SI          |
| 99            | NO ESPECIFICADO                 | NE          |
{{< /expand >}}

{{< expand "Municipios" >}}
| CLAVE_MUNICIPIO | MUNICIPIO   | CLAVE_ENTIDAD |
|------|----------------|-------|
| 001  | AGUASCALIENTES | 01    |
| 002  | ASIENTOS       | 01    |
| 003  | CALVILLO       | 01    |
| 004  | COSÍO          | 01    |
| ...  | ...            | ...   |
| 010  | EL LLANO       | 01    |
| 011  | SAN FRANCISCO DE LOS ROMO  | 01    |
| 999  | NO ESPECIFICADO            | 01    |
{{< /expand >}}


{{< expand "Nacionalidad" >}}

| CLAVE | DESCRIPCION     |
|-------|-----------------|
| 1     | MEXICANA        |
| 2     | EXTRANJERA      |
| 99    | NO ESPECIFICADO |

{{< /expand >}}

{{< expand "Origen" >}}

| CLAVE | DESCRIPCION     |
|-------|-----------------|
| 1     | USMER           |
| 2     | FUERA DE USMER  |
| 99    | NO ESPECIFICADO |

{{< /expand >}}

{{< expand "Resultado" >}}

| CLAVE | DESCRIPCION            |
|-------|------------------------|
| 1     | Positivo SARS-CoV-2    |
| 2     | No positivo SARS-CoV-2 |
| 3     | Resultado pendiente    |

{{< /expand >}}

{{< expand "Sector" >}}
| CLAVE | DESCRIPCION     |
|-------|-----------------|
| 1     | CRUZ ROJA       |
| 2     | DIF             |
| 3     | ESTATAL         |
| 4     | IMSS            |
| 5     | IMSS-BIENESTAR  |
| 6     | ISSSTE          |
| 7     | MUNICIPAL       |
| 8     | PEMEX           |
| 9     | PRIVADA         |
| 10    | SEDENA          |
| 11    | SEMAR           |
| 12    | SSA             |
| 13    | UNIVERSITARIO   |
| 99    | NO ESPECIFICADO |

{{< /expand >}}

{{< expand "Sexo" >}}
| CLAVE | DESCRIPCION     |
|-------|-----------------|
| 1     | MUJER           |
| 2     | HOMBRE          |
| 99    | NO ESPECIFICADO |
{{< /expand >}}

{{< expand "Si_No" >}}
| CLAVE | DESCRIPCION     |
|-------|-----------------|
| 1     | SI              |
| 2     | NO              |
| 97    | NO APLICA       |
| 98    | SE IGNORA       |
| 99    | NO ESPECIFICADO |
{{< /expand >}}

{{< expand "Tipo_Paciente" >}}
| CLAVE | DESCRIPCION     |
|-------|-----------------|
| 1     | AMBULATORIO     |
| 2     | HOSPITALIZADO   |
| 99    | NO ESPECIFICADO |
{{< /expand >}}


{{< /tab >}}
{{< /tabs >}}

