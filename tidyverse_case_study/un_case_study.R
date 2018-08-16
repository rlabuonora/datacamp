library(tidyr)
library(purrr)
library(countrycode)
library(dplyr)
library(ggplot2)
library(broom)
votes <- readRDS("votes.rds")

votes_processed <- votes %>% 
  filter(vote <= 3) %>% 
  mutate(year = session + 1945,
         country = countrycode(ccode, "cown", "country.name")) %>% 
  filter(year %% 2 == 1) # Solo los anios pares(?)
  
  
by_year_country <-  votes_processed %>% 
  group_by(country, year) %>% 
  summarize(percent_yes = mean(vote == 1),
         total = n()) %>% 
  ungroup() %>% 
  select(country, year, percent_yes) %>% 
  arrange(year, country)



# Visualize one-country

uy <- "Uruguay"

by_year_country %>% 
  filter(country == uy) %>% 
  ggplot(aes(year, percent_yes)) +
  geom_point() + 
  geom_smooth()

# Visualize multiple countries

countries <- c("Uruguay", "United Kingdom", "Brazil")

by_year_country %>% 
  filter(country %in% countries) %>% 
  ggplot(aes(year, percent_yes, color = country)) + 
  geom_line()

# mejor con facets
by_year_country %>% 
  filter(country %in% countries) %>% 
  ggplot(aes(year, percent_yes, color = country)) + 
  geom_line() + 
  facet_wrap(~country, ncol =1, scales = "free_y")  # grid?
  
  
# Model one country
data_uy <- by_year_country %>% 
  filter(country == "Uruguay")

modelo_uruguay <- lm(percent_yes~year, data = data_uy)
summary(modelo_uruguay)

# Model multiple countries
# dummy variables, for loops, etc..

# Nest data frame

coefficients_by_country <- by_year_country %>% 
  nest(-country) %>% 
  mutate(mod = map(data, ~ lm(percent_yes~year, data = .)),
         tidied = map(mod, tidy)) %>%
  unnest(tidied)


## Join
descriptions <- readRDS("descriptions.rds")


votes_joined <- votes_processed %>% 
  inner_join(descriptions, by = c("rcid", "session")) 

tidy_votes <- votes_joined %>% 
  gather(key = "topic", value = "dummy", me, nu, di, hr, co, ec) %>% 
  filter(dummy == 1) %>% 
  select(-dummy) %>% 
  group_by(country, year, topic) %>% 
  summarize(percent_yes = mean(vote == 1))

tidy_votes <- tidy_votes %>%
  mutate(topic = recode(topic,
                        "me" = "Palestinian conflict",
                        "nu" = "Nuclear weapons and nuclear material",
                        "di" = "Arms control and disarmament",
                        "hr" = "Human rights",
                        "co" = "Colonialism",
                        "ec" = "Economic development"))

tidy_votes %>%
  filter(country %in% c("Uruguay", "United States")) %>% 
  ggplot(aes(year, percent_yes, color = country)) +
  geom_line() +
  facet_wrap(~topic)
  