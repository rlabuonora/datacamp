library(readr)

desserts <- read_csv("data_types/Desserts/desserts.csv",
                     col_types = cols(
                       technical = col_number()
                     ))
problems(desserts)

desserts <- read_csv("data_types/Desserts/desserts.csv",
                     col_types = cols(
                       technical = col_number()
                     ),
                     na = c("", "NA", "N/A"))

# parsing dates

parse_date("17 August 2010", format = "%d %B %Y")

# print info about a certain locale
locale("es")

desserts <- read_csv("data_types/Desserts/desserts.csv",
                     col_types = cols(
                       technical = col_number(),
                       uk_airdate = col_date(
                         format = "%d %B %Y"
                       )
                     ),
                     na = c("NA", "N/A", ""))

# parsing factors

desserts <- read_csv("data_types/Desserts/desserts.csv",
                     col_types = cols(
                       technical = col_number(),
                       uk_airdate = col_date(
                         format = "%d %B %Y"
                       ),
                       result = col_factor(levels = NULL)
                     ),
                     na = c("NA", "", "N/A"))
