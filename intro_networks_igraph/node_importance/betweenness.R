# betweenness
library(igraph)
library(readr)

measles <- read_csv('measles.csv')

g <- graph_from_data_frame(measles)

g.b <- betweenness(g, directed = TRUE)

hist(g.b, breaks = 80)

plot(g, vertex.label = NA,
     edge.color = 'black',
     vertex.size = sqrt(g.b) + 2,
     edge.arrow.size = 0.075,
     layout = layout_nicely(g))


# Pintar el 184 de rojo
V(g)$color <- ifelse(V(g)$name=="184", "red", "blue")
plot(g, vertex.label = NA,
     edge.color = 'black',
     vertex.size = sqrt(g.b) + 3,
     edge.arrow.size = 0.075,
     layout = layout_nicely(g))


# ego graph