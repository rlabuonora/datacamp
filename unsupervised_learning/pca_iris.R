iris.pca <- PCA(iris[,-5], graph = FALSE)

p_1 <- fviz_pca_ind(iris.pca,
             geom.ind = "point", # show points only (nbut not "text")
             col.ind = iris$Species, # color by groups
             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
             addEllipses = TRUE, # Concentration ellipses
             ellipse.type = "convex",
             legend.title = "Groups"
)
iris.pca
# Concluyo que:
# En las virginica, el PC1 es alto. 
# PC1 alto implica que petal width, sepal length, petal.length altos.

# Setosa tiene el PC1 bajo (bajo petal.width, bajo sepal.length, 
#                           bajo petal.length)
# Setosa tiene alto petal width, alto sepal length y alto petal.length.
# Sepal Width es alto en PC2.
p_2 <- fviz_pca_var(iris.pca, col.var = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             repel = TRUE # Avoid text overlapping
)

plot_grid(p_1, p_2, ncol = 2)

ggplot(iris, aes(Species, Petal.Width, fill = Species)) + geom_point()
