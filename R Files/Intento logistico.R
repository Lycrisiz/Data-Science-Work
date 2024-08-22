
Datamod = EntornoR22nodf[,c(1,5,9,17)]
#Datamod$DIV = ifelse(Datamod$"Estado Civil"=='DIV',1,0)
Datatest = EntornoR22nodf[,c(1,3,7,10,17)]
#Edad, horas dia, estrato, pjefe,, REtirados
modelo <- glm(Retirados ~ ., family = binomial, data = Datatest)
summary(modelo)

#evaluar supuestos del modelo
vif(modelo)#ausencia de multicolinealidad
durbinWatsonTest(modelo)#indepenencia de las observaciones
#bptest(modelo) #homosedasticidad no hace falta

# Calcular los residuos y los valores predichos
residuos <- residuals(modelo)
valores_predichos <- predict(modelo)
# Crear el gráfico
plot(valores_predichos, residuos)#grafico de linealidad

#compara si un modelo simple es mejor que el que ya tengo #bajo es mejor
dif_residuos <- modelo$null.deviance - modelo$deviance
# Grados libertad
df <- modelo$df.null - modelo$df.residual
# p-value
p_value <- pchisq(q = dif_residuos,df = df, lower.tail = FALSE)


#1. La variable de respuesta es binaria.
#2. Las observaciones son independientes.
residuos <- residuals(modelo)
# Crear el gráfico
plot(datos$Tiempo, residuos)
#3. No existe una multicolinealidad severa entre las variables predictoras
#4. No hay valores atípicos extremos.
cooks.distance(modelo)
boxplot(Datatest[,1], main= '1')
boxplot(Datatest[,2], main= '2')
boxplot(Datatest[,3], main= '3')
boxplot(Datatest[,4], main= '4')
boxplot(Datatest[,5], main= '5')
#5. Existe una relación lineal entre las variables predictoras y el logit de la variable de respuesta
# si es menor a 5% 
boxTidwell(Retirados ~ ., data = Datatest)
#6. El tamaño de la muestra es suficientemente grande.
