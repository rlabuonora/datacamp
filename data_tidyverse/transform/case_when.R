# 
library(tidyverse)
bakers <- read_csv("data/Bakers/baker_results.csv")

# if_else
# between 
between(c(1, 2, 3, 4), 1, 3)
# good for using with case_when

bakers_skill <- bakers %>% 
  mutate(skill = case_when(
    star_baker > technical_winner ~ "super_star",
    star_baker < technical_winner ~ "high_tech",
    star_baker == 0 & technical_winner == 0 ~ NA_character_,
    TRUE ~ "well_rounded"
  )) %>% 
  drop_na(skill)

bakers_skill %>% count(skill)
