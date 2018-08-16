# song_lyrics
library(here)
library(tidytext)

load(here::here('song_lyrics', 'data', 'song_lyrics.rda'))


tidy_lyrics <- song_lyrics %>% 
  unnest_tokens(word, lyrics)

totals <- tidy_lyrics %>%
  # Count by song to find the word totals for each song
  count(song) %>%
  # Rename the new column
  rename(total_words = n)



lyric_counts <- tidy_lyrics %>%
  # Combine totals with tidy_lyrics using the "song" column
  left_join(totals, by = "song")

lyric_sentiment <- lyric_counts %>% 
  inner_join(get_sentiments('nrc'))

# What songs have the highest proportion of negative words?
lyric_sentiment %>% 
  count(song, sentiment, total_words) %>% 
  ungroup() %>%  # count groups data?
  filter(sentiment == 'negative') %>%
  mutate(percent = n/total_words) %>% 
  arrange(desc(percent))


# How is negative sentiment changing over time?
lyric_sentiment %>%
  # Filter for only negative words
  filter(sentiment == 'negative') %>%
  # Count by song, year, and the total number of words
  count(song, year, total_words) %>%
  ungroup() %>%
  mutate(percent = n / total_words,
         year = 10 * floor(year / 10)) %>%
  # Use ggplot to set up a plot with year and percent
  ggplot(aes(as.factor(year), percent)) +
  geom_boxplot()

# How is positive sentiment changing over time?
lyric_sentiment %>%
  # Filter for only negative words
  filter(sentiment == 'positive') %>%
  # Count by song, year, and the total number of words
  count(song, year, total_words) %>%
  ungroup() %>%
  mutate(percent = n / total_words,
         year = 10 * floor(year / 10)) %>%
  # Use ggplot to set up a plot with year and percent
  ggplot(aes(as.factor(year), percent)) +
  geom_boxplot()
