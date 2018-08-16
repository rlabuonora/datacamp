# Visualing networks with igraph

# Load data
friends1_edges <- read_csv("friends1_edges.csv")
friends1_nodes <- read_csv("friends1_nodes.csv")
g1 <- graph_from_data_frame(friends1_edges, directed = FALSE, vertices = friends1_nodes )

# Try different layout options

# Circle
plot(g1, vertex.label.color = "black", layout = layout_in_circle(g1))
# Fruchterman-Reingold
plot(g1, vertex.label.color = "black", layout = layout_with_fr(g1))
plot(g1, vertex.label.color = "black", layout = layout_as_tree(g1))

# Create a vector w1 of
# edge weights based on the number of hours friends spend together.
w1 <- friends1_edges$hours

# o
w1 <- E(g1)$hours
m1 <- layout_nicely(g1)

plot(g1, 
     vertex.label.color = "black",
     edge.color = "black",
     edge.width = w1,
     layout = m1
     )

g2 <- delete_edges(g1, E(g1)[hours < 2])
