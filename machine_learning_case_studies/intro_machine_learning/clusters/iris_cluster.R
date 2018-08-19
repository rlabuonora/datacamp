# kmeans clustering of iris data

my_iris <- iris[-5]
species <- iris[[5]]
kmeans_iris <- kmeans(my_iris, 3)

# tabla para comparar con species
table(species, kmeans_iris$cluster)

my_iris$cluster <- factor(kmeans_iris$cluster)

library(ggplot2)
ggplot(my_iris, aes(Petal.Length, Petal.Width, color = cluster)) +
  geom_point()
