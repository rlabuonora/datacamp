# k-means with pokemon
library(readr)
library(tidyverse)
library(skimr)

pokemon_df <- read_csv("./clusters/Pokemon.csv")
pokemon_matrix <- pokemon_df  %>% 
  select(HitPoints:Speed) %>% 
  as.matrix

pokemon_df_scaled <- pokemon_df %>% 
  mutate_if(is.numeric, function(x) c(scale(x))) 

pokemon_df_scaled %>% 
  skim

str(pokemon)


wss <- 0

# Look over 1 to 15 possible clusters
for (i in 1:15) {
  km.out <- kmeans(pokemon, nstart = 20, centers = i, iter.max = 50)
  wss[i] <- km.out$tot.withinss
}

# Elbow is at 2
k <- 2

# scree plot
plot(1:15, wss, type = "b")

# cluster with 2 means
km.out <- kmeans(pokemon, centers = k, nstart = 20, iter.max = 50)

plot(pokemon[,c("Defense", "Speed")], col = km.out$cluster)
