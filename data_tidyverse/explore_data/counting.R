library(readr)
library(tidyverse)

bakeoff <- read_csv("explore_data/bakeoff.csv")

# tibble
bakeoff


# Notas:
# explore arguments to read_csv: skip, col_names, na
# Combinar funciones del tidyverse df -> df con funciones base x -> x

# Analisis exploratorio
glimpse(bakeoff)
library(skimr)

skim(bakeoff)

# skim agrupado
bakeoff %>% 
  group_by(us_season) %>% 
  skim

# summary de skim
bakeoff %>% 
  skim %>% 
  summary

# counting
bakers <- read_csv("explore_data/Bakers/baker_results.csv")

# distinct series
# dplyr::distinct
bakers %>%
  distinct(series)

# bakers per series
bakers %>% 
  count(series)

bakers %>% 
  count(aired_us, series)

# ungroup !!

# Cycle: distinct, count

# count with a logical 

# roll up a level

bakeoff %>% 
  count(series)

# Contando filas:
# cocineros por episodio
bakeoff %>%  # cada fila es un cocinero
  count(series, episode) # para cada temporada y episodio, cuantos cocineros

# episodios por temporada
bakeoff %>% 
  count(series, episode) %>% # ahora cada fila es un episodio 
  count(series) # para cada serie cuantos episodios

# plot counts
ggplot(bakeoff, aes(episode)) + 
  geom_bar() + 
  facet_wrap(~series)

# La cantidad de cocineros nunca sube, siempre llegan 3 a la final