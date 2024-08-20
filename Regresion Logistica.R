library("FactoMineR")
library("factoextra")
library("ggplot2")
library("caTools")
library("car")
library("lmtest")

dataset = DataF[-1]
dataset$Genero = ifelse(dataset$Genero=='MAS',1,0)

dataset$`UNIÓN Libre` = ifelse(dataset$`Estado Civil`=='UNIÓN Libre',1,0)
dataset$SOLTERO = ifelse(dataset$`Estado Civil`=='SOLTERO/A',1,0)
dataset$CASADO = ifelse(dataset$`Estado Civil`=='CASADO/A',1,0)
dataset$DIVORCIADO = ifelse(dataset$`Estado Civil`=='DIVORCIADO/A',1,0)
dataset$SEPARADO = ifelse(dataset$`Estado Civil`=='SEPARADO/A',1,0)

dataset$ETDCS = ifelse(dataset$`Etiqueta Desempeño`=='Cumple Satisfactorio',1,0)
dataset$ETDSB = ifelse(dataset$`Etiqueta Desempeño`=='Sobresaliente',1,0)
dataset$ETDCP = ifelse(dataset$`Etiqueta Desempeño`=='Cumple Parcial',1,0)
#dataset$ETDbE = ifelse(dataset$`Etiqueda Desempeño`=='Bajo lo esperado',1,0)

dataset$MTZOB = ifelse(dataset$`Matriz`=='En Observación',1,0)
dataset$MTZSOL = ifelse(dataset$`Matriz`=='Sólido',1,0)
dataset$MTZEX = ifelse(dataset$`Matriz`=='Experto',1,0)
dataset$MTZBLE = ifelse(dataset$`Matriz`=='Bajo lo Esperado',1,0)
dataset$MTZPR = ifelse(dataset$`Matriz`=='Promesa',1,0)
dataset$MTZVL = ifelse(dataset$`Matriz`=='Valor',1,0)
dataset$MTZED = ifelse(dataset$`Matriz`=='En Desarrollo',1,0)

dataset$TLNHP = ifelse(dataset$`Talent`=='High performer',1,0)
dataset$TLNHP
dataset$TLNBD = ifelse(dataset$`Talent`=='Bajo desempeño',1,0)
dataset$TLNTT = ifelse(dataset$`Talent`=='Top talent',1,0)
#dataset$TLND = ifelse(dataset$`Talent`=='Desarrollo',1,0)

dataset = dataset[,-c(6,9,10,11)]
dataset = dataset[,-c(2,7,11,12,13,15,16,17,18,19,20,21,22,23,27,34,35,33,32,30,24,8,31,5,3)]
#update: no quitaremos el intercepto, en vez de eso quitaremos otra variable ,33,32,30,24,8
#el modelo no tiene relevancia
#update, sin intercepto me pide quitar solo numero de hijos,8
#update hubieron problemas, de correlación entre las variables por eso intentare filtrar aun mas el modelo
#31,3 

#[1] "ret"                 "Genero"              "Edad"                "Sueldo"             
#[5] "Horas Dia"           "Antiguedad"          "General - Desempeño" "Número de hijos"    
#[9] "Estrato"             "Viven"               "dependen"            "PJefe"              
#[13] "PCompania"           "Pcamara"             "POrgullo"            "PSaludM"            
#[17] "PEstres"             "UNIÓN Libre"         "SOLTERO"             "CASADO"             
#[21] "DIVORCIADO"          "SEPARADO"            "ETDCS"               "ETDSB"              
#[25] "ETDCP"               "MTZOB"               "MTZSOL"              "MTZEX"              
#[29] "MTZBLE"              "MTZPR"               "MTZVL"               "MTZED"              
#[33] "TLNHP"               "TLNBD"               "TLNTT"  





#factores -> grupos

dataset$ret = factor(dataset$ret , levels = c(0,1))

#dataset = dataset[,c(1,3,4,5,8,14)]#,21)]#21 Pestres #se deben estandarizar las variables (definir cuales usar?)
#dataset
#dataset[,2:length(dataset)] = scale(dataset[,2:length(dataset)])

#installar caTools
split=sample.split(dataset$ret, SplitRatio = 0.75) #porcentaje de division
training_set = subset(dataset,split==TRUE)
test_set = subset(dataset, split==FALSE)#toca dejar la base de datos solamente con lo que quiero
##
#####modelo
training_set[,2:length(training_set)] = scale(training_set[,2:length(training_set)])#escalar las variables compras no por que la daño
test_set[,2:length(training_set)] = scale(test_set[,2:length(training_set)])

##########################################################################################################
##########################################################################################################

Clasif = glm(formula = ret~.-1,family = binomial, data =dataset) #binomial (algo que descida entre falso y verdadero) si los errores son normal se habla de un provit, pero el analisis es el mismo
summary(Clasif)#el analisis de significancia es el mismo

##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
#si el x aumenta un poco el logaritmo de las proporciones aumenta igual
prob_pred=predict(Clasif,type = "response",newdata = test_set[-1])
#prob_pred=predict(Clasif,type = "response",newdata = test_set[,1:2])
prob_pred # si la probabilidad me supera el 50% clasifiquemoslo como que si renuncua de lo contrario no renuncia
y_pred = ifelse(prob_pred>0.5,1,0)# si el ajuste no es el 50% se podria decir que hay un error en el modelo y que tiene una tendencia a activizar(eo existe) a los trabajadores
y_pred
#matriz de confusión
cm = table(test_set$ret,y_pred)
cm
sum(diag(cm))/sum(cm)*100

##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
#Comprobar modelo # tests homo sedasticidad, multicolinealidad etc etc
bptest(Clasif) #homosedasticisad
shapiro.test(Clasif$residuals) #normalidad
Box.test(Clasif$residuals, type = "Ljung-Box") 
vif(Clasif)


##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
dataset = DataF[-1]
dataset$Genero = ifelse(dataset$Genero=='MAS',1,0)

dataset$`UNIÓN Libre` = ifelse(dataset$`Estado Civil`=='UNIÓN Libre',1,0)
dataset$SOLTERO = ifelse(dataset$`Estado Civil`=='SOLTERO/A',1,0)
dataset$CASADO = ifelse(dataset$`Estado Civil`=='CASADO/A',1,0)
dataset$DIVORCIADO = ifelse(dataset$`Estado Civil`=='DIVORCIADO/A',1,0)
dataset$SEPARADO = ifelse(dataset$`Estado Civil`=='SEPARADO/A',1,0)

dataset$ETDCS = ifelse(dataset$`Etiqueta Desempeño`=='Cumple Satisfactorio',1,0)
dataset$ETDSB = ifelse(dataset$`Etiqueta Desempeño`=='Sobresaliente',1,0)
dataset$ETDCP = ifelse(dataset$`Etiqueta Desempeño`=='Cumple Parcial',1,0)
#dataset$ETDbE = ifelse(dataset$`Etiqueda Desempeño`=='Bajo lo esperado',1,0)

dataset$MTZOB = ifelse(dataset$`Matriz`=='En Observación',1,0)
dataset$MTZSOL = ifelse(dataset$`Matriz`=='Sólido',1,0)
dataset$MTZEX = ifelse(dataset$`Matriz`=='Experto',1,0)
dataset$MTZBLE = ifelse(dataset$`Matriz`=='Bajo lo Esperado',1,0)
dataset$MTZPR = ifelse(dataset$`Matriz`=='Promesa',1,0)
dataset$MTZVL = ifelse(dataset$`Matriz`=='Valor',1,0)
dataset$MTZED = ifelse(dataset$`Matriz`=='En Desarrollo',1,0)

dataset$TLNHP = ifelse(dataset$`Talent`=='High performer',1,0)
dataset$TLNHP
dataset$TLNBD = ifelse(dataset$`Talent`=='Bajo desempeño',1,0)
dataset$TLNTT = ifelse(dataset$`Talent`=='Top talent',1,0)
#dataset$TLND = ifelse(dataset$`Talent`=='Desarrollo',1,0)

dataset = dataset[,-c(6,9,10,11)]
dataset = dataset[,-c(2,7,11,12,13,15,16,17,18,19,20,21,22,23,27,34,35,33,32,30,24,8)]
split=sample.split(dataset$ret, SplitRatio = 0.99999999) #porcentaje de division
test2_set = subset(dataset,split==TRUE)
test4_set = subset(dataset,split==FALSE)
test2_set[,2:length(test2_set)] = scale(test2_set[,2:length(test2_set)])
test4_set[,2:length(test4_set)] = scale(test4_set[,2:length(test4_set)])

probabilidades <- predict(Clasif,type = 'response', newdata = test2_set[-1])#esto es para mirar el codigo con nueva data
Desciciones = ifelse(probabilidades>0.5,1,0)

datasetR = datasetR[,c(1,2,4,5,6,9,15,22)]
# Agrega las probabilidades a tu dataframe
datasetR$probabilidades <- probabilidades
datasetR$Desciciones <- Desciciones

library(writexl)
write_xlsx(datasetR, "C:\\Users\\danie\\OneDrive\\Escritorio\\Jupyter Data\\Modelo Predictivo (carita muy feliz)\\Saves\\Prob.xlsx")

##########################################################################################################
##########################################################################################################
##########################################################################################################

dataset = DataRetOct[-1]
dataset$Genero = ifelse(dataset$Genero=='MAS',1,0)

dataset$`UNIÓN Libre` = ifelse(dataset$`Estado Civil`=='UNIÓN Libre',1,0)
dataset$SOLTERO = ifelse(dataset$`Estado Civil`=='SOLTERO/A',1,0)
dataset$CASADO = ifelse(dataset$`Estado Civil`=='CASADO/A',1,0)
dataset$DIVORCIADO = ifelse(dataset$`Estado Civil`=='DIVORCIADO/A',1,0)
dataset$SEPARADO = ifelse(dataset$`Estado Civil`=='SEPARADO/A',1,0)

dataset$ETDCS = ifelse(dataset$`Etiqueta Desempeño`=='Cumple Satisfactorio',1,0)
dataset$ETDSB = ifelse(dataset$`Etiqueta Desempeño`=='Sobresaliente',1,0)
dataset$ETDCP = ifelse(dataset$`Etiqueta Desempeño`=='Cumple Parcial',1,0)
#dataset$ETDbE = ifelse(dataset$`Etiqueda Desempeño`=='Bajo lo esperado',1,0)

dataset$MTZOB = ifelse(dataset$`Matriz`=='En Observación',1,0)
dataset$MTZSOL = ifelse(dataset$`Matriz`=='Sólido',1,0)
dataset$MTZEX = ifelse(dataset$`Matriz`=='Experto',1,0)
dataset$MTZBLE = ifelse(dataset$`Matriz`=='Bajo lo Esperado',1,0)
dataset$MTZPR = ifelse(dataset$`Matriz`=='Promesa',1,0)
dataset$MTZVL = ifelse(dataset$`Matriz`=='Valor',1,0)
dataset$MTZED = ifelse(dataset$`Matriz`=='En Desarrollo',1,0)

dataset$TLNHP = ifelse(dataset$`Talent`=='High performer',1,0)
dataset$TLNBD = ifelse(dataset$`Talent`=='Bajo desempeño',1,0)
dataset$TLNTT = ifelse(dataset$`Talent`=='Top talent',1,0)
#dataset$TLND = ifelse(dataset$`Talent`=='Desarrollo',1,0)

dataset = dataset[,-c(6,9,10,11)]
dataset = dataset[,-c(2,7,11,12,13,15,16,17,18,19,20,21,22,23,27,34,35,33,32,30,24,8)] #se deben estandarizar las variables (definir cuales usar?)
split=sample.split(dataset$ret, SplitRatio = 0.99999999) #porcentaje de division
test2_set_Oct = subset(dataset,split==TRUE)
test4_set_Oct = subset(dataset,split==FALSE)
test2_set_Oct[,2:length(test2_set_Oct)] = scale(test2_set_Oct[,2:length(test2_set_Oct)])
test4_set_Oct[,2:length(test4_set_Oct)] = scale(test4_set_Oct[,2:length(test4_set_Oct)])

prob_pred=predict(Clasif,type = "response",newdata = test2_set_Oct[-1])
#prob_pred=predict(Clasif,type = "response",newdata = test_set[,1:2])
prob_pred # si la probabilidad me supera el 50% clasifiquemoslo como que si renuncua de lo contrario no renuncia
y_pred = ifelse(prob_pred>0.5,1,0)# si el ajuste no es el 50% se podria decir que hay un error en el modelo y que tiene una tendencia a activizar(eo existe) a los trabajadores
y_pred
#matriz de confusión
cm = table(test2_set_Oct$ret,y_pred)
cm
sum(cm[2])/sum(cm)*100

datasetR = test2_set_Oct
# Agrega las probabilidades a tu dataframe
datasetR$probabilidades <- prob_pred
datasetR$Desciciones <- y_pred

library(writexl)
write_xlsx(datasetR, "C:\\Users\\danie\\OneDrive\\Escritorio\\Jupyter Data\\Modelo Predictivo (carita muy feliz)\\Saves\\Prob.xlsx")

##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################





