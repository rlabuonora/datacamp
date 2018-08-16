# friends
library(readr)
library(igraph)

friends <- read_csv("friends.csv")
head(friends)
friends.mat <- as.matrix(friends)

g <- graph.edgelist(friends.mat, directed = FALSE)
plot(g)


# Get basic info from the graph
V(g)
E(g)
gsize(g)
gorder(g)

# setting edge and node attributes
genders <- c(
  "M", "F", "F", "M", "M", "M", "F", "M", "M", "F", "M", "F", "M", "F", "M", "M"
)

ages <- c(
  18, 19, 21, 20, 22, 18, 23, 21, 22, 20, 20, 22, 21, 18, 19, 20
)

hours <- c(1,2,2,1,2,5,5,1,1,3,2,1,1,5,1,2,4,1,3,1,1,1,4,1,3,3,4)

ages

g <- set_vertex_attr(g, "gender", value = genders)
g<- set_vertex_attr(g, "age", value = ages)

# querying edge and node attribs
V(g)[[]]

g <- set_edge_attr(g, "hours", value = hours)

E(g)[[]]
# Nodos que incluyen a Britt
E(g)[[inc('Britt')]]

# Nodos de amigos que pasan 4 o mas horas

E(g)[[hours >= 4]]

friends1_edges <- read_csv("friends1_edges.csv")
friends1_nodes <- read_csv("friends1_nodes.csv")

# Create a new igraph object with graph_from_data_frame(). 
# Two dataframes need to be provided 
# - friends1_edges contains all edges in the network with attributes 
# and friends1_nodes contains all vertices in the network with attributes.
g1 <- graph_from_data_frame(friends1_edges, directed = FALSE, vertices = friends1_nodes )


V(g1)$color <- ifelse(V(g1)$gender == "M", "orange", "dodgerblue")
plot(g1)
  