library(caret)
library(tidyverse)

cars2018 <- read_csv("cars2018.csv")

cars_vars <- cars2018 %>% 
  select(-Model, -`Model Index`)

set.seed(1234)
in_train <- createDataPartition(cars_vars, p = 0.8, list = FALSE)
training <- cars2018[in_train,]

# train linear model

# train random forest
