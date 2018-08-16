# Load rlist
library(rlist)

# Examine output of this code
str(content(resp_json), max.level = 4)


# Store revision list
revs <- content(resp_json)$query$pages$`41916270`$revisions

# Extract the user element
user_time <- list.select(revs, user, timestamp)

# Print user_time
user_time

# Stack to turn into a data frame
list.stack(user_time)