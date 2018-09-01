
df <- read_csv('case_study/WisconsinCancer.csv') 

## Hierarchical clustering
wisc.data <- df %>% 
  select(radius_mean:fractal_dimension_worst) %>% 
  as.matrix
# Scale the wisc.data data: data.scaled
data.scaled <- scale(wisc.data)

# Calculate the (Euclidean) distances: data.dist
data.dist <- dist(data.scaled)

# Create a hierarchical clustering model: wisc.hclust
wisc.hclust <- hclust(data.dist, method = "complete")

# Using the plot() function, what is the height at 
# which the clustering model has 4 clusters?

plot(wisc.hclust)


# K-means cluster

wisc.data.scaled <- scale(wisc.data)
wisc.km <- kmeans(wisc.data.scaled, 2, nstart = 20)
