---
author: "Mayra Valdes"
date: 2020-04-10
linktitle: Normalización de los Datos
title: Normalización de los Datos
bookCollapseSection: true
weight: 20
---

## Normalización de los Datos

Como muchas bases de datos existentes, los datos originales en los documentos PDF contienen muchas inconsistencias. Como valor agregado de **covid19in.mx**, se agregaron columnas adicionales a los archivos CSV proporcionados por este sitio. En dichas columnas se podrá encontrar los datos originales normalizados para análisis más sencillo.

Las columnas con sufijo `_Normalizado` fueron transformaadas de la siguiente manera:

* El texto estará en mayúsculas.
* Los acentos fueron removidos.
* El estado se encontrará en código de 3 letras en [formato ISO](https://www.iso.org/obp/ui/#iso:code:3166:MX).
* Las fechas se encontrarán en [formato ISO](https://www.iso.org/iso-8601-date-and-time-format.html) `YYYY-MM-DD`.

Información adicional acerca de normalización de columnas en particular:

* [Normalización de la columna Estado](/docs/datos/tablas-casos/normalizacion/estado/)
* [Normalización de la columna Género (Sexo)](/docs/datos/tablas-casos/normalizacion/genero/)
* [Normalización de la columna Fecha](/docs/datos/tablas-casos/normalizacion/fecha/)
* [Normalización de la columna Procedencia](/docs/datos/tablas-casos/normalizacion/procedencia/)

## Especificación
Los archivos CSV contienen las siguientes columnas:

- `Caso`: Numero de Caso asignado a cada fila. Notar que este Numero varia día a día.
- `Estado`: Información original de la columna `Estado`.
- `Localidad`: Información original de la columna (Si fue publicada).
- `Sexo`: Información original de la columna `Sexo`.
- `Edad`: Información original de la columna `Edad`.
- `Fecha_Sintomas`: Información original de la columna `Inicio de Fecha de Síntomas`.
- `Situacion`: Información original de la columna `Identificación de COVID-19 por RTPCR en tiempo real`.
- `Procedencia`: País (o Contacto) del origen de cada caso. {{< span-color EA0C0C >}} <em><strong>Nota</strong>: Esta columna fue removida desde el 8 de Abril.</em>{{% /span-color %}}
- `Fecha_Llegada`: Información original de la columna `Fecha de llegada a México`. {{< span-color EA0C0C >}} <em><strong>Nota</strong>: Esta columna fue removida desde el 7 de Abril.</em>{{% /span-color %}}
- `Estado_Normalizado`: [Código ISO](https://www.iso.org/obp/ui/#iso:code:3166:MX) de tres letras de cada estado. _Más información de la normalización del estado [aquí](/docs/datos/tablas-casos/normalizacion/estado/)._
- `Localidad_Normalizado`: Columna con los datos de la columna original `Localidad` en mayúsculas y sin acento.
- `Sexo_Normalizado`: El valor sera `F` o `M`. _Más información de la normalización de la columna sexo en particular [aquí](/docs/datos/tablas-casos/normalizacion/genero/)._
- `Fecha_Sintomas_Normalizado`: Fecha de síntomas en [formato ISO](https://www.iso.org/iso-8601-date-and-time-format.html) `YYYY-MM-DD`. _Más información de la normalización de fechas [aquí](/docs/datos/tablas-casos/normalizacion/fecha/)._
- `Fecha_Sintomas_Corregido`: True o False (se planea cambiar a 1/NA) en un futuro proximo. _Más información de la normalización de fechas [aquí](/docs/datos/tablas-casos/normalizacion/fecha/)._
- `Situacion_Normalizado`: Situación en mayúsculas. Posibles valores `CONFIRMADO` o `SOSPECHOSO`.
- `Procedencia_Normalizado`: La procedencia normalizada en mayúsculas. _Más información de la normalización de Procedencia en particular [aquí](/docs/datos/tablas-casos/normalizacion/procedencia/)._
- `Fecha_Llegada_Normalizado"`: Fecha de llegada en [formato ISO](https://www.iso.org/iso-8601-date-and-time-format.html) `YYYY-MM-DD`. _Más información de la normalización de fechas en particular [aquí](/docs/datos/tablas-casos/normalizacion/fecha/)._

### Ejemplo

| Caso | Estado           | Localidad | Sexo | Edad | Fecha_Sintomas | Situacion  | Procedencia    | Fecha_Llegada | Estado_Normalizado | Localidad_Normalizado | Sexo_Normalizado | Fecha_Sintomas_Normalizado | Fecha_Sintomas_Corregido | Situacion_Normalizado | Procedencia_Normalizado | Fecha_Llegada_Normalizado |
|------|------------------|-----------|------|------|----------------|------------|----------------|---------------|--------------------|-----------------------|------------------|----------------------------|--------------------------|-----------------------|-------------------------|---------------------------|
| 1    | CIUDAD DE MÉXICO |           | M    | 35   | 22/02/2020     | confirmado | Italia         | 22/02/2020    | CMX                |                       | M                | 2020-02-22                 | False                    | CONFIRMADO            | ITALIA                  | 2020-02-22                |
| 2    | SINALOA*         |           | M    | 41   | 22/02/2020     | confirmado | Italia         | 21/02/2020    | SIN                |                       | M                | 2020-02-22                 | False                    | CONFIRMADO            | ITALIA                  | 2020-02-21                |
| 3    | CIUDAD DE MÉXICO |           | M    | 59   | 23/02/2020     | confirmado | Italia         | 22/02/2020    | CMX                |                       | M                | 2020-02-23                 | False                    | CONFIRMADO            | ITALIA                  | 2020-02-22                |
| 4    | COAHUILA*        |           | F    | 20   | 27/02/2020     | confirmado | Italia         | 25/02/2020    | COA                |                       | F                | 2020-02-27                 | False                    | CONFIRMADO            | ITALIA                  | 2020-02-25                |
| 5    | CHIAPAS          |           | F    | 18   | 25/02/2020     | confirmado | Italia         | 25/02/2020    | CHP                |                       | F                | 2020-02-25                 | False                    | CONFIRMADO            | ITALIA                  | 2020-02-25                |

