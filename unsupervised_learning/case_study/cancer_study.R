library(readr)
library(tidyverse)

df <- read_csv('case_study/WisconsinCancer.csv') 

diagnosis <- (df$diagnosis == "M")

wisc.data <- df %>% 
  select(radius_mean:fractal_dimension_worst) %>% 
  as.matrix

# Get principal components
wisc.pr <- prcomp(wisc.data, scale = TRUE, center = TRUE)

# TODO: redo with ggpplot
biplot(wisc.pr)
plot(wisc.pr$x[,c(1, 2)], col = (diagnosis+1))

# Scree plots

pr.var <- wisc.pr$sdev^2
pve <- pr.var/sum(pr.var)

plot(pve, xlab = "Principal Component",
     ylab = "Variance explained",
     ylim = c(0, 1),
     type = "b")

plot(cumsum(pve), xlab = "Principal Component",
     ylab = "Variance explained",
     ylim = c(0, 1),
     type = "b")

# For the first principal component, 
# what is the component of the loading vector 
# for the feature concave.points_mean? 
wisc.pr$rotation[,c("PC1")]["concave points_mean"]
  
# What is the minimum number of principal components 
# required to explain 80% of the variance of the data?
min(which(cumsum(pve) > 0.8))
