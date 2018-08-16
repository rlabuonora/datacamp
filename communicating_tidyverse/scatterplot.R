library(tidyverse)


load('ilo_hourly_compensation.rdata')
load('ilo_working_hours.rdata')

european_countries <-  c("Finland", "France", "Italy", "Norway",      
 "Spain", "Sweden", "Switzerland", "United Kingdom",
 "Belgium", "Ireland", "Luxembourg", "Portugal",      
 "Netherlands", "Germany", "Hungary", "Austria",       
 "Czech Rep.")

ilo_data <- ilo_hourly_compensation %>% 
  inner_join(ilo_working_hours, by = c("country", "year")) %>% 
  mutate(year = as.factor(as.numeric(year)),
         country = as.factor(country))

plot_data <- ilo_data %>% 
  filter(year == 2006) %>% 
  filter(country %in% european_countries)

ilo_plot <- ggplot(plot_data, 
                   aes(working_hours, hourly_compensation)) + 
  geom_point() + 
  labs(x="Working hours per week",
       y="Hourly compensation",
       title = "The more people work, the less compensation they seem to receive",
       subtitle = "Working hours and hourly compensation in European countries, 2006",
       caption = "Data source: ILO, 2017")

ilo_plot + 
  theme_minimal()

ilo_plot <- ilo_plot +
  theme_minimal() +
  # Customize the "minimal" theme with another custom "theme" call
  theme(
    #text = element_text(family = "Bookman"),
    title = element_text(color = "gray25"),
    plot.subtitle = element_text(size = 12),
    plot.title = element_text(size = 16),
    plot.caption = element_text(color = "gray30"),
    plot.background = element_rect(fill = "gray95"),
    plot.margin = unit(c(5, 10, 5, 10), "mm")
  )

filter(ilo_data, year %in% c(1996, 2006)) %>% 
  ggplot(aes(working_hours, hourly_compensation)) +
  geom_point() + 
  labs(x="Working hours per week",
       y="Hourly compensation",
       title = "The more people work, the less compensation they seem to receive",
       subtitle = "Working hours and hourly compensation in European countries, 2006",
       caption = "Data source: ILO, 2017") +
  facet_grid(facets = .~year)
