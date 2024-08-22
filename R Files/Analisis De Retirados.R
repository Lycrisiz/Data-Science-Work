library(FactoMineR)
Encent22clean	 = read.table("C:\\Users\\danie\\OneDrive\\Escritorio\\Jupyter Data\\Modelo Predictivo (carita muy feliz)\\Saves\\Encent22clean.txt", header = T)
Encent22 		 = read.table("C:\\Users\\danie\\OneDrive\\Escritorio\\Jupyter Data\\Modelo Predictivo (carita muy feliz)\\Saves\\Encent22.txt")
MaestroS2		 = read.table("C:\\Users\\danie\\OneDrive\\Escritorio\\Jupyter Data\\Modelo Predictivo (carita muy feliz)\\Saves\\MaestroS2.txt")
MaestroY2		 = read.table("C:\\Users\\danie\\OneDrive\\Escritorio\\Jupyter Data\\Modelo Predictivo (carita muy feliz)\\Saves\\MaestroY2.txt")
identd		 = read.table("C:\\Users\\danie\\OneDrive\\Escritorio\\Jupyter Data\\Modelo Predictivo (carita muy feliz)\\Saves\\idenetd.txt")
MaestroS		 = read.table("C:\\Users\\danie\\OneDrive\\Escritorio\\Jupyter Data\\Modelo Predictivo (carita muy feliz)\\Saves\\MaestroS.txt")
MaestroY		 = read.table("C:\\Users\\danie\\OneDrive\\Escritorio\\Jupyter Data\\Modelo Predictivo (carita muy feliz)\\Saves\\MaestroY.txt")
Maestro		 = read.table("C:\\Users\\danie\\OneDrive\\Escritorio\\Jupyter Data\\Modelo Predictivo (carita muy feliz)\\Saves\\Maestro.txt", sep= "\t")
iden			 = read.table("C:\\Users\\danie\\OneDrive\\Escritorio\\Jupyter Data\\Modelo Predictivo (carita muy feliz)\\Saves\\iden.txt", sep= "\t")
EncentRed	 	 = read.table("C:\\Users\\danie\\OneDrive\\Escritorio\\Jupyter Data\\Modelo Predictivo (carita muy feliz)\\Saves\\EncentRed.txt",sep= "\t", header = T)


#Con Encent22clean es posible analizar un ACP
PCA(Encent22clean, scale.unit = TRUE, ncp = 5, ind.sup = NULL,
quanti.sup = NULL, quali.sup = 72, row.w = NULL,
col.w = NULL, graph = TRUE, axes = c(1,2))


#Con Encent22clean es posible analizar un ACP
PCA(EncentRed, scale.unit = TRUE, ncp = 5, ind.sup = NULL,
quanti.sup = NULL, quali.sup = 8, row.w = NULL,
col.w = NULL, graph = TRUE, axes = c(1,2))