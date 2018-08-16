# The first step before you start modeling is to explore your data. 
# In this course we'll practice using tidyverse functions for exploratory 
# data analysis. Start off this case study by examinig your data set and 
# visualizing the distribution of fuel efficiency. 
# The ggplot2 package, with functions like ggplot() 
# and geom_histogram() are included in the tidyverse.


library(tidyverse)
cars2018 <- read_csv("cars2018.csv")
