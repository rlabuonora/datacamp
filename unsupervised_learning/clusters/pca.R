
pokemon_df <- read_csv("./clusters/Pokemon.csv")
pokemon_matrix <- pokemon_df  %>% 
  select(HitPoints:Speed) %>% 
  as.matrix

pr.out <- prcomp(pokemon_matrix, scale = TRUE)
summary(pr.out)
biplot(pr.out)
  
# Compare results with scaling and without
pr.with.scaling <- prcomp(pokemon, center = TRUE, scale = TRUE)

# PCA model without scaling: pr.without.scaling
pr.without.scaling <- prcomp(pokemon, center = TRUE, scale = FALSE)


# Create biplots of both for comparison
biplot(pr.with.scaling, main = "with scaling")
biplot(pr.without.scaling, main = "without scaling")

# Using ggplot
# library(devtools)
# install_github("vqv/ggbiplot")
library(ggbiplot)
ggbiplot(pr.with.scaling, scale = 1, var.scale = 1)
