En esta Carpeta Contengo los archivos de Python en los que he trabajado, son la demostracion de mi conocimiento en Python
In this folder, I have the Python files I have worked on. They demonstrate my knowledge in Python.

```python
import pandas as pd
import datetime as dt
import unidecode
import numpy as np

```

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

