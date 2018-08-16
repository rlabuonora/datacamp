# coding categorical features
library(readr)
donors <- read_csv('donors/donors.csv')

# Recode categorical
donors$wealth_rating <- factor(donors$wealth_rating, 
                               levels = 0:3,
                               labels =c("Unknown", "Low", "Medium", "High"))
donors$wealth_rating <- relevel(donors$wealth_rating, ref = "Medium")

# missing data

# Use summary() on donors to find the average age 
# of prospects with non-missing data.
summary(donors$age)

# Use ifelse() and the test is.na(donor$age) 
# to impute the average (rounded to 2 decimal places)
# for cases with missing age.
donors$imputed_age <- ifelse(is.na(donors$age), round(mean(donors$age, na.rm=TRUE), 2), donors$age)

# Create a binary dummy variable named missing_age 
# indicating the presence of missing data using another 
# ifelse() call and the same test.
donors$missing_age <- ifelse(is.na(donors$age), 1, 0)
# 
# Create a logistic regression model of donated as a 
# function of money plus the interaction of recency and frequency. 
# Use * to add the interaction term.

rfm_model <- glm(donated~money + recency*frequency, data = donors, family="binomial")
