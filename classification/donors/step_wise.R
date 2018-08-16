library(pROC)
library(readr)
donors <- read_csv("donors/donors.csv")

# Use the R formula interface with glm() to 
# specify the base model with no predictors. Set the explanatory variable equal to 1.
null_model <- glm(donated~1, data = donors, family = "binomial")
# Use the R formula interface again with glm() to 
# specify the model with all predictors.
full_model <- glm(donated~., data = donors, family = "binomial")
# Apply step() to these models to perform forward stepwise regression. 
step_model <- step(null_model, scope = list(lower = null_model, upper = full_model), direction = "forward")

# Set the first argument to null_model and set direction = "forward". 
# This might take a while (up to 10 or 15 seconds) as your computer has to fit quite a few different models to perform stepwise selection.
# Create a vector of predicted probabilities using the predict() function.
step_prob <- predict(step_model, donors, type = "response")
library(pROC)
# Plot the ROC curve with roc() and plot() and compute 
# the AUC of the stepwise model with auc().
ROC <- roc(donors$donated, step_prob)
plot(ROC)
auc(ROC)
  