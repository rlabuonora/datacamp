library(readr)

comics <- read_csv("comics.csv")
# Change the order of the levels in align
comics$align <- factor(comics$align, 
                       levels = c("Bad", "Neutral", "Good"))
# Create plot of align
ggplot(comics, aes(x = align)) + 
  geom_bar()