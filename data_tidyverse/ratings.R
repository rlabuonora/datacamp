# For series with 10 episodes, 
# which showed the most growth in viewers from the premiere to the finale? 
# Which showed the least? Use the 7th day ratings!  

library(readr)
library(tidyverse)

ratings <- read_csv("Ratings/02.03_messy_ratings.csv")

ratings %>% 
  filter(episodes == 10) %>% 
  mutate(dif = e10_viewers_7day - e1_viewers_7day) %>% 
  select(series, dif) %>% 
  arrange(-dif)

# recode bbc
ratings %>% 
  distinct(channel)

ratings <- ratings %>% 
  mutate(bbc = recode_factor(channel,
    "Channel 4" = 0,
    .default = 1
  ))

count(ratings, channel, bbc)
