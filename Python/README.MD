En esta Carpeta Contengo los archivos de Python en los que he trabajado, son la demostracion de mi conocimiento en Python
In this folder, I have the Python files I have worked on. They demonstrate my knowledge in Python.

##INFORME975.IPYNB

```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from datetime import datetime
import xlrd
import openpyxl

IF975 = pd.read_excel("..\Excels\Informe 975\Informe 975 Mayo.xlsx")
Fechayear = '2023/01/01'
Fechacorte = '2023/05/31'

def ancb(row):
    #p = pd.to_datetime(row['FECHA FIN OTRO SI']
    n = pd.to_datetime(row['FECHA FIN OTRO SI'])
    m = pd.to_datetime(row['011_FECHA_AUMENTO'])
    t = row['014_VALOR']
    p1 = pd.to_datetime(Fechayear,format='%Y/%m/%d')
    q1 = pd.to_datetime(Fechacorte,format='%Y/%m/%d')
    if (n.year >= 2023 and t != 0 and n.month >= p1.month and m.month <= q1.month):
        return str(n.year)
    else:
        return ''
def FFOS(x,y):
    if x == x.shift():
        return y.shift()
    else:
        return y
def INTE(x):
    try:
        return int(x)
    except:
        return 10**18
def INTE2(x):
    if x== 10**18:
        return ""
    else:
        return str(x)

fc = pd.to_datetime(IF975["011_FECHA_AUMENTO"], '%d/%m/%Y')
fc = fc.apply(lambda x: x.toordinal())
fc = fc.apply(lambda x: str(x - datetime(1899, 12, 30).toordinal()))
IF975['006_EMP_CODIGO'] = IF975['006_EMP_CODIGO'].apply(INTE)
IF975.sort_values(by=['006_EMP_CODIGO',"011_FECHA_AUMENTO"], ascending=[True,False],inplace=True)
IF975['006_EMP_CODIGO'] = IF975['006_EMP_CODIGO'].apply(INTE2)
IF975.insert(5 ,"CLAVE REPETIDOS",pd.concat([IF975['006_EMP_CODIGO'].astype(str),fc],axis=1).apply(''.join, axis=1))
IF975.insert(12,"FECHA FIN OTRO SI",np.where(IF975['006_EMP_CODIGO'].eq(IF975['006_EMP_CODIGO'].shift()),IF975['011_FECHA_AUMENTO'].shift(),IF975['011_FECHA_AUMENTO']))
IF975.insert(13,datetime.strptime("1/1/2023", '%d/%m/%Y').strftime('%d/%m/%Y'),"")
IF975.insert(14,datetime.strptime("30/6/2023", '%d/%m/%Y').strftime('%d/%m/%Y'),"")
IF975.insert(13,"AÑO CAMBIO",IF975.apply(ancb,axis=1))
IF975.insert(6 ,"CLAVE",pd.concat([IF975["006_EMP_CODIGO"].astype(str),IF975["AÑO CAMBIO"].astype(str)],axis=1).apply(''.join, axis=1))


IF975.to_excel("../Drops py/Informe 975 Mayo_py.xlsx", sheet_name='Hoja1', index=False)
```


```python

#IF975["011_FECHA_AUMENTO"] = pd.to_datetime(IF975["011_FECHA_AUMENTO"].dt.date)
#IF975["FECHA FIN OTRO SI"] = pd.to_datetime(IF975["FECHA FIN OTRO SI"].dt.date)
#IF975["017_FECHA_CAMBIO_JOR"] = pd.to_datetime(IF975["017_FECHA_CAMBIO_JOR"].dt.date)
#IF975["019_FECHA_ANT_CAMBIO_JOR"] = pd.to_datetime(IF975["019_FECHA_ANT_CAMBIO_JOR"].dt.date)
#IF975["021_FECHA_CAMB_HOR_X_DIA"] = pd.to_datetime(IF975["021_FECHA_CAMB_HOR_X_DIA"].dt.date)

```


##Script_CertificacionesALi.ipynb

```python
from docx import Document
import pandas as pd
from docx2pdf import convert

DTPC = pd.read_excel("../Excels/Ali/Datos para Certificacion - copia.xlsx") #lee un excel con la informacion a automatizar
def modificar_documento(x):

    #este modulo filtra por categoria, hay distintos formatos de documentos que se deben leer, como formato 1 formato 2 etc...
    #dependiendo de una columna en excel que se llama proyecto, esta columna la usas para seleccionar el formato

    if x['PROYECTO'] == "HUB":
        doc = Document("..\Excels\Ali\Hub infinity.docx") #selecciono el tipo de documento 
        save = "../Drops py/Ali Drops/Certificacion HUB INFINITY "+str(x['NOMBRE'])+".docx" #selecciono como lo voy a guardar
    if x['PROYECTO'] == "SLT":
        doc = Document("..\Excels\Ali\Slt.docx")
        save = "../Drops py/Ali Drops/Certificacion STL "+str(x['NOMBRE'])+".docx"
    if x['PROYECTO'] == "VENTA EMPRESA":
        doc = Document("..\Excels\Ali\Venta empresa.docx")
        save = "../Drops py/Ali Drops/Certificacion VENTA EMPRESA "+str(x['NOMBRE'])+".docx"
    if x['PROYECTO'] == "OMNICANAL":
        doc = Document("..\Excels\Ali\Omnicanal.docx")
        save = "../Drops py/Ali Drops/Certificacion OMNICANAL "+str(x['NOMBRE'])+".docx"
    if x['PROYECTO'] == "ROBOTS":
        doc = Document("..\Excels\Ali\Robots.docx")# = C:\\Users\\Usuario\\Documents\\Excels\Ali\Robots.docx
        save = "../Drops py/Ali Drops/Certificacion ROBOTS "+str(x['NOMBRE'])+".docx"


    #codigo
    if int(x['NUMERO MESES']) == x['NUMERO MESES']:
        val = int(x['NUMERO MESES']) #es como un astype, consume memoria al arreglar las variables dentro del codigo
    else: 
        val  = x['NUMERO MESES']

    
    for paragraph in doc.paragraphs:
        #importa el texto, tiene un error y lo importa mal, tiene muchos saltos de lina pero es lo suficientemente bueno para que funcione
        #en el documento los remplazables los modifiqué asi "vvvvvvvvvvb" para que no me modifiqe el resto del documento, son keys por asi decirlo
        if "vvvvvvvvvvb" in paragraph.text:
                inline = paragraph.runs
                for i in range(len(inline)):
                    if "vvvvvvvvvvb" in inline[i].text:
                        text = inline[i].text.replace("vvvvvvvvvvb",x['NOMBRE'])
                        inline[i].text = text
    for paragraph in doc.paragraphs: #si no estoy mal importa el parrafo
        if "vvvvvvvvvvc" in paragraph.text: #pregunta si la key esta en el parrafo
                inline = paragraph.runs #in line es como las lineas del parrafo
                for i in range(len(inline)):
                    if "vvvvvvvvvvc" in inline[i].text: #pregunta si en alguna linea encuentra lo que debe modificar
                        text = inline[i].text.replace("vvvvvvvvvvc",str(x['CEDULA'])) #remplaza el valor por el de excel
                        inline[i].text = text#sobre escribe el valor 
    for paragraph in doc.paragraphs:
        if "vvvvvvvvvvd" in paragraph.text:
                inline = paragraph.runs
                for i in range(len(inline)):
                    if "vvvvvvvvvvd" in inline[i].text:
                        text = inline[i].text.replace("vvvvvvvvvvd", str(x['CARGO']))
                        inline[i].text = text
    for paragraph in doc.paragraphs:
        if "vvvvvvvvvve" in paragraph.text:
                inline = paragraph.runs
                for i in range(len(inline)):
                    if "vvvvvvvvvve" in inline[i].text:
                        text = inline[i].text.replace("vvvvvvvvvve", str(x['% PROYECTO'])+"%")
                        inline[i].text = text
    for paragraph in doc.paragraphs:
        if "vvvvvvvvvvf" in paragraph.text:
                inline = paragraph.runs
                for i in range(len(inline)):
                    if "vvvvvvvvvvf" in inline[i].text:
                        text = inline[i].text.replace("vvvvvvvvvvf", str(val))
                        inline[i].text = text
    for paragraph in doc.paragraphs: 
        if "vvvvvvvvvvg" in paragraph.text:
                inline = paragraph.runs
                for i in range(len(inline)):
                    if "vvvvvvvvvvg" in inline[i].text:
                        text = inline[i].text.replace("vvvvvvvvvvg", str(x['VALOR A CERTIFICAR']))
                        inline[i].text = text
                        #modifica todo el texto, y lo guarda 
    doc.save(save)
    convert(save) #y lo convierte a pdf 
DTPC.apply(lambda x: modificar_documento(x), axis = 1) #aplica la funcion
```

