library(ggplot2)

cars <- readr::read_csv("cars04.csv")


# Compare SUV mileage to non-SUVs
ggplot(cars, aes(city_mpg)) + 
  geom_histogram() + 
  facet_wrap(~ suv)


posn.j <- position_jitter(width = 0.25)
# Better way!
ggplot(cars, aes(suv, city_mpg, color = suv)) + 
  geom_point(position = posn.j) + 
  geom_boxplot()

# Filter cars with 4, 6, 8 cylinders
common_cyl <- dplyr::filter(cars, ncyl %in% c(4, 6, 8))

# Create box plots of city mpg by ncyl
ggplot(common_cyl, aes(x = as.factor(ncyl), y = city_mpg)) +
  geom_boxplot()

# Create overlaid density plots for same data
ggplot(common_cyl, aes(x = city_mpg, fill = as.factor(ncyl))) +
  geom_density(alpha = .3)
