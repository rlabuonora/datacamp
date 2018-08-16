library(class)
library(readr)
library(tidyverse)

signs <- read_csv("knn_traffic_signs.csv")

test <- signs %>% 
  filter(sample == "test") %>% 
  select(-id, -sample)

train <- signs %>% 
  filter(sample == "train") %>% 
  select(-id, -sample)



# count the number of signs per type
signs %>% count(sign_type)
# Run the provided aggregate() command to see whether 
# the average red level might vary by sign type.
signs %>% group_by(sign_type) %>% summarize(mean_r10 = mean(r10)) 
sign_types <- signs$sign_type
# Run algorithm
signs_pred <- knn(train = train[-1], test = test[-1], cl = train$sign_type)
# signs pred da un vector del tamano de test
# Create confusion matrix
table(signs_pred, test$sign_type)

# The algorithms is sensible to the k-param
# No guideline, just try a couple

# Compute the accuracy of the baseline model (default k = 1)
k_1 <- knn(train = train[-1], test = test[-1], cl = train$sign_type)
mean(k_1 == signs_test$sign_type)

# Modify the above to set k = 7
k_7 <- knn(train = train[-1], test = test[-1], cl = train$sign_type, k = 7)
mean(k_7 == test$sign_type)

# Set k = 15 and compare to the above
k_15 <- knn(train = train[-1], test = test[-1], cl = train$sign_type, k = 15)
mean(k_15 == test$sign_type)

# Show the voting system

sign_pred <- knn(train = train[-1], test = test[-1], cl = train$sign_type, k = 7, prob = TRUE)
# Votes
head(sign_pred)
# pros
attr(sign_pred, "prob")
