library(igraph)

library(tidyverse)

df <- tribble(~from, ~to,
              "A",    "B",
              "B",    "C",
              "B",    "D",
              "B",    "E",
              "C",   "D",
              "D",   "E")


g <- graph_from_data_frame(df, directed = FALSE)

plot(g,
     vertex.label.color = "black",
     vertex.label.cex = 0.9)

mean_distance(g)

# A mano:
distances(g)[upper.tri(distances(g))] %>% mean
