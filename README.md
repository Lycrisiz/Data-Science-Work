![image](https://github.com/user-attachments/assets/ce718991-cc97-443b-a1b8-e251dcf50533)![image](https://github.com/user-attachments/assets/2b042229-46a3-4909-be70-f18424babd4f)This repository contains some of my work in the field of data science and the code I have programmed in Python and R. Additionally, further down, you can see one of my most recent projects, in which I obtained data from the National Police ([open data](https://www.datos.gov.co)). I performed the respective cleaning and transformation of this data to later upload it to Power BI, with the corresponding relationships and the necessary dashboard.

![](https://github.com/Lycrisiz/Data-Science-Work/blob/main/Datos/imagen_2024-08-21_154505469.png?raw=true)

Primeramente estas relaciones se hicieron con el fin de que todos los datos manejasen un mismo idioma en lo que respecta a departamentos, fechas y municipios, asi mismo al momento de procesar los datos, se les agregó latitud y longitud cruzandolos con el fin de no obener errores en la graficas puesto que los datos consistian en varios reportes por dia y no un conglomerado diario, por lo que se creó una base diferente que consistió en los datos agrupados (gr) de esta forma se puede obtener mas informacion de los datos sin sacrificar la cantidad de reportes recibidos por dia.
 
![](https://github.com/Lycrisiz/Data-Science-Work/blob/main/Mi%20trabajo%20(resumido)%20-%20My%20Work%20(sumarized)/Semillero_page-0002.jpg?raw=true)

Este Primer Dashboard, permite visualizar, el historico de como han aumentado los reportes de hurto a travez del tiempo en Colombia

Las preguntas que deja son: 
¿por que la pendiente de los hurtos ha crecido desde 2016? 
¿que factores en la seguridad o el sistema de gobierno afectaron negativamente beneficiando lo hurtos?
Se puede apreciar como pese a voler a su tendencia habitual luego de la pandemia, las medidas de seguridad recientes, han sido efectivas en comparacion con 2023, 2024 presenta un mejor desempeño.

![](https://github.com/Lycrisiz/Data-Science-Work/blob/main/Mi%20trabajo%20(resumido)%20-%20My%20Work%20(sumarized)/Semillero_page-0003.jpg?raw=true)

Esta Segunda Hoja refleja, la cantidad de hurtos por lugar, para esto, se realizo un cruce con una base de datos que manejase latitud y longitud, puesto que Power Bi no distigue de algunos municipios con nombres iconicos (madrid) y las ciudades en las que se basan esos nombres.

![](https://github.com/Lycrisiz/Data-Science-Work/blob/main/Mi%20trabajo%20(resumido)%20-%20My%20Work%20(sumarized)/Semillero_page-0004.jpg?raw=true)

Esta Tercera hoja refleja la contra parte de los hurtos (azul) mostrando las capturas por dia que realiza la policia nacional, lastimosamente esta data esta limitada, 2010 - 2015 sin embago muestra una tendencia, la cual va en contra con lo apreciado anteiormente en la hoja de hurtos, pues, si bien las capaturas parecen ser pocas a principio de año, los hurtos no presentan esta tendencia, es decir, hay menor efectividad de la policia en esa epoca del año.

Por otra parte Se puede apreciar (verde) el informe de incautacion de armas, el cual, muestra, que en los ultimos años se han venido incautando menos armas, hasta 2023 en donde se puede evidenciar el salto grande, lo cual es un buen golpe en mejorar la seguridad por el cual quizás podria atribuirsele, la disminucion de hurtos en 2024 en comparacion con 2023.

![](https://github.com/Lycrisiz/Data-Science-Work/blob/main/Mi%20trabajo%20(resumido)%20-%20My%20Work%20(sumarized)/Semillero_page-0005.jpg?raw=true)

![](https://github.com/Lycrisiz/Data-Science-Work/blob/main/Mi%20trabajo%20(resumido)%20-%20My%20Work%20(sumarized)/Semillero_page-0006.jpg?raw=true)

Por ultimo y no menos importante se puede aprecial el mapa de capturas, el cual podria contrastasrse con el mapa de hurtos para comparar lado a lado en que departamentos y/o municipios de colombia se ha venido teniendo, menos efectividad, del cual se podrian realizar sanciones respectivas, o cambios en su directriz.

Codigo de python

```python
import pandas as pd
import datetime as dt
import unidecode
import numpy as np

```


```python

Ruta = r"C:\Users\danie\OneDrive\Documentos\Semillero"

R_IncautacionArmas = pd.read_csv(Ruta + r"\Reporte_Incautaci_n_de_Armas_de_Fuego_Polic_a_Nacional_20240702.csv",
                                 usecols=['DEPARTAMENTO', 'MUNICIPIO HECHO', 'CLASE BIEN','FECHA HECHO', 'CANTIDAD'])
R_HurtoModalida = pd.read_csv(Ruta + r"\HURTO_PERSONAS_20240718.csv", sep = ',',usecols=
                              ['FECHA HECHO', 'DEPARTAMENTO','MUNICIPIO','CANTIDAD'])
R_ViolenciaIF = pd.read_csv(Ruta + r"\Reporte_Delito_Violencia_Intrafamiliar_Polic_a_Nacional_20240702.csv",usecols=
                              ['DEPARTAMENTO', 'MUNICIPIO', 'ARMAS MEDIOS','FECHA HECHO', 'GENERO', 'GRUPO ETARIO', 'CANTIDAD'])
R_TerrorismoPN = pd.read_csv(Ruta + r"\Reporte_Delito_Terrorismo_Polic_a_Nacional_20240702.csv", sep = ',',usecols=
                              ['Departamento', 'Municipio','ARMAS MEDIOS','FECHA HECHO', 'CANTIDAD'])
R_CapturasPN = pd.read_csv(Ruta + r"\Reporte_Capturas_Polic_a_Nacional_de_Colombia_20240723.csv", sep = ',',usecols=
                              ['DEPARTAMENTO', 'MUNICIPIO','FECHA HECHO', 'GENERO','DESCRIPCION CONDUCTA CAPTURA', 'GRUPO ETARIO', 'CANTIDAD'])
R_DelitosSexuales = pd.read_csv(Ruta + r"\Reporte__Delitos_sexuales_Polic_a_Nacional_20240702.csv",usecols=
                              ['DEPARTAMENTO', 'MUNICIPIO','ARMAS MEDIOS','FECHA HECHO', 'GENERO', 'GRUPO ETARIO', 'CANTIDAD', 'delito'])
R_RecuperacionVehiculos = pd.read_csv(Ruta + r"\Recuperaci_n_Veh_culos_Polic_a_Nacional_20240702.csv",usecols=
                              ['DEPARTAMENTO', 'MUNICIPIO','CLASE BIEN', 'FECHA HECHO','CANTIDAD'])
R_HomicidiosAccidente = pd.read_csv(Ruta + r"\Homicidios_accidente_de_tr_nsito_Polic_a_Nacional_20240702.csv",usecols=
                              ['DEPARTAMENTO', 'MUNICIPIO','ARMAS MEDIOS','FECHA HECHO', 'GENERO', 'GRUPO ETARÍO', 'DESCRIPCIÓN CONDUCTA','CANTIDAD'])
R_AmenazasPN = pd.read_csv(Ruta + r"\Amenazas_Polic_a_Nacional_de_Colombia_20240702.csv",usecols=
                              ['DEPARTAMENTO', 'MUNICIPIO','ARMAS MEDIOS','FECHA HECHO', 'GENERO', 'GRUPO ETARIO', 'CANTIDAD'])
R_Subregiones = pd.read_excel(Ruta + r"\subregiones.xlsx")

Info = [R_IncautacionArmas,
R_HurtoModalida,
R_ViolenciaIF,
R_TerrorismoPN,
R_CapturasPN,
R_DelitosSexuales,
R_RecuperacionVehiculos,
R_HomicidiosAccidente,
R_AmenazasPN ]
```


```python
columna_a_mover = Info[1].pop('DEPARTAMENTO')
Info[1].insert(0, 'DEPARTAMENTO', columna_a_mover)
Info[0] = Info[0].rename(columns={'MUNICIPIO HECHO': 'MUNICIPIO'})
Info[3] = Info[3].rename(columns={'Municipio': 'MUNICIPIO'})
Info[3] = Info[3].rename(columns={'Departamento': 'DEPARTAMENTO'})
Info[1] = Info[1].rename(columns={'COD_DEPTO': 'CODIGO DANE'})
Info[1]['DEPARTAMENTO'] = Info[1]['DEPARTAMENTO'].replace({'BOGOTA, D.C.':'BOGOTA D.C.'})

```


```python
Cambios_I = {'NO REPORTA':'NO REPORTADO'}
Cambios_R = {'VALLE DEL CAUCA': 'VALLE','LA GUAJIRA':'GUAJIRA','ARCHIPIELAGO DE SAN ANDRES':'SAN ANDRES','BOGOTA, D. C.':'BOGOTA D.C.','ARCHIPIELAGO DE SAN ANDRES, PROVIDENCIA Y ':'SAN ANDRES','SAN ANDRES ISLAS':'SAN ANDRES',
             'ARCHIPIELAGO DE SAN ANDRES, PROVIDENCIA Y SANTA CATALINA':'SAN ANDRES'}
for idx, i in enumerate(Info):
    Info[idx]['DEPARTAMENTO'] = i['DEPARTAMENTO'].apply(lambda x: x.upper())
    Info[idx]['DEPARTAMENTO'] = i['DEPARTAMENTO'].apply(lambda x: '' if str(x)=='nan' else str(x).replace('Á', 'A').replace('É', 'E').replace('Í', 'I').replace('Ó', 'O').replace('Ú', 'U').replace('Ñ', 'N'))
    Info[idx]['DEPARTAMENTO'] = i['DEPARTAMENTO'].replace(Cambios_I)
    Info[idx]['DEPARTAMENTO'] = i['DEPARTAMENTO'].replace(Cambios_R)
    Info[idx]['DEPARTAMENTO'] = i['DEPARTAMENTO'].apply(lambda x: x.replace(',',''))
    Info[idx]['DEPARTAMENTO'] = i['DEPARTAMENTO'].apply(lambda x: x.strip())

    
    Info[idx]['MUNICIPIO'] = i['MUNICIPIO'].apply(lambda x: x.upper())
    Info[idx]['MUNICIPIO'] = i['MUNICIPIO'].apply(lambda x: '' if str(x)=='nan' else str(x).replace('Á', 'A').replace('É', 'E').replace('Í', 'I').replace('Ó', 'O').replace('Ú', 'U').replace('Ñ', 'N'))
    Info[idx]['MUNICIPIO'] = i['MUNICIPIO'].replace(Cambios_I)
    Info[idx]['MUNICIPIO'] = i['MUNICIPIO'].apply(lambda x: x.replace(' (CT)',''))
    Info[idx]['MUNICIPIO'] = i['MUNICIPIO'].apply(lambda x: x.replace('(CT)',''))
    Info[idx]['MUNICIPIO'] = i['MUNICIPIO'].apply(lambda x: x.replace(',',''))
    Info[idx]['MUNICIPIO'] = i['MUNICIPIO'].apply(lambda x: x.strip())

R_Subregiones['NOMBRE_DEPTO'] = R_Subregiones['NOMBRE_DEPTO'].apply(lambda x: str(x).upper())
R_Subregiones['NOMBRE_DEPTO'] = R_Subregiones['NOMBRE_DEPTO'].apply(lambda x: '' if str(x)=='nan' else str(x).replace('Á', 'A').replace('É', 'E').replace('Í', 'I').replace('Ó', 'O').replace('Ú', 'U').replace('Ñ', 'N'))
R_Subregiones['NOMBRE_DEPTO'] = R_Subregiones['NOMBRE_DEPTO'].replace(Cambios_R)
R_Subregiones['NOMBRE_MPIO'] = R_Subregiones['NOMBRE_MPIO'].apply(lambda x: str(x).upper())
R_Subregiones['NOMBRE_MPIO'] = R_Subregiones['NOMBRE_MPIO'].apply(lambda x: '' if str(x)=='nan' else str(x).replace('Á', 'A').replace('É', 'E').replace('Í', 'I').replace('Ó', 'O').replace('Ú', 'U').replace('Ñ', 'N'))

for idx, i in enumerate(Info):
    Info[idx]['DEPARTAMENTO'] = i.apply(lambda x: 'BOGOTA D.C.' if x['MUNICIPIO'] == 'BOGOTA D.C.' else x['DEPARTAMENTO'], axis=1)
```


```python
Info[0].tail()
```

```python
R_Subregiones = pd.concat([R_Subregiones,pd.DataFrame([{'NOMBRE_DEPTO':'NO REPORTADO', 'PROVINCIA':'NO REPORTADO', 'CODIGO_MUNICIPIO':0, 'NOMBRE_MPIO':'NO REPORTADO',
       'Nombre':'NO REPORTADO'}])],ignore_index=True)
```


```python
Info[4] = Info[4].drop(Info[4][Info[4]['DEPARTAMENTO'].isin(['FLORIDA','MADRID','NEW JERSEY','NEW YORK','QUITO'])].index)
```


```python
Deptos = R_Subregiones['NOMBRE_DEPTO'].unique()
for i in Info:
    l = i['DEPARTAMENTO'].unique()
    print("-------")
    r = True
    for j in l:
        if j not in Deptos:
            print(j)
            r = False
    print(r)

```

    -------
    True
    -------
    True
    -------
    True
    -------
    True
    -------
    True
    -------
    True
    -------
    True
    -------
    True
    -------
    True
    


```python
for i in Info:
    i['FECHA HECHO'] = i['FECHA HECHO'].apply(lambda x: str(x))
```


```python
R_Subregiones['Pais'] = 'Colombia'
```


```python
Cambios_RT = {'-':'NO REPORTADO','NO REPORTA':'NO REPORTADO'}
for i in Info:
    if 'GENERO' in i.columns:
        i['GENERO'] = i['GENERO'].replace(Cambios_RT)
    if 'ARMAS MEDIOS' in i.columns:
        i['ARMAS MEDIOS'] = i['ARMAS MEDIOS'].replace(Cambios_RT)
```


```python
Cords = pd.read_excel(Ruta + r"\8. Clasificador Geográfico.xlsx", skiprows=5, usecols=[3,4,7,9])
Cords['Latitud'] = Cords['Latitud'].apply(lambda x: x.replace(',','.'))
Cords['Longitud'] = Cords['Longitud'].apply(lambda x: x.replace(',','.'))
Cords['Latitud'] = Cords['Latitud'].astype(float)
Cords['Longitud'] = Cords['Longitud'].astype(float)

Cords2 = pd.read_excel(Ruta + r"\Geoportal del DANE - Codificación Divipola.xlsx", skiprows=1, usecols=[3,4,7,8])
Cords['Longitud'] = Cords['Longitud'].apply(lambda x: -1*x if x > 0 else x)
Cords2['Longitud'] = Cords2['Longitud'].apply(lambda x: -1*x if x > 0 else x)
```


```python
Cords['Nombre Departamento'] = Cords['Nombre Departamento'].apply(lambda x: '' if str(x)=='nan' else str(x).replace('Á', 'A').replace('É', 'E').replace('Í', 'I').replace('Ó', 'O').replace('Ú', 'U').replace('Ñ', 'N'))
Cords['Nombre Municipio'] = Cords['Nombre Municipio'].apply(lambda x: '' if str(x)=='nan' else str(x).replace('Á', 'A').replace('É', 'E').replace('Í', 'I').replace('Ó', 'O').replace('Ú', 'U').replace('Ñ', 'N'))
Cords['Nombre Departamento'] = Cords['Nombre Departamento'].replace(Cambios_R)

Cords2['Nombre Departamento'] = Cords2['Nombre Departamento'].apply(lambda x: '' if str(x)=='nan' else str(x).replace('Á', 'A').replace('É', 'E').replace('Í', 'I').replace('Ó', 'O').replace('Ú', 'U').replace('Ñ', 'N'))
Cords2['Nombre Municipio'] = Cords2['Nombre Municipio'].apply(lambda x: '' if str(x)=='nan' else str(x).replace('Á', 'A').replace('É', 'E').replace('Í', 'I').replace('Ó', 'O').replace('Ú', 'U').replace('Ñ', 'N'))
Cords2['Nombre Departamento'] = Cords2['Nombre Departamento'].replace(Cambios_R)

Cords2['Nombre Municipio'] = Cords2['Nombre Municipio'].apply(lambda x: x.replace(' (CT)',''))
Cords2['Nombre Municipio'] = Cords2['Nombre Municipio'].apply(lambda x: x.replace('(CT)',''))
Cords2['Nombre Municipio'] = Cords2['Nombre Municipio'].apply(lambda x: x.replace(',',''))

Cords['Nombre Municipio'] = Cords['Nombre Municipio'].apply(lambda x: x.replace(' (CT)',''))
Cords['Nombre Municipio'] = Cords['Nombre Municipio'].apply(lambda x: x.replace('(CT)',''))
Cords['Nombre Municipio'] = Cords['Nombre Municipio'].apply(lambda x: x.replace(',',''))
```


```python
Cords2tp = Cords2.drop(Cords2[(Cords2['Latitud']==0) | (Cords2['Latitud']==0)].index)
Cords2tp = Cords2.drop(Cords2[(Cords2['Longitud']==0) | (Cords2['Longitud']==0)].index)
Cordstp = Cords.drop(Cords[(Cords['Latitud']==0) | (Cords['Latitud']==0)].index)
Cordstp = Cords.drop(Cords[(Cords['Longitud']==0) | (Cords['Longitud']==0)].index)

Cords = Cords.groupby(['Nombre Departamento', 'Nombre Municipio']).agg({'Latitud': 'mean', 'Longitud': 'mean'}).reset_index()
Cords2 = Cords2.groupby(['Nombre Departamento', 'Nombre Municipio']).agg({'Latitud': 'mean', 'Longitud': 'mean'}).reset_index()

Cordstp = Cordstp.groupby(['Nombre Departamento', 'Nombre Municipio']).agg({'Latitud': 'mean', 'Longitud': 'mean'}).reset_index()
Cords2tp = Cords2tp.groupby(['Nombre Departamento', 'Nombre Municipio']).agg({'Latitud': 'mean', 'Longitud': 'mean'}).reset_index()
```


```python
for i in Cords['Nombre Departamento'].unique():
    if i not in Deptos:
        print(i)
print('-----')
for i in Cords2['Nombre Departamento'].unique():
    if i not in Deptos:
        print(i)
```

    -----
    


```python
Crossut = Cordstp.merge(Cords2tp,on=['Nombre Departamento', 'Nombre Municipio'], how='outer')
for idx, i in enumerate(Info):
    if 'DEPARTAMENTO' in i.columns  and 'MUNICIPIO' in i.columns:
        print('T')
        Info[idx] = i.merge(Crossut, left_on=['DEPARTAMENTO', 'MUNICIPIO'], right_on=['Nombre Departamento', 'Nombre Municipio'], how='left')
        Info[idx]['Latitud_x'] = Info[idx].apply(lambda x: x['Latitud_y'] if np.isnan(x['Latitud_x']) else x['Latitud_x'], axis = 1)
        Info[idx]['Longitud_x'] = Info[idx].apply(lambda x: x['Longitud_y'] if np.isnan(x['Longitud_x']) else x['Longitud_x'], axis = 1)
        Info[idx].drop(['Longitud_y','Latitud_y','Nombre Departamento','Nombre Municipio'],inplace=True, axis = 1)
        Info[idx]= Info[idx].rename(columns={'Latitud_x': 'Latitud'})
        Info[idx]= Info[idx].rename(columns={'Longitud_x': 'Longitud'})
```

    T
    T
    T
    T
    T
    T
    T
    T
    T
    


```python
Info[0]
```

```python
Info[0].to_excel(Ruta + r'\python\Datos modificados' + r"\Reporte_Incautaci_n_de_Armas_de_Fuego_Polic_a_Nacional_20240702_py.xlsx",sheet_name='Reporte_Incautaci_n_de_Armas_de_Fuego_Polic_a_Nacional',index = False)
Info[1].to_excel(Ruta + r'\python\Datos modificados' + r"\HURTO_PERSONAS_20240718_py.xlsx",sheet_name='HURTO_PERSONAS_20240718',index = False)
Info[2].to_excel(Ruta + r'\python\Datos modificados' + r"\Reporte_Delito_Violencia_Intrafamiliar_Polic_a_Nacional_20240702_py.xlsx",sheet_name='Reporte_Delito_Violencia_Intrafamiliar_Polic_a_Nacional_20240702',index = False)
Info[3].to_excel(Ruta + r'\python\Datos modificados' + r"\Reporte_Delito_Terrorismo_Polic_a_Nacional_20240702_py.xlsx",sheet_name='Reporte_Delito_Terrorismo_Polic_a_Nacional',index = False)
Info[4].to_excel(Ruta + r'\python\Datos modificados' + r"\Reporte_Capturas_Polic_a_Nacional_de_Colombia_20240620_py.xlsx",sheet_name='Reporte_Capturas_Polic_a_Nacional_de_Colombia',index = False)
Info[5].to_excel(Ruta + r'\python\Datos modificados' + r"\Reporte__Delitos_sexuales_Polic_a_Nacional_20240702_py.xlsx",sheet_name='Reporte__Delitos_sexuales_Polic_a_Nacional',index = False)
Info[6].to_excel(Ruta + r'\python\Datos modificados' + r"\Recuperaci_n_Veh_culos_Polic_a_Nacional_20240702_py.xlsx",sheet_name='Recuperaci_n_Veh_culos_Polic_a_Nacional',index = False)
Info[7].to_excel(Ruta + r'\python\Datos modificados' + r"\Homicidios_accidente_de_tr_nsito_Polic_a_Nacional_20240702_py.xlsx",sheet_name='Homicidios_accidente_de_tr_nsito_Polic_a_Nacional',index = False)
Info[8].to_excel(Ruta + r'\python\Datos modificados' + r"\Amenazas_Polic_a_Nacional_de_Colombia_20240702_py.xlsx",sheet_name='Amenazas_Polic_a_Nacional_de_Colombia',index = False)
R_Subregiones.to_excel(Ruta + r'\python\Datos modificados' + r"\subregiones_py.xlsx",sheet_name='subregiones',index = False)
```

```python
TablaDeptos = R_Subregiones['NOMBRE_DEPTO'].unique()
TablaMunicipios = R_Subregiones['NOMBRE_MPIO'].unique()
TablaDeptos = pd.DataFrame(TablaDeptos)
TablaMunicipios = pd.DataFrame(TablaMunicipios)
TablaDeptos.columns = ['DEPARTAMENTO']
TablaMunicipios.columns = ['MUNICIPIOS']
TablaDeptos.dropna(inplace=True)
TablaMunicipios.dropna(inplace=True)
TablaDeptos['DEPARTAMENTO'] = TablaDeptos['DEPARTAMENTO'].apply(lambda x: str(x).strip())
TablaMunicipios['MUNICIPIOS'] = TablaMunicipios['MUNICIPIOS'].apply(lambda x: str(x).strip())
TablaDeptos.drop(TablaDeptos[TablaDeptos['DEPARTAMENTO']=='NAN'].index,inplace=True)
TablaMunicipios.drop(TablaMunicipios[TablaMunicipios['MUNICIPIOS']=='NAN'].index,inplace=True)
```


```python
Info_grpoup = [[] for i in range(len(Info))]
for i in range(len(Info)):
    Info_grpoup[i] = Info[i].groupby('FECHA HECHO').sum('CANTIDAD')
```


```python
Info_grpoup[0].to_excel(Ruta + r'\python\Datos modificados' + r"\Grouped_Reporte_Incautaci_n_de_Armas_de_Fuego_Polic_a_Nacional_20240702_py.xlsx",sheet_name='Gr_Reporte_Incautaci_n_de_Armas_de_Fuego_Polic_a_Nacional',index = True)
Info_grpoup[1].to_excel(Ruta + r'\python\Datos modificados' + r"\Grouped_HURTO_PERSONAS_20240718_py.xlsx",sheet_name='Gr_HURTO_PERSONAS_20240718',index = True)
Info_grpoup[2].to_excel(Ruta + r'\python\Datos modificados' + r"\Grouped_Reporte_Delito_Violencia_Intrafamiliar_Polic_a_Nacional_20240702_py.xlsx",sheet_name='Gr_Reporte_Delito_Violencia_Intrafamiliar_Polic_a_Nacional_20240702',index = True)
Info_grpoup[3].to_excel(Ruta + r'\python\Datos modificados' + r"\Grouped_Reporte_Delito_Terrorismo_Polic_a_Nacional_20240702_py.xlsx",sheet_name='Gr_Reporte_Delito_Terrorismo_Polic_a_Nacional',index = True)
Info_grpoup[4].to_excel(Ruta + r'\python\Datos modificados' + r"\Grouped_Reporte_Capturas_Polic_a_Nacional_de_Colombia_20240620_py.xlsx",sheet_name='Gr_Reporte_Capturas_Polic_a_Nacional_de_Colombia',index = True)
Info_grpoup[5].to_excel(Ruta + r'\python\Datos modificados' + r"\Grouped_Reporte__Delitos_sexuales_Polic_a_Nacional_20240702_py.xlsx",sheet_name='Gr_Reporte__Delitos_sexuales_Polic_a_Nacional',index = True)
Info_grpoup[6].to_excel(Ruta + r'\python\Datos modificados' + r"\Grouped_Recuperaci_n_Veh_culos_Polic_a_Nacional_20240702_py.xlsx",sheet_name='Gr_Recuperaci_n_Veh_culos_Polic_a_Nacional',index = True)
Info_grpoup[7].to_excel(Ruta + r'\python\Datos modificados' + r"\Grouped_Homicidios_accidente_de_tr_nsito_Polic_a_Nacional_20240702_py.xlsx",sheet_name='Gr_Homicidios_accidente_de_tr_nsito_Polic_a_Nacional',index = True)
Info_grpoup[8].to_excel(Ruta + r'\python\Datos modificados' + r"\Grouped_Amenazas_Polic_a_Nacional_de_Colombia_20240702_py.xlsx",sheet_name='Gr_Amenazas_Polic_a_Nacional_de_Colombia',index = True)
```

```python
Cords.to_excel(Ruta + r'\python\Datos modificados' + r"\Clasificador_Geográfico_py.xlsx",sheet_name='Geoclasificador',index = False)
Cords2.to_excel(Ruta + r'\python\Datos modificados' + r"\Geoportal_Divipola_py.xlsx",sheet_name='Geoclasificador2',index = False)
```


```python
TablaDeptos.to_excel(Ruta + r'\python\Datos modificados' + r"\TablaDeptos_py.xlsx",sheet_name='Dp_subregiones',index = False, header=False)
TablaMunicipios.to_excel(Ruta + r'\python\Datos modificados' + r"\TablaMuni_py.xlsx",sheet_name='Mn_subregiones',index = False, header=False)
```


```python
Info[1][(Info[1]['DEPARTAMENTO'] == 'BOGOTA D.C.') & (Info[1]['Latitud'].isna())]
```


