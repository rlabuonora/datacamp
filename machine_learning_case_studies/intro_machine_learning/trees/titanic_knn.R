library(readr)
library(tidyverse)
titanic <- read_csv('./intro_machine_learning/titanic.csv') %>% 
  mutate(Sex = (Sex == "male"))
# split
library(caTools)
set.seed(1)
sample <- sample.split(titanic$Survived, 0.7)
train <- subset(titanic, sample == TRUE)
test <- subset(titanic, sample == FALSE)


test_labels <- test$Survived
train_labels <- train$Survived

knn_train <- select(train, -Survived)
knn_test <- select(test, -Survived)

# Pre-process

# Normalize Age
min_age <- min(train$Age)
max_age <- max(train$Age)
knn_train$Age <- (knn_train$Age - min_age) / (max_age- min_age)
knn_test$Age <- (knn_test$Age - min_age) / (max_age- min_age)

# Normalize Pclass
min_class <- min(knn_train$Pclass)
max_class <- max(knn_train$Pclass)
knn_train$Pclass <- (knn_train$Pclass - min_class) / (max_class - min_class)
knn_test$Pclass <- (knn_test$Pclass - min_class) / (max_class - min_class)

library(class)


# Train model using knn

pred <- knn(train = knn_train, test = knn_test, cl = train_labels, k  = 5)

# build confusion matrix
conf <- table(test_labels, pred)
conf

# Now we need to do this iteratively to pick the right k
range <- 1:100
accs <- rep(0, length(range))

for (k in range) {
  pred <- knn(knn_train, knn_test, cl = train_labels, k = k)
  conf <- table(test_labels, pred)
  accs[k] <- sum(diag(conf)) / sum(conf)
}

plot(range, accs, xlab = "k")

which.max(accs)
