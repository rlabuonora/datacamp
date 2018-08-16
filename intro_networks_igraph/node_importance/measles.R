# Measles
library(igraph)
library(readr)
measles <- read_csv('measles.csv')

g <- graph_from_data_frame(measles)
is.directed(g)
is.weighted(g)

# Aca puede haber un error

# Where does each edge originate from?
table(head_of(g, E(g)))

# para mi la pregunta es Where does each edge point to?

# Make a basic plot
plot(g, 
     vertex.label.color = "black", 
     edge.color = 'gray77',
     vertex.size = 0,
     edge.arrow.size = 0.1,
     layout = layout_nicely(g))


g['184', '178']

# Show all edges going to or from vertex 184

incident(g, 
         '184',
         mode = "all")
(E(g)[[inc('184')]])

# TODO: subset graph and visualize to develop intution
# TODO: use simple graph from slides as example to develop intuition
# Identify all neighbors of vertex 12 regardless of direction
neighbors(g, '12', mode = c('all'))

# Identify other vertices that direct edges towards vertex 12
neighbors(g, '12', mode = c('in'))

# Identify any vertices that receive an edge from vertex 42 and direct an edge to vertex 124
n1 <- neighbors(g, '42', mode = c('out'))
n2 <- neighbors(g, '124', mode = c('in'))
intersection(n1, n2)
  