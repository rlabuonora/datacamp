library(tidytext)
library(tidyverse)
library(here)

load(here('shakespeare', 'data', 'shakespeare.rda'))

shakespeare %>% 
  group_by(type, title) %>% 
  count


# tokenization
tidy_shakespeare <- shakespeare %>% 
  group_by(title) %>% 
  mutate(linenumber = row_number()) %>% 
  unnest_tokens(word, text)

shakespeare_sentiment <- tidy_shakespeare %>% 
  inner_join(get_sentiments('bing')) %>% 
  count(title, sentiment) %>% 
  spread(sentiment, n) %>% 
  ungroup %>% 
  mutate(ratio = positive/n(),
         title = reorder(title, ratio))

shakespeare_sentiment %>% 
  ggplot(aes(title, ratio)) +
  geom_col() +
  coord_flip()


word_counts <- tidy_shakespeare %>% 
  ungroup %>% 
  inner_join(get_sentiments('bing')) %>% 
  count(word, sentiment)

top_words <- word_counts %>% 
  group_by(sentiment) %>% 
  top_n(10) %>% 
  ungroup() %>% 
  mutate(word = reorder(word, n))

ggplot(top_words, aes(word, n, fill = sentiment)) +
  geom_col() +
  facet_wrap(~sentiment, scales = "free") +
  coord_flip()
  