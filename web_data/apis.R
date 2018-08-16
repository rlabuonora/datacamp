# download.file
library(httr)
library(pageviews)

hadley_pageviews <- article_pageviews(project = "en.wikipedia",
                                      article = "Hadley Wickham")

## Graceful httr


## Handling errors

fake_url <- "http://google.com/fakepagethatdoesnotexist"

# Make the GET request
request_result <- GET(fake_url)

# Check request_result
if(http_error(request_result)){
  warning("The request failed")
} else {
  content(request_result)
}
## Constructing urls

# use paste
# Construct a directory-based API URL to `http://swapi.co/api`,
# looking for person `1` in `people`
directory_url <- paste("http://swapi.co/api", "people", "1", sep = "/")

# Make a GET call with it
result <- GET(directory_url)

# Create list with nationality and country elements
query_params <- list(nationality = "americans", 
                     country = "antigua")

# Make parameter-based call to httpbin, with query_params
parameter_response <- GET("https://httpbin.org/get", query = query_params)

# Print parameter_response
parameter_response

# Respectful API usage


# Rate limiting
# Construct a vector of 2 URLs
urls <- c("http://fakeurl.com/api/1.0/", 
          "http://fakeurl.com/api/2.0/")

for(url in urls){
  # Send a GET request to url
  result <- GET(url)
  # Delay for 5 seconds between requests
  Sys.sleep(5)
}

# Using everything that you learned in the chapter, 
# let's make a simple replica of one of the 'pageviews' 
# functions - building queries, sending GET requests 
# (with an appropriate user agent) and handling the 
# output in a fault-tolerant way. 
# 

get_pageviews <- function(article_title){
  url <- paste(
    "https://wikimedia.org/api/rest_v1/metrics/pageviews/per-article/en.wikipedia/all-access/all-agents", 
    article_title, 
    "daily/2015100100/2015103100", 
    sep = "/"
  )   
  response <- GET(url, user_agent("my@email.com this is a test")) 
  # Is there an HTTP error?
  if(http_error(response)){ 
    # Throw an R error
    stop("the request failed") 
  }
  # Return the response's content
  content(response)
}

urls <- c("Hamlet", "Antony and Cleopatra", "King Lear")

for (url in urls) {
  get_pageviews(url)
}

# better
urls <- list("Hamlet", "Antony and Cleopatra", "King Lear")
library(purrr)
library(dplyr)
views <- urls %>% map(get_pageviews)
