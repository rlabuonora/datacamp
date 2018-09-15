library(tidyverse)
library(readr)

sisters67 <- read_csv('sisters/sisters.csv')
glimpse(sisters67)

# histogram of age
ggplot(sisters67, aes(age)) + geom_histogram(binwidth = 5)

# tidy
tidy_sisters <- sisters67 %>% 
  select(-sister) %>%
  gather(key, value,-age)

glimpse(tidy_sisters)


# visualize agreement with age
tidy_sisters %>% 
  filter(key %in% paste0("v", 153:170)) %>% 
  group_by(key, value) %>% 
  summarize(age = mean(age, na.rm = TRUE)) %>% 
  ggplot(aes(value, age, color = key)) + 
  geom_line() + 
  facet_wrap(~key) +
  geom_point(size = 0.5) +
  theme_minimal()

sisters_select <- select(sisters67, -sister)

simple_lm <- lm(age~., data = sisters_select)
summary(simple_lm)

# Build a ML model
library(caret)

# split train vs. test/validation

in_train <- createDataPartition(sisters_select$age, 
                                p = 0.6, list = FALSE)

training <- sisters_select[in_train, ]
validation_test <- sisters_select[-in_train,]

# split validation/test
in_test <- createDataPartition(validation_test$age, p=0.5, list = FALSE )
testing <- validation_test[in_test,]
validation <- validation_test[-in_test,]

sisters_cart <- train(age~., data = training, method = "rpart")

# gradient boosting
# not run
sisters_gbm <- train(age~., data = training, method = "gbm")
sisters_rf <- train(age~., data = training, method = "xgbLinear") 

# check model results

results <- validation %>% 
  mutate(CART = predict(sisters_cart, newdata = .),
         XGB  = predict(sisters_rf, newdata = .),
         GBM  = predict(sisters_gbm, newdata = .))

# validate models and pick the best one

# save expensive models
save(sisters_rf, sisters_gbm, file = "models.RData")
