# naive bayes
library(readr)
library(naivebayes)
library(dplyr)

where <- read_csv("location/locations.csv")

where9am <- where %>% 
  filter(hour == 9) %>% 
  select(daytype, location)

locmodel <- naive_bayes(location~daytype, data = where9am)

thursday9am <- data_frame(daytype = "weekday")
predictions <- predict(locmodel, thursday9am)

# Examine raw probabilities

locmodel

# get prediction
predict(locmodel, data_frame(daytype="weekend"))
# get probabilities
predict(locmodel, data_frame(daytype="weekend"), type = "prob")


# use dplyr to verify it is quite simple
where9am %>% 
  group_by(location) %>% 
  summarize(total = n()/nrow(.))

# laplace correction 
