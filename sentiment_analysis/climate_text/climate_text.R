library(here)
library(tidyverse)
library(tidytext)

load(here('climate_text', 'data', 'climate_text.rda'))


tidy_tv <- climate_text %>% 
  unnest_tokens(word, text)

tv_sentiment <- tidy_tv %>% 
  inner_join(get_sentiments('nrc'))

tv_sentiment %>% 
  count(word, sentiment) %>% 
    group_by(sentiment) %>% 
    top_n(10) %>% 
    ungroup() %>% 
  mutate(word = reorder(word, n)) %>% 
  ggplot(aes(word, n, fill=sentiment)) + 
  geom_col() +
  coord_flip() +
  facet_wrap(~sentiment, scale = "free")
  

tv_sentiment %>%
  # Filter for only negative words
  filter(sentiment == 'negative') %>%
  # Count by word and station
  count(word, station) %>%
  # Group by station
  group_by(station) %>%
  # Take the top 10 words for each station
  top_n(10) %>%
  ungroup() %>%
  mutate(word = reorder(paste(word, station, sep = "__"), n)) %>%
  # Set up the plot with aes
  ggplot(aes(word, n, fill=station)) +
  geom_col(show.legend = FALSE) +
  scale_x_discrete(labels = function(x) gsub("__.+$", "", x)) +
  facet_wrap(~ station, nrow = 2, scales = "free") +
  coord_flip()


tv_sentiment %>% 
  filter(sentiment == 'negative') %>% 
  count(word, station) %>% 
  group_by(station) %>% 
  top_n(10) %>% 
  ungroup() %>% 
ggplot(aes(word, n, fill = station)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~station, nrow = 2, scales = "free") +
  coord_flip()
