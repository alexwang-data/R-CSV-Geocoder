library(readr)            # for csv writing
library(dplyr)            # for data manipulation
library(tidygeocoder)     # for geocoding addresses
library(sf)               # for spatial object conversion

# 1) read your csv
df <- read.csv("INSERT CSV HERE")

# 2) geocode from one full-address column
# method = census or osm
geo_df <- df %>%
  geocode(
    address = Address,   # csv address column
    method = "osm",
    lat = latitude,
    long = longitude
  )

# 3) inspect results
glimpse(geo_df)

# 4) keep matched rows
geo_ok <- geo_df %>%
  filter(!is.na(latitude), !is.na(longitude))

# 5) make an sf object if you want to map it later
geo_sf <- st_as_sf(geo_ok, coords = c("longitude", "latitude"), crs = 4326)

# 6) write outputs
write_csv(geo_ok, "garment_businesses_geocoded.csv")
st_write(geo_sf, "garment_businesses_geocoded.geojson", delete_dsn = TRUE)
