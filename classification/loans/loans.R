# Loans
library(rpart)

loans <- read_csv('loans/loans.csv')
  

loans <- loans %>% 
  filter(keep == 1) %>% 
  mutate(outcome = if_else(default == 1, "default", "repaid")) %>% 
  select(-keep, -rand, -default)

write_csv(loans, "loans/loans_filtered.csv")

good_credit <- tribble(
  ~loan_amount, ~emp_length, ~home_ownership, ~income,   ~loan_purpose, ~debt_to_income, 
  ~credit_score, ~recent_inquiry, ~delinquent, ~credit_accounts, ~bad_public_record, 
  ~credit_utilization, ~past_bankrupt, ~outcome,
  "LOW", "10+ years", "MORTGAGE", "HIGH", "major_purchase", "AVERAGE",
  "HIGH","NO", "NEVER", "MANY" , "NO", "LOW", "NO",  "repaid")

bad_credit <- tribble(
  ~loan_amount, ~emp_length, ~home_ownership, ~income,   ~loan_purpose, ~debt_to_income, 
  ~credit_score, ~recent_inquiry, ~delinquent, ~credit_accounts, ~bad_public_record, 
  ~credit_utilization, ~past_bankrupt, ~outcome,
  "LOW", "6 - 9 years", "RENT", "MEDIUM", "car", "LOW", "LOW", 
  "YES", "NEVER", "FEW", "NO", "HIGH", "NO", "repaid")

good_credit <- data.frame(matrix(ncol = 14, nrow = 0))
colnames(good_credit) <- credit_names
good_credit <- rbind(good_credit, good_credit_data)

loan_model <- rpart(outcome~loan_amount+credit_score, data = loans, method = "class", control = rpart.control(cp = 0))

predict(loan_model, good_credit, type = "class")

loan_model
library(rpart.plot)
rpart.plot(loan_model)
rpart.plot(loan_model, type = 3)
