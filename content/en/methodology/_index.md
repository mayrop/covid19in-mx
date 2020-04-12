---
author: "Mayra Valdes"
linktitle: Methodology
title: Methodology
weight: 2
lang:
    es: /docs/metodologia/
bookFlatSection: true
---

## Introducción
Everyday, approximately at 19:00, there is a [Press Conference](https://coronavirus.gob.mx/noticias/), there the government presents the daily Coronavirus COVID-19 en México situation. The conference is commonly headed by [Hugo López-Gatell](https://twitter.com/HLGatell), Subsecretario de Prevención y Promoción de la Salud. 

While the conference is taking place, the [Secretaría de Salud de México](https://www.gob.mx/salud), publishes the updated documents [here](https://www.gob.mx/salud/documentos/coronavirus-covid-19-comunicado-tecnico-diario-238449). These documents have three different formats: a daily technical release ([example](https://www.gob.mx/cms/uploads/attachment/file/546100/Comunicado_Tecnico_Diario_COVID-19_2020.04.09.pdf)), a daily table of suspected cases ([example](https://datos.covid19in.mx/tablas-diarias/sospechosos/202004/20200409.pdf)) and a table of positive cases ([example](https://datos.covid19in.mx/tablas-diarias/positivos/202004/20200409.pdf)) in PDF format. 

While there is historical data for the daily technical releases [here](https://www.gob.mx/salud/documentos/informacion-internacional-y-nacional-sobre-nuevo-coronavirus-2019-ncov), the daily table for positive and suspected cases are removed after a few days for some reason 🤷. Removing the documents from the official site is not the only problem to analyze the data, publishing them in PDF format makes the process very hard. 

The information for negative cases, as well as deaths is only published as an accumulated daily total in the official documents. However, there is a [map](https://ncov.sinave.gob.mx/mapa.aspx), which is also published by Secretaría de Salud de México where you can visualise (with colors) the situation about every state in Mexico.

## Data Retrieval
I started this project with the retrieval and data clean up with the daily tables of COVID-19 cases in México on [March 28](https://github.com/mayrop/covid19in-mx/commit/d472d10cc7a7fad9b11099af8d5ee4f7dc07037c). Similarly, on April 4, I started the retrieval of data for negative cases and deaths automatically.

## Daily Tables of Positive and Suspected Cases
As it was already mentioned, the first challenge was to retrieve all the documents for Coronavirus (COVID-19) in México given that, for some reason, the majority of the PDF documents are removed from the official site. It was possible to get the missing files (from ~March 15 to March 28) through non-official sites (who cleverly filed the official documents):
* [Serendipia](https://serendipia.digital/2020/03/datos-abiertos-sobre-casos-de-coronavirus-covid-19-en-mexico/). A great source that publishes data in PDF and CSV format.
* [github.com/guzmart/covid19_mex](https://github.com/guzmart/covid19_mex). An excellent job by [@guzmart_](https://twitter.com/guzmart_).
* [github.com/carranco-sga/Mexico-COVID-19](https://github.com/carranco-sga/Mexico-COVID-19). Another great example of great work from [@carranco-sgas](https://github.com/carranco-sga).

### Additional Documents
* **March 8**: Table of suspected cases. The original document was found [here](https://slp.gob.mx/SSALUD/Documentos%20compartidos/Coronavirus/marzo/Tabla_casos_sospechosos_COVID-19_2020.03.08.pdf). It was found after exhaustive searches in Google until [this government interface](https://slp.gob.mx/SSALUD/Documentos%20compartidos/Forms/AllItems.aspx?RootFolder=%2FSSALUD%2FDocumentos%20compartidos%2FCoronavirus&FolderCTID=0x0120002C4A6E2BDD73D34899963849CA684C1C&View=%7BFA81CA67%2D551E%2D4BDD%2D9C03%2DCA3F799D0382%7D) was found, which seems that it should not be public.
* **March 13**: Positive Cases table. The document was found [here](https://www.scribd.com/document/452680821/Tabla-casos-positivos-resultado-InDRE-2020-03-13) in PNG format.

### Transformations of the Daily Tables for Positive and Suspected Cases
The tables published by the Secretaría de Salud de México have a PDF format. That makes the analysis to be practically impossible without transforming such data into an open format such as CSV.

First, the published PDF files are very heavy (they take a while to load). We are [using](https://github.com/mayrop/datos-covid19in-mx/blob/master/scripts/processing/compress.sh#L23) an automated solution to compress the PDF files. {{< span-style "text-decoration:line-through" >}}Prior to that, the files were compressed manually using the great <a href="https://smallpdf.com/compress-pdf" target="_blank">SmallPDF online tool</a>{{< /span-style >}}. The PDF files found in this site are at least **50%** lighter than the original. 

{{< hint info >}}
**Note:** Optimizing the files do not alter the contents, it will only reduce the size of the file, which will help the final user.
{{< /hint >}}

Then, transforming PDF to CSV. There are different ways to transform PDF to CSV. For example, [online tools](https://convertio.co/pdf-csv/). [@Carranco-sga](https://github.com/carranco-sga) uses [an elegant solution](https://github.com/carranco-sga/Mexico-COVID-19/blob/master/Scraping/pdf_scraping.jl#L7) with the [Julia](https://julialang.org/) programming language. [@Covidctdmx](https://github.com/covidctdmx) presents a different but [insteresting solution](https://github.com/covidctdmx/covid_ctd_mx/blob/master/covid_ctd_mx.sh#L166) in a Bash script.

The process used in this proyect was to first transform the PDF to TXT using [pdftotext](https://en.wikipedia.org/wiki/Pdftotext), from [Poppler](https://poppler.freedesktop.org/), and then convert the [TXT file to CSV](https://github.com/mayrop/datos-covid19in-mx/blob/master/scripts/processing/parse_pdf.py). {{< span-style "text-decoration:line-through" >}}Before, we were converting the HTML using <a href="https://github.com/pdf2htmlEX/pdf2htmlEX" target="_blank">pdf2htmlEX</a>, and then parsing such HTML file to CSV. This process was slow and not portable.{{< /span-style >}}

We also normalize the data. To read more about it [click here](/en/data/cases-tables/normalization/).

## Negative Cases and Deaths by State
While the daily press conference from the Secretaría de Salud de México takes place, they give the accumulated number of positive, suspected, negative and deaths for all the country. However, they do not publish the number of negative cases. The only way we have found so far (April 11) to get this information is through [this map](https://ncov.sinave.gob.mx/mapa.aspx). The data used for this map (in JSON format) is retrieved since April 4. The number of negative cases prior to April 4 where [captured manually](https://github.com/mayrop/datos-covid19in-mx/blob/master/scripts/analysis/bak/totales.csv). If you find any error, you can contact me via [Twitter](htttps://twitter.com/@mayrop).  

## Código Fuente
All the source code for this process can be found [here](https://github.com/mayrop/datos-covid19in-mx/).

