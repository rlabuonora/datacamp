# Create a logged version of the nc_pal color palette
nc_pal <- colorNumeric("YlGn", domain = log(high_inc@data$mean_income))

# apply the nc_pal
high_inc %>%
  leaflet() %>%
  addProviderTiles("CartoDB") %>%
  addPolygons(weight = 1, color = ~nc_pal(log(mean_income)), fillOpacity = 1,
              label = ~paste0("Mean Income: ", dollar(mean_income)),
              highlightOptions = highlightOptions(weight = 5, color = "white", bringToFront = TRUE))