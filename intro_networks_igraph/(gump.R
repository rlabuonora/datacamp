library(tidyverse)
library(igraph)

gump <- read_csv('forest_gump/gump.csv')
g <- graph_from_data_frame(gump, directed = FALSE)


# calculate eigen-vector centrality
g.ec <- eigen_centrality(g)
which.max(g.ec$vector)

plot(g,
     vertex.label.color = "black",
     vertex.label.cex = 0.6,
     vertex.size = 25 * (g.ec$vector),
     edge.color = 'gray88')


## Find the largest cliques

lc <- largest_cliques(g) # a list of cliques, a clique is 

## Create subgraph of largest cliques
s1 <- induced_subgraph(g, lc[[1]])
s2 <- induced_subgraph(g, lc[[2]])

par(mfrow=c(1,2))
plot(gs1,
     vertex.label.color = " black",
     vertex.label.cex = 0.9,
     vertex.size = 0,
     edge.color =  'gray28',
     main = "Largest Clique 1",
     layout = layout.circle(gs1))

plot(gs2,
     vertex.label.color = " black",
     vertex.label.cex = 0.9,
     vertex.size = 0,
     edge.color =  'gray28',
     main = "Largest Clique 1",
     layout = layout.circle(gs2))
