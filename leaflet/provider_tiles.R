library(dplyr)
library(leaflet)
providers

m <- leaflet() %>% setView(0,0,1)

# use set map bounds to prevent the user from moving the map focus
# Store leaflet hq map in an object called map
library(tibble)
dc_hq <- tribble(
  ~hq,               ~lon,  ~lat,
"DataCamp - NYC",    -74.0,  40.7,
"DataCamp - Belgium", 4.72,  50.9
)


leaflet(options = leafletOptions(
  # Set minZoom and dragging 
  minZoom = 12, dragging = TRUE))  %>% 
  addProviderTiles("CartoDB")  %>% 
  # Set default zoom level 
  setView(lng = dc_hq$lon[2], lat = dc_hq$lat[2], zoom = 14) %>% 
  # Set max bounds of map 
  setMaxBounds(lng1 = dc_hq$lon[2] + .05, 
               lat1 = dc_hq$lat[2] + .05, 
               lng2 = dc_hq$lon[2] - .05, 
               lat2 = dc_hq$lat[2] - .05)
  

map <- leaflet() %>% 
  addProviderTiles("CartoDB") %>% 
  # add hq column of dc_hq as popups
  addMarkers(lng = dc_hq$lon, lat = dc_hq$lat, 
             popup = dc_hq$hq)

# Center the view of map on the Belgium HQ with a zoom of 5  
map_zoom <- map %>% 
  setView(lat = 50.881363, lng = 4.717863, 
          zoom = 5)
map_zoom
