library(readr)

desserts <- read_csv("data_types/Desserts/desserts.csv")

# No more table!
desserts %>% 
  distinct(signature_nut)

desserts <- desserts %>% 
  mutate(nut = recode(nut, 
                      "filbert" = "hazelnut"))
