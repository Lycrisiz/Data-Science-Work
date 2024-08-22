#Anaisis Data de Retiros
datap = General

dataEnc = EncentMFA[,-c(31,32,33,34,35,36,37,38,39,40,41,42,43)]
res = PCA(dataEnc, quanti.sup = 59)
res$eig
#parece que si exisen algunas variables que tienen mas relacion que otras

dataEnc2 = dataEnc[,c(12,20,23,24,43,48,54,58,66)]
res = PCA(dataEnc2, quali.sup = 9)
res$eig
names(dataEnc)

#Analisis Iden (valores generales de la planta)

dataide = iden
res.mfa = MFA (dataide, group=c(1,1,1,1,1,1,1), type = c("n","s","n","s","n","s","n"),
           ind.sup = NULL, ncp = 5, name.group = c("A.R","Edad","Genero","Sueldo","Jornada","Antiguedad","Estado Civil"),
           num.group.sup = 1, graph = FALSE, weight.col.mfa = NULL,
           row.w = NULL, axes = c(1,2), tab.comp=NULL)
eig.val <- get_eigenvalue(res.mfa)
head(eig.val)
fviz_screeplot(res.mfa)
group <- get_mfa_var(res.mfa, "group")
group

# Coordinates of groups
head(group$coord)
# Cos2: quality of representation on the factore map
head(group$cos2)
# Contributions to the  dimensions
head(group$contrib)

fviz_mfa_var(res.mfa, "group")

# Contribution to the first dimension
fviz_contrib(res.mfa, "group", axes = 1)
# Contribution to the second dimension
fviz_contrib(res.mfa, "group", axes = 2)

quanti.var <- get_mfa_var(res.mfa, "quanti.var")
quanti.var 

# Coordinates
head(quanti.var$coord)
# Cos2: quality on the factore map
head(quanti.var$cos2)
# Contributions to the dimensions
head(quanti.var$contrib)

fviz_mfa_var(res.mfa, "quanti.var", palette = "jco", 
             col.var.sup = "violet", repel = TRUE)

fviz_mfa_var(res.mfa, "quanti.var", palette = "jco", 
             col.var.sup = "violet", repel = TRUE,
             geom = c("point", "text"), legend = "bottom")

# Contributions to dimension 1
fviz_contrib(res.mfa, choice = "quanti.var", axes = 1, top = 20,
             palette = "jco")

# Contributions to dimension 2
fviz_contrib(res.mfa, choice = "quanti.var", axes = 2, top = 20,
             palette = "jco")

fviz_mfa_var(res.mfa, "quanti.var", col.var = "contrib", 
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             col.var.sup = "violet", repel = TRUE,
             geom = c("point", "text"))


ind <- get_mfa_ind(res.mfa)
ind

fviz_mfa_ind(res.mfa, col.ind = "cos2", 
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE)


fviz_mfa_ind(res.mfa, 
             habillage = "Label", # color by groups 
             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
             addEllipses = TRUE, ellipse.type = "confidence", 
             repel = TRUE # Avoid text overlapping
) 

fviz_ellipses(res.mfa, c("Label", "Soil"), repel = TRUE)

fviz_mfa_axes(res.mfa)