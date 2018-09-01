
pokemon_df <- read_csv("./clusters/Pokemon.csv")
pokemon_matrix <- pokemon_df  %>% 
  select(HitPoints:Speed) %>% 
  as.matrix


# View column means
colMeans(pokemon)

# View column standard deviations
apply(pokemon, 2, sd)

# Scale the data
pokemon.scaled <- scale(pokemon)

# Create hierarchical clustering model: hclust.pokemon
hclust.pokemon <- hclust(dist(pokemon.scaled), method = "complete")

# Explore different methods

# Whether you want balanced or unbalanced trees for your 
# hierarchical clustering model depends on the context 
# of the problem you're trying to solve. 
# balanced trees are essential if you want an even number of 
# observations assigned to each cluster. 
# On the other hand, if you want to detect outliers, 
# for example, an unbalanced tree is more desirable 
# because pruning an unbalanced tree can result in most 
# observations assigned to one cluster and only a few 
# observations assigned to other clusters.
