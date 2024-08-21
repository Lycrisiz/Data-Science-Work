Este Repositorio contiene un poco de lo que ha sido mi trabajo, en el area de ciencia de datos, y los codigos que he programado, en python y en R, asi mismo mas abajo, se puede pareciar uno de mis proyectos mas recientes, en el cual obtuve datos de la policia nacional(datos abiertos) de los cuales realicé su respectiva limpieza y transformacion para subirlos posteriormente a Power Bi, con sus respectivas relaciones y su debido dashboard.

![](https://github.com/Lycrisiz/Data-Science-Work/blob/main/Datos/Captura%20de%20pantalla%202024-08-12%20111440.png?raw=true)

Este Primer Dashboard, permite visualizar, el historico de como han aumentado los reportes de hurto a travez del tiempo en Colombia, junto con las ciudades que mas han registrado hurtos en el ultimo año para esto todo dividir los datos en dos diferentes, que estuviesen correlacionados, primeramente los datos vienen como registros individuales por dia, por lo que en un dia se pueden obtener mas de un registro de hurto, eso afecta las graficas por que en vez de realizar un conglomerado de hurtos por dia, suma el numero de registros, lo cual genera imprecicion, para ello se realizo un group by en python y de conservaron los datos separados y agrupados, de forma que se pudiese contar con ambos datos, sacandole el maximo provecho a la informacio.

Las preguntas que deja son: ¿por que la pendiente de los hurtos ha crecido desde 2016, que factores en la seguridad o el sistema de gobierno afectaron negativamente beneficiando lo hurtos?
Se puede apreciar como pese a voler a su tendencia habitual luego de la pandemia, las medidas, de seguridad ha sido efectivas, pues en comparacion con 2023 2024 presenta un mejor desempeño.

![](https://github.com/Lycrisiz/Data-Science-Work/blob/main/Datos/Captura%20de%20pantalla%202024-08-12%20111542.png?raw=true)

Esta Segunda Hoja refleja, la cantidad de hurtos por lugar, para esto, se realizo un cruce con una base de datos que manejase latitud y longitud, puesto que Power Bi no distigue de algunos municipios con nombres iconicos (madrid) y las ciudades en las que se basan esos nombres.

![](https://github.com/Lycrisiz/Data-Science-Work/blob/main/Datos/Captura%20de%20pantalla%202024-08-12%20111807.png?raw=true)

Esta Tercera hoja refleja la contra parte de los hurtos (azul) mostrando las capturas por dia que realiza la policia nacional, lastimosamente esta data esta limitada, 2010 - 2015 sin embago muestra una tendencia, la cual va en contra con lo apreciado anteiormente en la hoja de hurtos, pues, si bien las capaturas parecen ser pocas a principio de año, los hurtos no presentan esta tendencia, es decir, hay menor efectividad de la policia en esa epoca del año.

Por otra parte Se puede apreciar (verde) el informe de incautacion de armas, el cual, muestra, que en los ultimos años se han venido incautando menos armas, hasta 2023 en donde se puede evidenciar el salto grande, lo cual es un buen golpe en mejorar la seguridad por el cual quizás podria atribuirsele, la disminucion de hurtos en 2024 en comparacion con 2023.

![](https://github.com/Lycrisiz/Data-Science-Work/blob/main/Datos/Captura%20de%20pantalla%202024-08-12%20111629.png?raw=true)

Por ultimo y no menos importante se puede aprecial el mapa de capturas, el cual podria contrastasrse con el mapa de hurtos para comparar lado a lado en que departamentos y/o municipios de colombia se ha venido teniendo, menos efectividad, del cual se podrian realizar sanciones respectivas, o cambios en su directriz.
