# Align plots
library(cowplot)
theme_set(theme_cowplot(font_size=12)) # reduce default font size

plot.mpg <- ggplot(mpg, aes(cty, hwy, color = factor(cyl))) + 
  geom_point(size=2.5)

plot.diamonds <- ggplot(diamonds, aes(clarity, fill = cut)) + 
  geom_bar() + 
  theme(
    axis.text.x = element_text(angle = 70, vjust = 0.5)
  )

plot_grid(plot.mpg, plot.diamonds, labels = c("A", "B"), align = "h")
  
plot.iris <- ggplot(iris, aes(Sepal.Length, Sepal.Width)) + 
  geom_point() + 
  facet_grid(.~Species) +
  stat_smooth(method = "lm") + 
  panel_border()
