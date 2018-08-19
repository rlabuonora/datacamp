# K means clustering of seeds data

library(readr)
library(ggplot2)
set.seed(1)
seeds <- read_csv("./Intro_machine_learning/clusters/seeds.csv")


km_seeds <- kmeans(seeds, 3)

seeds$cluster <- km_seeds$cluster

ggplot(seeds, 
       aes(compactness, length, col = factor(cluster))) + 
  geom_point()
