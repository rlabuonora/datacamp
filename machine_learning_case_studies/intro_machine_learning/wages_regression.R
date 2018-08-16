# Wages
library(Ecdat)

wages_lm <- lm(wage ~ exper + sex + school, data = Wages1)
unseen <- data_frame(exper = 5, sex = "female", school = 16)
prediction <- predict(wages_lm, unseen)
