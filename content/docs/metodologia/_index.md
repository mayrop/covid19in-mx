---
author: "Mayra Valdes"
linktitle: Metodología
title: Metodología
weight: 2
bookFlatSection: true
---

# Metodología

## Recopilación de la Información
A partir del 28 de Marzo empecé el proyecto de obtener los datos oficiales del sitio de la [Secretaría de Salud de México](https://twitter.com/@SSalud_mx) publicados diariamente a eso de las 19 horas [aquí](https://www.gob.mx/salud/documentos/coronavirus-covid-19-comunicado-tecnico-diario-238449). De igual manera, a partir del día 4 de Abril se obtienen datos oficiales de los casos negativos y defunciones por estado a partir del [mapa](https://ncov.sinave.gob.mx/mapa.aspx) publicado por el gobierno, donde se puede visualizar (con colores) la situación de cada estado.

{{< hint warning >}}
Una discula por adelantado por el lenguaje técnico utilizado en esta página!
{{< /hint >}}

### Primer Reto
El primer reto encontrado fue que, por algún motivo, algunos de los archivos PDF originales son removidos del sitio de la [Secretaría de Salud de México](https://www.gob.mx/salud/documentos/coronavirus-covid-19-comunicado-tecnico-diario-238449). Se consiguió obtener los archivos faltantes (del ~15 de Marzo al 28 Abril) a través de fuentes no oficiales (que inteligentemente archivaron los archivos):
* [Serendipia](https://serendipia.digital/2020/03/datos-abiertos-sobre-casos-de-coronavirus-covid-19-en-mexico/). Una gran fuente que publica ambas fuentes, en formato abierto, y en formato original de PDF.
* [github.com/guzmart/covid19_mex](https://github.com/guzmart/covid19_mex). Un gran trabajo por parte de [@guzmart_](https://twitter.com/guzmart_).
* [github.com/carranco-sga/Mexico-COVID-19](https://github.com/carranco-sga/Mexico-COVID-19). Otro gran ejemplo de un gran trabajo por parte de [Gabriel Carranco-Sapiéns](https://github.com/carranco-sga).

#### Archivos Adicionales
* **13 de Marzo**: Tabla de casos positivos. El archivo fue encontrado en formato PNG [aquí](https://www.scribd.com/document/452680821/Tabla-casos-positivos-resultado-InDRE-2020-03-13).
* **8 de Marzo**: Tabla de casos sospechosos. El archivo fue encontrado en formato original PDF [aquí](https://slp.gob.mx/SSALUD/Documentos%20compartidos/Coronavirus/marzo/Tabla_casos_sospechosos_COVID-19_2020.03.08.pdf). Fue encontrado a través de exhaustas búsquedas en Google hasta encontrar [una interfaz](https://slp.gob.mx/SSALUD/Documentos%20compartidos/Forms/AllItems.aspx?RootFolder=%2FSSALUD%2FDocumentos%20compartidos%2FCoronavirus&FolderCTID=0x0120002C4A6E2BDD73D34899963849CA684C1C&View=%7BFA81CA67%2D551E%2D4BDD%2D9C03%2DCA3F799D0382%7D) que probablemente no debería estar pública.

## Transformación de la Información
El primer reto para poder obtener los datos para posteriormente analizarlos, es que el gobierno publica la información en formato PDF. Eso hace imposible analizar dichos datos sin primero transformar los archivos a un formato amigable (CSV, XLSX).

Para empezar, los archivos publicados son muy pesados (tardan mucho en cargar), así que se decidió optimizar los archivos usando una [herramienta en línea](https://smallpdf.com/compress-pdf). Actualmente se esta [probando](https://github.com/mayrop/datos-covid19in-mx/blob/parse/scripts/processing/run.sh#L57) una solución automática para la [compresión de los PDF](https://stackoverflow.com/questions/16530510/pdf-compression-like-smallpdf-com-programmatically-in-c-sharp). Los archivos que se pueden encontrar en este sitio son al menos **50%** mas ligeros que los originalmente publicados. 

{{< hint info >}}
Optimizar los archivos no altera el contenido del mismo, simplemente reduce el tamaño del mismo, lo cual ayuda al usuario final.
{{< /hint >}}

Hay diferentes formas de poder transformar archivos PDF a CSV. Hay herramientas [en línea](https://convertio.co/pdf-csv/). [Gabriel Carranco-Sapiéns](https://github.com/carranco-sga) utiliza [una elegante solución](https://github.com/carranco-sga/Mexico-COVID-19/blob/master/Scraping/pdf_scraping.jl#L7) con el lenguaje de programación [Julia](https://julialang.org/). 

El proceso que se utilizó para este proyecto fue la de primero transformar el PDF a HTML utilizando [pdf2htmlEX](https://github.com/pdf2htmlEX/pdf2htmlEX) y posteriormente parsear dicho HTML a formato CSV. No bastó con obtener la información y pasarla a CSV, sino primero normalizar la información. El código fuente este proceso para puede ser encontrado [aquí](https://github.com/mayrop/datos-covid19in-mx/blob/master/scripts/processing/process.sh).

## Normalización de la Información

* Inconsistencias de formato de Fecha 
* Inconsistencias de formato de Sexo
* Inconsistencias de formato de Entidad Federativa

### Inconsistencias de formato de Fecha 
El primer reto y terrible error de los archivos originales es que tienen la fecha en un formato diferente, con 5 numeros en vez de la fecha en formato YYYY/MM/DD. La solución se puede encontrar en el sitio de [Stack Overflow](https://stackoverflow.com/questions/14271791/converting-date-formats-python-unusual-date-formats-extract-ymd/30058862#30058862).

Los archivos que por lo menos tienen una inconsistencia de este tipo son:
```r
> rows %>% 
+   dplyr::filter(Fecha_Sintomas_Corregido == TRUE) %>% 
+   dplyr::pull(File_Id) %>% 
+   unique()

 [1] "positivos_2020_04_07"   "positivos_2020_04_08"   "sospechosos_2020_03_13"
 [4] "sospechosos_2020_03_14" "sospechosos_2020_03_27" "sospechosos_2020_03_28"
 [7] "sospechosos_2020_03_29" "sospechosos_2020_03_31" "sospechosos_2020_04_01"
[10] "sospechosos_2020_04_02" "sospechosos_2020_04_03" "sospechosos_2020_04_04"
[13] "sospechosos_2020_04_06" "sospechosos_2020_04_07" "sospechosos_2020_04_08"
```

Ahora vamos a proceder a verificar que las fechas se esten actualizando correctamente. Con el caso de la fila 2476 de la tabla de positivos del [8 de Abril](https://datos.covid19in.mx/tablas-diarias/positivos/202004/20200408.pdf) nos encontramos con este caso donde se publica la fecha de sintomas como `43911`:

![Caso con la fecha en formato diferente](/images/metodologia/caso01.png)

Podemos observar en el [archivo CSV](https://datos.covid19in.mx/tablas-diarias/positivos/202004/20200408.csv) de la misma fecha como se corrigió en la columna `Fecha_Sintomas_Normalizado` a `2020-03-21`. Esto se puede observar via código R:
```r
> rows %>%
+   dplyr::filter(
+     File_Id == "positivos_2020_04_08" &
+     Edad == 71 & 
+     Estado_Normalizado == "YUC"
+   ) %>%
+   dplyr::select(
+     File_Id, Caso, Estado, Sexo, Edad, 
+     Fecha_Sintomas, Fecha_Sintomas_Normalizado
+   )
  Caso  Estado      Sexo Edad Fecha_Sintomas Fecha_Sintomas_Normalizado
1 2476 YUCATÁN MASCULINO   71          43911                 2020-03-21
```

Posteriormente, el día 9 de Abril, las fechas fueron corregidas al formato `DD/MM/YYYY`. El mismo caso puede observarse en la fila `2666`. 

![Caso con la fecha en formato corregido](/images/metodologia/caso02.png)

Podemos comprobar q es el unico con esas caracteristicas (Sexo Masculino, Edad 71 del estado de Yucatán) así:
```r
> rows %>%
+   dplyr::filter(
+     File_Id == "positivos_2020_04_09" &
+       Edad == 71 & 
+       Estado_Normalizado == "YUC"
+   ) %>%
+   dplyr::select(
+     File_Id, Caso, Estado, Sexo, Edad, 
+     Fecha_Sintomas, Fecha_Sintomas_Normalizado
+   )
  Caso  Estado      Sexo Edad Fecha_Sintomas Fecha_Sintomas_Normalizado
1 2666 YUCATÁN MASCULINO   71     21/03/2020                 2020-03-21
```

### Inconsistencias de formato de Sexo
Al parecer las columnas de Sexo no son consistentes, al tener diferentes valores:
```r
> table(rows$Sexo)
        F         M  FEMENINO MASCULINO 
    32830     32347     22507     22453 
```

La columna `Sexo_Normalizado` tiene el sexo normalizado a `F` y `M`:
```r
> table(rows$Sexo_Normalizado)
    F     M 
55337 54800 
```

Podemos comprobar que esta inconsistencia empezó a partir del 6 de Abril tanto en las tablas de positivos como en las de sospechosos:
```r
rows %>%
+   dplyr::filter(Sexo %in% c("MASCULINO", "FEMENINO")) %>%
+   dplyr::pull(File_Id) %>%
+   unique()
[1] "positivos_2020_04_06"   "positivos_2020_04_07"   "positivos_2020_04_08"  
[4] "positivos_2020_04_09"   "sospechosos_2020_04_06" "sospechosos_2020_04_07"
[7] "sospechosos_2020_04_08" "sospechosos_2020_04_09"
```

### Inconsistencias de formato de Entidad Federativa
En algunos archivos, los nombres de las entidades federativas publicados diferían en acentos y nombres. Por ejemplo, en el PDF publicado el 6 de abril, el gobierno optó por cambiar el nombre de la Ciudad de México (CDMX) a Distrito Federal. 

Hasta hoy (10 de Abril) existen 66 diferentes valores en las tablas originales en la columna Estado. Las diferencias mas notables esq en algunos archivos las entidades estan en mayúscula, en otras en minúscula, en algunas se agregan acento y en otras no. 

```r
> rows %>% 
+   dplyr::filter(
+     grepl("SAN|San", Estado)
+   ) %>%
+   dplyr::pull(Estado) %>%
+   unique()
[1] SAN LUIS POTOSÍ SAN LUIS POTOSI San Luis Potosí
66 Levels: CHIAPAS CIUDAD DE MÉXICO COAHUILA DURANGO MÉXICO MÉXICO* NUEVO LEÓN ... 1
```

Del día 12 al 15 de Marzo se agregó un `*` a los casos como una medida para definir que dicho caso se habia recuperado. Lo que llama la atención es que la tabla de sospechosos del día [12 de Marzo](https://datos.covid19in.mx/tablas-diarias/sospechosos/202003/20200312.pdf) tenía declarado un caso de Sinaloa como recuperado antes de declararlo como positivo:
```r
> rows %>% 
+   dplyr::filter(
+     grepl("\\*", Estado)
+   ) %>%
+   dplyr::select(
+     File_Id, Estado, Caso, Sexo, Edad,
+     Fecha_Sintomas_Normalizado
+   )
                 File_Id    Estado Caso Sexo Edad Fecha_Sintomas_Normalizado
1   positivos_2020_03_13  SINALOA*    2    M   41                 2020-02-22
2   positivos_2020_03_13   MÉXICO*    6    M   71                 2020-02-21
3   positivos_2020_03_14  SINALOA*    2    M   41                 2020-02-22
4   positivos_2020_03_14   MÉXICO*    6    M   71                 2020-02-21
5   positivos_2020_03_15  SINALOA*    2    M   41                 2020-02-22
6   positivos_2020_03_15 COAHUILA*    4    F   20                 2020-02-27
7   positivos_2020_03_15   MÉXICO*    6    M   71                 2020-02-21
8 sospechosos_2020_03_12  Sinaloa*   10    F   29                 2020-03-08
```

Si leyemos la leyenda al final del PDF podemos encontrar `*Recuperado al dar negativo en su muestra a los 14 días de seguimiento`. Si la fecha de los síntomas empezó el 8 de marzo, los 14 días de la leyenda no hacen mucho sentido. Este parece un error del archivo original.

Uno cambio de los importantes es que el día 6 de Abril se cambió por primera vez `Ciudad de México` a `Distrito Federal`:

```r
> rows %>% 
+   dplyr::filter(
+     grepl("Distrito", Estado, ignore.case=TRUE)
+   ) %>%
+   dplyr::pull(File_Id) %>%
+   unique()
[1] "positivos_2020_04_06"   "sospechosos_2020_04_06"
```

Y podemos observar que no hay referencia de `Ciudad de México` en dichos archivos:
```r
> rows %>% 
+   dplyr::filter(
+     grepl("Ciudad", Estado, ignore.case=TRUE) &
+       File_Id %in% c("positivos_2020_04_06", "sospechosos_2020_04_06")
+   ) %>% nrow() 
[1] 0
```

Por esta razón, se agregó una columna `Estado_Normalizado` que contiene el [código ISO](https://www.iso.org/obp/ui/#iso:code:3166:MX) de tres letras de cada estado.

### Inconsistencias de formato de Procedencia
Hasta el día de hoy (10 de Abril), existen 65 valores distintos en la columna de Procedencia. Dudo que este número vaya a cambiar en un futuro (a menos de que se publiquen datos diferentes), dado que la columna Procedencia fue eliminada el 8 de Abril. Si sólo tomamos los valores de las tablas de positivos, entonces vemos que hay solo 36 valores. Lo que es interesante es que hasta el 5 de Abril solo existían 8 valores diferentes tanto en las tablas de casos positivos como en la tabla de casos sospechosos:

```r
> rows %>% 
+   dplyr::group_by(File_Date, Type) %>%
+   dplyr::summarise(
+     N=unique(Procedencia) %>% length()
+   ) %>%
+   tidyr::spread(Type, N) %>%
+   dplyr::filter(
+     File_Date > "2020-04-01"
+   )
# A tibble: 8 x 3
# Groups:   File_Date [8]
  File_Date  positivos sospechosos
  <date>         <int>       <int>
1 2020-04-02         7           8
2 2020-04-03         7           9
3 2020-04-04         8           8
4 2020-04-05         8           8
5 2020-04-06        36          31
6 2020-04-07        31          30
7 2020-04-08         1           1
8 2020-04-09         1           1
```

El día 6 de Abril subió a 36 dado que el formato completo cambió. Estaré escribiendo más al respecto muy pronto. Por ahora me bastará decir que la columna `Procedencia_Normalizado` se encuentra el mejor intento de normalización de los países de procedencia.

