# stack overflow

library(tidyverse)
stackoverflow <- read_csv(here('stack_overflow', 'stackoverflow.csv')) %>% 
  mutate(Remote = factor(Remote))

# print data
stackoverflow

# count remotes
stackoverflow %>% 
  count(Remote, sort = TRUE)

stackoverflow %>% 
  count(Country, sort = TRUE)

# Explore visuals
ggplot(stackoverflow, aes(Remote, YearsCodedJob)) + geom_boxplot()

# Simple model
simple_glm <- stackoverflow %>% 
  select(-Respondent) %>% 
  glm(Remote~.,
    family = "binomial",
    data = .)

summary(simple_glm)

# Category is imbalanced
# Upsampling using caret

library(caret)
in_training <- createDataPartition(stackoverflow$Remote, 
                                   p = 0.8, list = FALSE)

training <-stackoverflow[in_training, ]

testing <- stackoverflow[-in_training,]

stack_glm <- train(Remote~., method = "glm",
                   family = "binomial",
                   data = training,
                   trControl = trainControl("boot",
                                            sampling = "up"))

# Upsample
up_train <- upSample(x = select(training, -Remote),
                     y = training$Remote,
                     yname = "Remote") %>% 
  as_tibble


# build glm
stack_glm <- train(Remote~., 
                   method = "glm",
                   family = "binomial",
                   data = up_train,
                   trControl = trainControl(method = "boot",
                                            sampling= "up"))
# build random forest
stack_rf <- train(Remote~.,
                  method = "rf",
                  data = up_train,
                  trControl = trainControl(method = "boot",
                                           sampling = "up"))
# confusion matrix
confusionMatrix(predict(stack_glm, testing), testing$Remote)

library(yardstick)

results <- testing %>% 
  mutate(`Linear regression` = predict(stack_glm, .),
         `Random forest`     = predict(stack_rf, .))

accuracy(results, truth = Remote, estimate = `Linear regression`)
accuracy(results, truth = Remote, estimate = `Random forest`)

