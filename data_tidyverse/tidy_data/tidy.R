# Los episodios se emiten dos veces en el mes, el dia 7
# y el dia 28.
messy_ratings <- read_csv("data/Ratings/messy_ratings.csv",
                          col_types = cols(
                            series  = col_factor(levels = NULL)
                          ))

messy_ratings_2 <- read_csv("data/Ratings/messy_ratings2.csv",
                          col_types = cols(
                            series  = col_factor(levels = NULL)
                          ))
# plot messy ratings
library(ggplot2)
# episode 1
ggplot(messy_ratings, aes(series, e1)) + geom_col()
# episode 2
ggplot(messy_ratings, aes(series, e2)) + geom_col()
# ...

# tidy: episode is a variable
library(tidyverse)
# gather: multiple cols into 2
# cuando tengo datos en los nombres de las variables


messy_ratings %>% 
  gather(key = "episode", value = "val", -series)

# or
messy_ratings %>% 
  gather(key = "episode", value = "val", e1:e10)

# Gather all columns but series. Name the key episode and the
# value viewers_7day. For plotting, store the key values as a factor variable to preserve the original ordering of the episodes, and remove rows that are NA. 

tidy_ratings <- messy_ratings %>% 
  gather(key = "episode", value = "viewers_7day", 
         -series, factor_key = TRUE,
         na.rm = TRUE) %>% 
  arrange(series, episode) %>% 
  mutate(episode_count = row_number())

ggplot(tidy_ratings, aes(episode_count, viewers_7day, fill = series)) + 
  geom_col()

# separate
ratings2 <- messy_ratings_2 %>% 
  gather(episode, viewers, 
         -series, na.rm = TRUE) %>% 
  separate(episode, into = "episode", extra = "drop") %>% 
  mutate(episode = readr::parse_number(episode)) %>% 
  arrange(series)

ggplot(ratings2, aes(episode, viewers, 
                     color = series,
                     group = series)) +
  geom_line() +
  facet_wrap(~series) + 
  theme_minimal()

# spread
# cuando tengo nombres de variables en los datos
# arguments: convert

# Create a tidy dataset with four variables: 
# series (integer: 1-8), episode (integer: 1-10), 
# When gathering columns, remove all rows with missing values.

messy_ratings_2 %>% 
  gather(key = "episode", 
         value = "viewers", 
         -series, na.rm = TRUE) %>% 
  se

# Get the total number of viewers
tidy_ratings <- messy_ratings_2 %>% 
  gather(key ="episode", 
         value = "viewers",
         na.rm = TRUE,
         -series) %>% 
  separate(episode, into = c("episode", "days")) %>% 
  mutate(episode = parse_number(episode),
         days = parse_number(days))


tidy_ratings %>% 
  count(series, days, wt = viewers) %>% 
  spread(days, n, sep = "_")

# tidy the ratings data to create a scatterplot 
# to see the relationship between the number of premiere 
# and finale UK viewers (7-day only) by series.

ratings <- messy_ratings %>% 
  gather(key = "episode", val = "viewers", -series, na.rm = TRUE) %>% 
  mutate(episode = parse_number(episode)) %>% 
  group_by(series) %>%  # es necesario para que max(episode) de ok
  filter(episode == 1 | episode == max(episode))

# Testeamos a ver si el spoiler tuvo efecto
first_last <- ratings %>% 
  mutate(episode = recode(episode,
    `1` = "first",
    .default = "last"
  ))

# line plot
ggplot(first_last, aes(x=episode, y=viewers, color = series)) +
  geom_line(aes(group=series)) + 
  theme_minimal()

# dumbell
ggplot(first_last, aes(x=viewers, y=series, color = series)) + 
  geom_line(aes(group = series)) + 
  geom_point() + 
  theme_minimal()

# Ahora en terminos porcentuales
bump_by_series <- first_last %>% 
  spread(episode, viewers) %>% 
  mutate(bump = (last - first) / first)

ggplot(bump_by_series, aes(series, bump, fill = series)) + 
  geom_col() + 
  scale_y_continuous(labels = scales::percent) + 
  theme_minimal() + 
  guides(fill = FALSE)
