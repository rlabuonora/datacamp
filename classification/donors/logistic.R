# Load the pROC package
library(pROC)
library(readr)
donors <- read_csv('donors/donors.csv')



# Build the donation model
donation_model <- glm(donated ~ bad_address + 
                        interest_religion + 
                        interest_veterans,
                      data = donors, family = "binomial")

summary(donation_model)

# get donation probabilities
donors$donation_prob <- predict(donation_model, donors, type="response")
# get probability of donating
mean(donors$donated)
# Predict a donation if probability of donation is greater than average (0.0504)
donors$prediction <- ifelse(donors$donation_prob > mean(donors$donated), 1, 0)
# Check for accuracy
mean(donors$prediction == donors$donated)

# TODO: build confusion matrix

# Create a ROC curve
ROC <- roc(donors$donated, donors$donation_prob )

# Plot the ROC curve
plot(ROC, col = "blue")

# Create a logistic regression model of donated as a function 
# of money plus the interaction of recency and frequency. 
# Use * to add the interaction term.
rfm_model <- glm(donated~money + recency*frequency, data = donors, family = "binomial")
# Examine the model's summary() 
# to confirm the interaction effect was added.
summary(rfm_model)
# Save the model's predicted probabilities as rfm_prob. 
# Use the predict() function, and remember to set the type argument.
rfm_prob <- predict(rfm_model, donors)
# Plot a ROC curve by using the function roc(). 
# Remember, this function takes the column of outcomes and the 
# vector of predictions.
ROC <- roc(donors$donated, rfm_prob)
plot(ROC)
auc(ROC)
# Compute the AUC for the new model with the function auc() 
# and compare performance to the simpler model.


# Calculate the area under the curve (AUC)
auc(ROC)
