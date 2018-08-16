# Load xml2
library(xml2)

# Get XML revision history
resp_xml <- rev_history("Hadley Wickham", format = "xml")

# Check response is XML 
http_type(resp_xml)

# Examine returned text with content()
rev_text <- content(resp_xml, as = "text")
rev_text

# Turn rev_text into an XML document
rev_xml <- read_xml(resp_xml)

# Examine the structure of rev_xml
xml_structure(rev_xml)