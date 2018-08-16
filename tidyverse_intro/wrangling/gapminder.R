library(gapminder)
library(dplyr)
library(ggplot2)

gapminder
nrow(gapminder)


# Filter
gapminder %>% 
  filter(year == 2007)
# Filter 1957
gapminder %>% 
  filter(year == 1957)

# Etc...


by_year <- gapminder %>%
  group_by(year) %>%
  summarize(medianLifeExp = median(lifeExp),
            maxGdpPercap = max(gdpPercap))

# Use the by_year dataset to create a scatter plot showing 
# the change of median life expectancy over time, 
# with year on the x-axis and medianLifeExp on the y-axis. 
ggplot(by_year, aes(year, medianLifeExp)) + 
  geom_point() + 
  expand_limits(y = 0)

# Be sure to add expand_limits(y = 0) to make sure the 
# plot's y-axis includes zero.

# Summarize medianGdpPercap within each continent within 
# each year: by_year_continent

# Summarize the gapminder dataset by continent and year, 
# finding the median GDP per capita (medianGdpPercap) 
# within each and putting it into a column called medianGdpPercap. 
by_year_continent <- gapminder %>%
  group_by(continent, year) %>% 
  summarize(medianGdpPercap = median(gdpPercap))

# Use the assignment operator <- to save this summarized data 
# as by_year_continent.
# Create a scatter plot showing the change in 
# medianGdpPercap by continent over time. 
ggplot(by_year_continent, aes(year, medianGdpPercap, color = continent)) +
  geom_point() + 
  geom_line() + 
  expand_limits(y = 0)

# Use color to distinguish between continents, 
# and be sure to add expand_limits(y = 0) so that 
# the y-axis starts at zero.

# Comparing median life expectancy and median GDP per continent in 2007

# Filter the gapminder dataset for the year 2007, 
# then summarize the median GDP per capita and the median life 
# expectancy within each continent, into columns called 
# medianLifeExp and medianGdpPercap. 
# Save this as by_continent_2007.
by_continent_2007 <- gapminder %>% 
  filter(year == 2007) %>% 
  group_by(continent) %>% 
  summarize(medianGdpPercap = median(gdpPercap),
            medianLifeExp = median(lifeExp))

# Use the by_continent_2007 data to create a scatterplot 
# comparing these summary statistics for continents in 2007, 
# putting the median GDP per capita on the x-axis to the median 
# life expectancy on the y-axis. Color the scatter plot by continent. 
# You don't need to add expand_limits(y = 0) for this plot.

ggplot(by_continent_2007, aes(medianGdpPercap, medianLifeExp, color = continent)) +
  geom_point()

# Use group_by() and summarize() to find the median GDP 
# per capita within each year, calling the output column medianGdpPercap. 
# Use the assignment operator <- to save it to a dataset called by_year.
by_year <- gapminder %>% 
  group_by(year) %>% 
  summarize(medianGdpPercap = median(gdpPercap))

# Use the by_year dataset to create a line plot showing the change 
# in median GDP per capita over time. Be sure to use 
# expand_limits(y = 0) to include 0 on the y-axis.
ggplot(by_year, aes(year, medianGdpPercap)) + 
  geom_line() + 
  expand_limits(y = 0)

# Use group_by() and summarize() to find the median GDP 
# per capita within each year and continent, 
# calling the output column medianGdpPercap. 
# Use the assignment operator <- to save it to a dataset 
# called by_year_continent.

by_year_continent <- gapminder %>% 
  group_by(year, continent) %>% 
  summarize(medianGdpPercap = median(gdpPercap))

# Use the by_year_continent dataset to create a line plot showing 
# the change in median GDP per capita over time, 
# with color representing continent. Be sure to use expand_limits(y = 0) 
# to include 0 on the y-axis.

ggplot(by_year_continent, aes(year, medianGdpPercap, color = continent)) +
  geom_line() +
  expand_limits(y=0)

# Use group_by() and summarize() to find the median GDP 
# per capita within each continent in the year 1952, 
# calling the output column medianGdpPercap.
by_continent <- gapminder %>% 
  filter(year == 1952) %>% 
  group_by(continent) %>% 
  summarize(medianGdpPercap = median(gdpPercap))
  
# Use the assignment operator <- to save it to a dataset 
# called by_continent. Use the by_continent dataset to create a bar plot 
# showing the median GDP per capita in each continent.

ggplot(by_continent, aes(continent, medianGdpPercap)) + geom_col()

# Visualizing GDP per capita by country in Oceania

# Filter for observations in the Oceania continent in the year 1952. 
# Save this as oceania_1952.
oceania_1952 <- gapminder %>% 
  filter(continent = "Oceania", year = 1952)
# Use the oceania_1952 dataset to create a bar plot, 
# with country on the x-axis and gdpPercap on the y-axis
