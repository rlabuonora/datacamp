library(readr)

desserts <- read_csv("data_types/Desserts/desserts.csv",
                     col_types = cols(
                       technical = col_number()
                     ),
                     na = c("NA", "", "N/A"))

# No more table!
desserts %>% 
  distinct(signature_nut)

desserts <- desserts %>% 
  mutate(nut = recode(signature_nut, 
                      "filbert" = "hazelnut",
                      "no nut" = NA_character_))

desserts %>% 
  distinct(nut)

# recode desserts

desserts <- desserts %>% 
  mutate(tech_win = recode_factor(technical,
                           `1` = 1,
                           .default = 0))
desserts %>% count(tech_win)
desserts %>% count(technical)

# count!
desserts %>% 
  count(technical==1, tech_win)
