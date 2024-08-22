library(FactoMineR)
Encentw	 = read.table("C:\\Users\\danie\\OneDrive\\Escritorio\\Jupyter Data\\Modelo Predictivo (carita muy feliz)\\Saves\\EncentMFA.txt", header = T, sep = "\t")
head(Encentw)

nambres = c("Promedio Categoría Camaradería","Promedio Categoría Compañía","Promedio Categoría Estrés","Promedio Categoria Home Office","Promedio Categoría Jefe","Promedio Categoría Salud Mental","Promedio Orgullo/Sentido de Pertenencia","situacion")

res <- MFA (Encentw, group=c(13,10,7,13,10,11,7,1), type = c("s","s","s","s","s","s","s","n"), excl = NULL,ind.sup = NULL, ncp = 5, name.group = nambres, num.group.sup = NULL, graph = TRUE, weight.col.mfa = NULL,row.w = NULL, axes = c(1,2), tab.comp=NULL)
