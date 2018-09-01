# The first step before you start modeling is to explore your data. 
# In this course we'll practice using tidyverse functions for exploratory 
# data analysis. Start off this case study by examinig your data set and 
# visualizing the distribution of fuel efficiency. 
# The ggplot2 package, with functions like ggplot() 
# and geom_histogram() are included in the tidyverse.

library(here)
library(tidyverse)
cars2018 <- read_csv(here('cars', 'cars2018.csv'))


# plot historgam

ggplot(cars2018, aes(x=MPG)) + geom_histogram(bins = 25)

# This distribution is not normal, but instead log normal. 
# It will be best for us to take this into account when we build models.

# Simple model
cars_vars <- cars2018 %>% select(-Model, -`Model Index`)
fit <- lm(MPG~., data = cars_vars)
summary(fit)

# Use Caret (by Max Kuhn) to split training and test
library(caret)

# split Aspiration
in_training <- createDataPartition(cars2018$Transmission, p = 0.8, list = FALSE)

training <- cars_vars[in_training,]
testing <- cars_vars[-in_training,]

# train linear regression
fit_lm <- train(log(MPG)~., method = "lm", data = training,
                trControl = trainControl(method="none")) # turn off resampling

# train random forest
fit_rf <- train(log(MPG)~., method = "rf", data = training,
                trControl = trainControl(method = "none"))

# evaluate models using yardstick
library(yardstick)

# on training
results <- training %>% 
  mutate(`Linear Regression` = predict(fit_lm, .),
         `Random Forest` = predict(fit_rf, .))

metrics(results, truth=MPG, estimate = `Linear Regression`)
metrics(results, truth=MPG, estimate = `Random Forest`)

# on testing

results <- testing %>% 
  mutate(`Linear Regression` = predict(fit_lm, testing),
         `Random Forest` = predict(fit_rf, testing))

metrics(results, truth = MPG, estimate=`Linear Regression`)
metrics(results, truth = MPG, estimate=`Random Forest`)

# Resample
fit_lm_bt <- train(log(MPG)~., data = training, method = "lm",
                   trControl = trainControl(method = "boot"))

fit_rf_bt <- train(log(MPG)~., data = training, method = "rf",
                       trControl = trainControl(method = "boot"))
 

results <- testing %>% 
  mutate(`Linear Regression` = predict(fit_lm_bt, .),
         `Random Forest` = predict(fit_rf_bt, .))

metrics(results, truth=MPG, estimate = `Linear Regression`)
metrics(results, truth=MPG, estimate=`Random Forest`)


# plot models
results %>% 
  gather(key=Method, value=Result, `Linear Regression`, `Random Forest`) %>% 
  ggplot(aes(log(MPG), Result, color = Method)) +
  geom_point() +
  facet_wrap(~Method) + 
  geom_smooth(method = "lm") + 
  geom_abline(lty = 2, color = "gray50") +
  theme_minimal()

# Random Forest looks better
  