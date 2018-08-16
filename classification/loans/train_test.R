# Apply the nrow() function to determine how many observations 
# are in the loans dataset, and the number needed for a 75% sample.
nrow(loans) * 0.75
# Use the sample() function to create an integer vector of row IDs 
# for the 75% sample. The first argument of sample() should be 
# the number of rows in the data set, and the second is the number 
# of rows you need in your training set.
train <- sample(nrow(loans), .75 * nrow(loans))
# Subset the loans data using the row IDs to create the training dataset. 
# Save this as loans_train.
loans_train <- loans[train,]
# Subset loans again, but this time select all the rows that are not 
# in sample_rows. Save this as loans_test
loans_test <- loans[-train,]

# Use rpart() to build a loan model using the training dataset 
# and all of the available predictors. Again, leave the control argument alone.
loan_model <- rpart(outcome~., 
                    data = loans_train, 
                    method = "class", control = rpart.control(cp = 0))
# Applying the predict() function to the testing dataset, 
# create a vector of predicted outcomes. Don't forget the type argument.
loans_test$pred <- predict(loan_model, loans_test, type = "class")
# Create a table() to compare the predicted 
# values to the actual outcome values.
table(loans_test$pred, loans_test$outcome)
# Compute the accuracy of the predictions using the mean() function.
mean(loans_test$outcome == loans_test$pred)

# Pre pruning

# Add a maxdepth parameter to the rpart.control() object to set the
# maximum tree depth to six. Leave the parameter cp = 0. 
# Pass the result of rpart.control() as the control parameter 
# in your rpart() call.
loan_model <- rpart(outcome~., 
                    data = loans, 
                    method = "class",
                    control = rpart.control(cp = 0, maxdept = 6))
 
# See how the test set accuracy of the simpler model compares to the original
# accuracy of 58.3%.

# First create a vector of predictions using the predict() function.

loans_test$pred <- predict(loan_model, loans_test, type = "class")
# Compare the predictions to the actual outcomes and use mean() to calculate the accuracy.
mean(loans_test$pred == loans_test$outcome)

# Add a minsplit parameter to the rpart.control() object to require 
# 500 observations to split. Again, leave cp = 0.
loan_model <- rpart(outcome~., data = loans_train,
                    method = "class",
                    control = rpart.control(minsplit = 500, cp = 0, maxdepth = 6))
# Again compare the accuracy of the simpler tree to the original.
loans_test$pred <- predict(loan_model, loans_test, type = "class")

mean(loans_test$pred == loans_test$outcome)


# Complexity vs accuracy
# Use all of the applicant variables and no pre-pruning to create an 
# overly complex tree. Make sure to set cp = 0 in rpart.control() 
# to prevent pre-pruning.
loan_model <- rpart(outcome~., data = loans_train,
                    method = "class",
                    control = rpart.control(cp = 0))
# Create a complexity plot by using plotcp() on the model.
plotcp(loan_model)
# Based on the complexity plot, prune the tree to a complexity of 0.0014 
# using the prune() function with the tree and the complexity parameter.
loan_model_pruned <- prune(loan_model, 0.0014)
# Compare the accuracy of the pruned tree to the original accuracy of 58.3%. To calculate the accuracy use the predict() and mean() functions.

loans_test$pred <- predict(loan_model_pruned, loans_test, type = "class")
mean(loans_test$pred == loans_test$outcome)

# Random Forests
# Load the randomForest package
library(randomForest)

# Build a random forest model
loan_model <- randomForest(outcome~., data = loans_train)

# Compute the accuracy of the random forest
loans_test$pred <- predict(loan_model, loans_test, type = "class")
mean(loans_test$pred == loans_test$outcome)