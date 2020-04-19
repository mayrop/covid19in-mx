---
author: "Mayra Valdes"
date: 2020-04-10
linktitle: Data Normalization
title: Data Normalization
bookCollapseSection: true
lang:
    es: /datos/comunicado-tecnico-diario/normalizacion/
weight: 20
---

As many existent data bases, the original data from the PDF files have many inconsistencies. In **covid19in.mx**, we add additional columns to the CSV files that we provide. In these columns, you will be able to find the original dataset as well as the normalized data, which will help with an easier analysis.

The columns with the `_Normalizado` suffixes were transformed as follows:

* Text will be all uppercase.
* All accents were removed.
* State will be the 3-letter code in [ISO format](https://www.iso.org/obp/ui/#iso:code:3166:MX).
* The sex (gender) column will have an `M` for Masculine gender and `F` for Feminine gender. There are no other values.
* Dates will have an [ISO format](https://www.iso.org/iso-8601-date-and-time-format.html) `YYYY-MM-DD`.

Additional information about the normalization of some columns in particular:

* [Normalization for the State column](/en/data/cases-tables/normalization/state/)
* [Normalization for the Sex (Gender) column](/en/data/cases-tables/normalization/gender/)
* [Normalization for the Date columns](/en/data/cases-tables/normalization/date/)
* [Normalization for the Origin column](/en/data/cases-tables/normalization/origin/)

## Specs
The CSV files have the following columns:

- `Caso`: Case number assigned to each row. This case number varies day after day and it is not constant.
- `Estado`: Original de la columna `Estado`.
- `Localidad`: Original data about the column `Localidad` (if it was published).
- `Sexo`: Original data about the column `Sexo`.
- `Edad`: Original data about the column `Edad`.
- `Fecha_Sintomas`: Original data about the column `Inicio de Fecha de Síntomas`.
- `Situacion`: Original data about the column `Identificación de COVID-19 por RTPCR en tiempo real`.
- `Procedencia`: Country that was visited before the person got the disease. The column will have a value of _Contacto_ when the person did not travel to any other country. {{< span-color EA0C0C >}} <em><strong>Note</strong>: This column was removed on April 8, 2020.</em>{{% /span-color %}}
- `Fecha_Llegada`: Original data about the column `Fecha de llegada a México`. This column has the date of arrival to Mexico in case the person travelled abroad before getting the disease. {{< span-color EA0C0C >}} <em><strong>Note</strong>: This column was removed on April 6, 2020.</em>{{% /span-color %}}
- `Estado_Normalizado`: 3 leger digic [ISO Code](https://www.iso.org/obp/ui/#iso:code:3166:MX). _More information about the state normalization [here](/docs/datos/tablas-casos/normalizacion/estado/)._
- `Localidad_Normalizado`: Column with the original data from `Localidad` en column in a normalized format.
- `Sexo_Normalizado`: Value will be `F` or `M`. _More information about the normalization of this field [here](/docs/datos/tablas-casos/normalizacion/genero/)._
- `Fecha_Sintomas_Normalizado`: Day of initial symptoms in [ISO format](https://www.iso.org/iso-8601-date-and-time-format.html) `YYYY-MM-DD`. _More information about the normalization of dates [here](/docs/datos/tablas-casos/normalizacion/fecha/)._
- `Fecha_Sintomas_Corregido`: `True` o `False` (we plan to change to 1/NA soon). _More information about the normalization of dates [here](/docs/datos/tablas-casos/normalizacion/fecha/)._
- `Situacion_Normalizado`: Situation normalized. Possible values `CONFIRMADO` o `SOSPECHOSO`.
- `Procedencia_Normalizado`: Normalized Origin. _More information about the normalization of this field [here](/docs/datos/tablas-casos/normalizacion/procedencia/)._
- `Fecha_Llegada_Normalizado"`: Arrival date in [ISO format](https://www.iso.org/iso-8601-date-and-time-format.html) `YYYY-MM-DD`. _More information about the normalization of this field [here](/docs/datos/tablas-casos/normalizacion/fecha/)._

### Example

| Caso | Estado           | Localidad | Sexo | Edad | Fecha_Sintomas | Situacion  | Procedencia    | Fecha_Llegada | Estado_Normalizado | Localidad_Normalizado | Sexo_Normalizado | Fecha_Sintomas_Normalizado | Fecha_Sintomas_Corregido | Situacion_Normalizado | Procedencia_Normalizado | Fecha_Llegada_Normalizado |
|------|------------------|-----------|------|------|----------------|------------|----------------|---------------|--------------------|-----------------------|------------------|----------------------------|--------------------------|-----------------------|-------------------------|---------------------------|
| 1    | CIUDAD DE MÉXICO |           | M    | 35   | 22/02/2020     | confirmado | Italia         | 22/02/2020    | CMX                |                       | M                | 2020-02-22                 | False                    | CONFIRMADO            | ITALIA                  | 2020-02-22                |
| 2    | SINALOA*         |           | M    | 41   | 22/02/2020     | confirmado | Italia         | 21/02/2020    | SIN                |                       | M                | 2020-02-22                 | False                    | CONFIRMADO            | ITALIA                  | 2020-02-21                |
| 3    | CIUDAD DE MÉXICO |           | M    | 59   | 23/02/2020     | confirmado | Italia         | 22/02/2020    | CMX                |                       | M                | 2020-02-23                 | False                    | CONFIRMADO            | ITALIA                  | 2020-02-22                |
| 4    | COAHUILA*        |           | F    | 20   | 27/02/2020     | confirmado | Italia         | 25/02/2020    | COA                |                       | F                | 2020-02-27                 | False                    | CONFIRMADO            | ITALIA                  | 2020-02-25                |
| 5    | CHIAPAS          |           | F    | 18   | 25/02/2020     | confirmado | Italia         | 25/02/2020    | CHP                |                       | F                | 2020-02-25                 | False                    | CONFIRMADO            | ITALIA                  | 2020-02-25                |

