# select
library(readr)

ratings <- read_csv("data/Ratings/02.03_messy_ratings.csv")

# use everything() to reorder variables
ratings %>% 
  select(channel, everything())

# remove variables 28day and 7day
ratings %>% 
  select(-ends_with("day"))

# comibne
ratings %>% 
  select(channel, everything(), -ends_with("day"))

ratings %>% 
  select(
    episode1_viewers = e1_viewers_28day,
    episode2_viewers = e2_viewers_28day,
    episode3_viewers = e3_viewers_28day,
    episode4_viewers = e4_viewers_28day
  )

# batch with select

ratings %>% 
  select(
    series,
    viewers_7day_ = ends_with("7day")
  )

# janitor::clean_names("snake")

