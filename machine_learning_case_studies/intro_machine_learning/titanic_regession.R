library(readr)

titanic <- read_csv('./intro_machine_learning/titanic.csv')

library(rpart)
library(rpart.plot)
library(rattle)
library(RColorBrewer)

tree <- rpart(Survived ~ ., data = titanic)
fancyRpartPlot(tree)


# redo with split
library(caTools)
sample <- sample.split(titanic$Survived, 0.7)
train <- subset(titanic, sample == TRUE)
test <- subset(titanic, sample == FALSE)

# estimate
tree <- rpart(Survived~., data = train, method = "class")

#  predictions
pred <- predict(tree, test, type = "class")

# confusion matrix
conf <- table(pred, test$Survived)

set.seed(1)
#accuracy
sum(diag(conf)) / sum(conf)
