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




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>DEPARTAMENTO</th>
      <th>MUNICIPIO</th>
      <th>CLASE BIEN</th>
      <th>FECHA HECHO</th>
      <th>CANTIDAD</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>281474</th>
      <td>VALLE</td>
      <td>CALI</td>
      <td>SUBAMETRALLADORA</td>
      <td>02/02/2024</td>
      <td>1</td>
    </tr>
    <tr>
      <th>281475</th>
      <td>CAUCA</td>
      <td>POPAYAN</td>
      <td>SUBAMETRALLADORA TRAUMATICA</td>
      <td>05/04/2024</td>
      <td>8</td>
    </tr>
    <tr>
      <th>281476</th>
      <td>CORDOBA</td>
      <td>CHINU</td>
      <td>SUBAMETRALLADORA TRAUMATICA</td>
      <td>21/02/2024</td>
      <td>1</td>
    </tr>
    <tr>
      <th>281477</th>
      <td>NORTE DE SANTANDER</td>
      <td>OCANA</td>
      <td>SUBAMETRALLADORA TRAUMATICA</td>
      <td>26/02/2024</td>
      <td>1</td>
    </tr>
    <tr>
      <th>281478</th>
      <td>RISARALDA</td>
      <td>SANTA ROSA DE CABAL</td>
      <td>SUBAMETRALLADORA TRAUMATICA</td>
      <td>06/04/2024</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
</div>




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




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>DEPARTAMENTO</th>
      <th>MUNICIPIO</th>
      <th>CLASE BIEN</th>
      <th>FECHA HECHO</th>
      <th>CANTIDAD</th>
      <th>Latitud</th>
      <th>Longitud</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>ANTIOQUIA</td>
      <td>FREDONIA</td>
      <td>ESCOPETA</td>
      <td>01/01/2010</td>
      <td>1</td>
      <td>5.901031</td>
      <td>-75.690195</td>
    </tr>
    <tr>
      <th>1</th>
      <td>ATLANTICO</td>
      <td>BARRANQUILLA</td>
      <td>ESCOPETA</td>
      <td>01/01/2010</td>
      <td>1</td>
      <td>10.978320</td>
      <td>-74.813217</td>
    </tr>
    <tr>
      <th>2</th>
      <td>BOLIVAR</td>
      <td>MARIA LA BAJA</td>
      <td>ESCOPETA</td>
      <td>01/01/2010</td>
      <td>1</td>
      <td>9.954484</td>
      <td>-75.331563</td>
    </tr>
    <tr>
      <th>3</th>
      <td>BOYACA</td>
      <td>SUTATENZA</td>
      <td>ESCOPETA</td>
      <td>01/01/2010</td>
      <td>1</td>
      <td>5.022988</td>
      <td>-73.452314</td>
    </tr>
    <tr>
      <th>4</th>
      <td>CESAR</td>
      <td>AGUACHICA</td>
      <td>ESCOPETA</td>
      <td>01/01/2010</td>
      <td>1</td>
      <td>8.190891</td>
      <td>-73.661692</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>281474</th>
      <td>VALLE</td>
      <td>CALI</td>
      <td>SUBAMETRALLADORA</td>
      <td>02/02/2024</td>
      <td>1</td>
      <td>3.407032</td>
      <td>-76.561413</td>
    </tr>
    <tr>
      <th>281475</th>
      <td>CAUCA</td>
      <td>POPAYAN</td>
      <td>SUBAMETRALLADORA TRAUMATICA</td>
      <td>05/04/2024</td>
      <td>8</td>
      <td>2.470939</td>
      <td>-76.599722</td>
    </tr>
    <tr>
      <th>281476</th>
      <td>CORDOBA</td>
      <td>CHINU</td>
      <td>SUBAMETRALLADORA TRAUMATICA</td>
      <td>21/02/2024</td>
      <td>1</td>
      <td>9.033351</td>
      <td>-75.362116</td>
    </tr>
    <tr>
      <th>281477</th>
      <td>NORTE DE SANTANDER</td>
      <td>OCANA</td>
      <td>SUBAMETRALLADORA TRAUMATICA</td>
      <td>26/02/2024</td>
      <td>1</td>
      <td>8.263934</td>
      <td>-73.352502</td>
    </tr>
    <tr>
      <th>281478</th>
      <td>RISARALDA</td>
      <td>SANTA ROSA DE CABAL</td>
      <td>SUBAMETRALLADORA TRAUMATICA</td>
      <td>06/04/2024</td>
      <td>1</td>
      <td>4.900038</td>
      <td>-75.639052</td>
    </tr>
  </tbody>
</table>
<p>281479 rows × 7 columns</p>
</div>




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

    c:\Users\danie\.conda\envs\py312\Lib\site-packages\openpyxl\workbook\child.py:99: UserWarning: Title is more than 31 characters. Some applications may not be able to read the file
      warnings.warn("Title is more than 31 characters. Some applications may not be able to read the file")
    


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

    c:\Users\danie\.conda\envs\py312\Lib\site-packages\openpyxl\workbook\child.py:99: UserWarning: Title is more than 31 characters. Some applications may not be able to read the file
      warnings.warn("Title is more than 31 characters. Some applications may not be able to read the file")
    


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




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>DEPARTAMENTO</th>
      <th>FECHA HECHO</th>
      <th>MUNICIPIO</th>
      <th>CANTIDAD</th>
      <th>Latitud</th>
      <th>Longitud</th>
    </tr>
  </thead>
  <tbody>
  </tbody>
</table>
</div>


