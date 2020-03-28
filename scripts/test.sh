#!/bin/bash

ROOT=$(pwd)

for FILE in `find resources  -name "*.pdf" | grep -E "sospechosos|positivos"`
do
    echo $FILE
    BASENAME="$(basename -- $FILE)"
    FILE_DIR="${ROOT}/$(dirname "${FILE}")"

    TXT_FILE=$(echo $FILE | sed -e "s/${BASENAME}/txt\/${BASENAME}/" | sed -e "s/\.pdf/.txt/")
    HTML_FILE=$(echo $FILE | sed -e "s/${BASENAME}/html\/${BASENAME}/" | sed -e "s/\.pdf/.html/")
    CSV_FILE=$(echo $FILE | sed -e "s/${BASENAME}/csv\/${BASENAME}/" | sed -e "s/\.pdf/.csv/")

    if [ ! -f $TXT_FILE ]; then
        docker run --rm -i kadock/pdftotext < $FILE > $TXT_FILE
    fi

    if [ ! -f $HTML_FILE ]; then
        #docker run -ti --rm -v $FILE_DIR:/pdf bwits/pdf2htmlex pdf2htmlEX --zoom 1.3 $BASENAME
        docker run --rm -i -v $FILE_DIR:"/data" mercstudio/pdftohtml "/data/${BASENAME}"
        exit
        #mv $(echo $FILE | sed -e "s/\.pdf/.html/") $HTML_FILE
    fi

    if [ ! -f $CSV_FILE ]; then
        # TODO double check txt exists
        python test.python $TXT_FILE $CSV_FILE
    fi
done