# Get revision history for "Hadley Wickham"
resp_json <- rev_history("Hadley Wickham")

# Check http_type() of resp_json
http_type(resp_json)

# Examine returned text with content()
content(resp_json, as = "text")

# Parse response with content()
content(resp_json, as = "parsed")

# Parse returned text with fromJSON()
library(jsonlite)
fromJSON(content(resp_json, as = "text"))