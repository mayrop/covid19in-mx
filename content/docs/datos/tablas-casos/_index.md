---
author: "Mayra Valdes"
date: 2020-04-04
linktitle: Tabla de Casos Diarios
title: Tabla de Casos Diarios
weight: 10
---

## Formato
Los archivos CSV proporcionados no solo contienen la informacion original del PDF, sino que ademas se agregan columnas para normalizar la informacion. El formato de los archivos es el siguiente:

- `Caso`: Numero de Caso asignado a cada fila. Notar que este Numero varia día a día.
- `Estado`: Información original de la columna Estado.
- `Localidad`: Información original de la columna (Si fue publicada)
- `Sexo`: Información original de la columna Sexo.
- `Edad`: Información original de la columna Edad.
- `Fecha_Sintomas`: Información original de la columna Inicio de Fecha de Síntomas.
- `Situacion`: Información original de la columna.
- `Procedencia`: País (o Contacto) del origen de cada caso. _Al parecer removido desde el 8 de Abril._
- `Fecha_Llegada`: Fecha de llegada a México. _Al parecer removido desde el 7 de Abril._
- `Estado_Normalizado`: [Código ISO](https://www.iso.org/obp/ui/#iso:code:3166:MX) de tres letras de cada estado.
- `Localidad_Normalizado`: Columna con la información en mayúsculas y sin acento.
- `Sexo_Normalizado`: F o M.
- `Fecha_Sintomas_Normalizado`: Fecha de síntomas en formato ISO `YYYY-MM-DD`.
- `Fecha_Sintomas_Corregido`: True o False (se planea cambiar a 1 NA) en un futuro proximo.
- `Situacion_Normalizado`: Situacion en mayúsculas.
- `Procedencia_Normalizado`: La procedencia normalizada en mayúsculas. Ver más aquí.
- `Fecha_Llegada_Normalizado"`: Fecha de llegada en formato ISO `YYYY-MM-DD`.

| Caso | Estado              | Localidad | Sexo | Edad | Fecha_Sintomas | Situacion  | Procedencia    | Fecha_Llegada | Recuperado | Fecha_Sintomas_Corregido |
|------|---------------------|-----------|------|------|----------------|------------|----------------|---------------|------------|--------------------------|
| 1    | CIUDAD DE MEXICO    |           | M    | 35   | 2020-02-22     | CONFIRMADO | ITALIA         | 2020-02-22    |            |                          |
| 2    | SINALOA             |           | M    | 41   | 2020-02-22     | CONFIRMADO | ITALIA         | 2020-02-21    |            |                          |
| 3    | CIUDAD DE MEXICO    |           | M    | 59   | 2020-02-23     | CONFIRMADO | ITALIA         | 2020-02-22    |            |                          |
| 4    | COAHUILA            |           | F    | 20   | 2020-02-27     | CONFIRMADO | ITALIA         | 2020-02-25    |            |                          |
| 5    | CHIAPAS             |           | F    | 18   | 2020-02-25     | CONFIRMADO | ITALIA         | 2020-02-25    |            |                          |
