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

            if len(values) > 1 and not "CASO" in values[0]:
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

        if "*" in line[1]:
            line[1] = line[1].replace("*", "")
            line.append("SI")
        else:
            line.append("NA")

        line.append(get_fixed_date(line[5]))
    
        # converting to uppercase the state and status        
        line = [col.upper() for col in line]
        # remove accents (keep ñ)
        line = [strip_accents(col) for col in line]
        # change date to iso format
        line = [re.sub("(\d+)/(\d+)/(\d+)", "\\3-\\2-\\1", col) for col in line]
        
        lines[key] = line
 
    return lines


# replacing excel dates
# see: https://stackoverflow.com/questions/14271791/converting-date-formats-python-unusual-date-formats-extract-ymd
def get_fixed_date(column):
    match = re.search(r'(\d{5})', column)
    if not match:
        return ""
    
    m = match.group().replace(" ", "").replace(",","")
    delta = datetime.timedelta(int(m)-2)
    date = datetime.date(1900, 1, 1) + delta
    date = str(date.strftime("%d/%m/%Y"))
    
    return date    



def strip_accents(text):
    """
    could have done this:
    https://stackoverflow.com/questions/517923/what-is-the-best-way-to-remove-accents-in-a-python-unicode-string
    """

    rep = {
        "Á": "A", 
        "É": "E",
        "Í": "I",
        "Ó": "O",
        "Ú": "U"
    }

    rep = dict((re.escape(k), v) for k, v in rep.items()) 
    pattern = re.compile("|".join(rep.keys()))
    text = pattern.sub(lambda m: rep[re.escape(m.group(0))], text)
    
    return text
     

def get_header():
    return [
        "caso",
        "estado",
        "localidad", 
        "sexo",
        "edad", 
        "fecha_sintomas", 
        "situacion", 
        "procedencia", 
        "fecha_llegada",
        "recuperado",
        "fecha_sintomas_corregido"
    ]

if __name__ == "__main__":
    main(sys.argv[1:])
