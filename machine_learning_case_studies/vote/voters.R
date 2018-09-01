# voters
library(tidyverse)

voters <- read_csv(here('vote', 'voters.csv')) %>% 
  mutate(turnout16_2016 = factor(turnout16_2016))

# how many voted?
voters %>% 
  count(turnout16_2016)

# differences btw those who voted and those who dont
voters %>% 
  group_by(turnout16_2016) %>% 
  summarize(`Elections don't matter` = mean(RIGGED_SYSTEM_1_2016 <= 2),
            `Economy is getting better` = mean(econtrend_2016 == 1),
            `Crime is very important` = mean(imiss_a_2016 == 2))


# differences in voter turnout
voters %>%
  ggplot(aes(econtrend_2016, ..density.., fill = turnout16_2016)) +
  geom_histogram(alpha = 0.5, position = "identity", binwidth = 1) +
  labs(title = "Overall, is the economy getting better or worse?")

# biuld a simple model

voters_select <- voters %>% 
  select(-case_identifier)

simple_glm <- glm(turnout16_2016~., data = voters_select, family = "binomial")
summary(simple_glm)

library(broom)
# Cuales son los factores que mas pesan?
simple_glm_df <- simple_glm %>% 
  tidy() %>% 
  filter(p.value < 0.5) %>% 
  arrange(desc(estimate))

simple_glm_df %>% 
  ggplot(aes(fct_reorder(term, estimate), estimate)) + 
  geom_point() + 
  coord_flip()
  
# start machine learning
library(caret)

in_train <- createDataPartition(voters_select$turnout16_2016, p=0.8, list = FALSE)
training <- voters_select[in_train, ]
testing <- voters_select[-in_train, ]

vote_glm <- train(turnout16_2016~., method = "glm", 
                  family = "binomial",
                  data = training,
                  trControl = trainControl(method = "none",
                                           sampling = "up"))
# k-fold cross validation

vote_glm_cv <- train(turnout16_2016~., method = "glm",
                     family = "binomial",
                     data = training,
                     trControl = trainControl(method = "repeatedcv",
                                              repeats = 2,
                                              sampling = "up"))

vote_rf_cv <- train(turnout16_2016~., method = "rf",
                    data = training,
                    trControl = trainControl(method = "repeatedcv",
                                             repeats = 2,
                                             sampling = "up"))

# glm does not overfit
confusionMatrix(predict(vote_glm_cv, training), training$turnout16_2016)
confusionMatrix(predict(vote_glm_cv, testing), testing$turnout16_2016)


# random forest does
confusionMatrix(predict(vote_rf_cv, training), training$turnout16_2016)
confusionMatrix(predict(vote_rf_cv, testing), testing$turnout16_2016)
