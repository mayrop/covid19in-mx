import re
import datetime
import csv
import sys 
import codecs
from bs4 import BeautifulSoup

def main(args):
    source, destination = parse_args(args)
    soup = get_soup(source)

    lines = get_lines(soup)
    lines = fix_lines(lines)

    with open(destination, 'w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(get_header()) 
        for key, values in lines.items():
            values = [None if x == '' or x == "NA" else x for x in values]

            if len(values) > 1 and not "Caso" in values[0] and values[1] != "1":
                writer.writerow(values) 


def parse_args(argv):
    if len(argv) < 2:
        print('usage: test.py <source> <destination>')
        exit()

    # TODO: improve & error handling

    return argv[0], argv[1]


def get_soup(source):
    file = codecs.open(source, 'r')
    soup = BeautifulSoup(file.read(), 'html.parser')
    file.close()

    return soup    


def get_lines(soup):
    ids = re.findall(r"id\s*=\s*\"(pf\w+)\"", str(soup.contents))

    lines = {}
    for div_id in ids:
        pdf_html = soup.find(id=str(div_id))
        divs_html = pdf_html.find_all("div", class_="c")

        for div in divs_html: 
            # TODO: error handling
            row_id = str(div_id) + "_" + div["class"][2]
            
            if row_id not in lines:
                lines[row_id] = list()

            lines[row_id].append(str(div.get_text()).strip())

    return lines 


def fix_lines(lines):
    for key, line in lines.items():
        if len(line) == 1:
            continue

        if line[3] not in ["M", "F"]:
            line.insert(2, "")

        orig_date, new_date = get_original_date(line[5])
        line[5] = new_date

        line.append(orig_date)

        if "*" in line[1]:
            line[1] = line[1].replace("*", "")
            line.append("*")
        else:
            line.append("")
            
        # converting to uppercase the state and status
        line[1] = line[1].upper() # state
        line[2] = line[2].upper() # locality
        line[6] = line[6].upper() # status
        line[7] = line[7].upper() # where they come from
        
        line.insert(9, "NO")
        
        if "CONTACTO" in line[7]:
            line[9] = "SI"
            line[7] = re.sub(r"CONTACTO(?:\s*[,/]\s*)?(.*)", "\\1", line[7])
        
        # converting to uppercase the state
    return lines


# replacing excel dates
# see: https://stackoverflow.com/questions/14271791/converting-date-formats-python-unusual-date-formats-extract-ymd
def get_original_date(column):
    match = re.search(r'(\d{5})', column)
    if not match:
        return "", column
    
    m = match.group().replace(" ", "").replace(",","")
    delta = datetime.timedelta(int(m)-2)
    date = datetime.date(1900, 1, 1) + delta
    date = str(date.strftime("%d/%m/%Y"))
    
    return str(m), date   

def get_header():
    return [
        "Caso", "Estado", "Localidad", 
        "Sexo", "Edad", "FechaInicioSintomas", 
        "Identificacion", "Procedencia", "FechaLlegada",
        "Contacto",
        "FechaInicioSintomasOriginal", "Recuperado"
    ]

if __name__ == "__main__":
    main(sys.argv[1:])