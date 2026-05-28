library(readr)            # for csv writing
library(stringr)          # for string manipulation
library(dplyr)            # for data manipulation
library(tidygeocoder)     # for geocoding addresses
library(sf)               # for spatial object conversion


# 1) read your csv
df <- read.csv("INSERT CSV HERE")


# 2) clean the data
# Address = csv address column
df_clean <- df %>%
  mutate(
    Address = str_squish(Address),                   # format spacing
    address_valid = !is.na(Address) &                # condition 1: check if is not missing
      Address != "" &                                # condition 2: check if is not empty
      !str_detect(str_to_lower(Address),             # converts everything to lower case for detection
                  "^(unknown|tbd|n\a|na|null)$")     # condition 3: check if is not null or unknown
  )


# 3) save invalid addresses
df_invaild <- df_clean %>%
  filter(!address_valid)


# 4) save geocode data frame
df_to_geocode <- df_clean %>%
  filter(address_valid)


# 5) geocode
# method = census or osm
geo_df <- df_to_geocode %>%
  geocode(
    address = Address,   
    method = "osm",
    lat = latitude,
    long = longitude
  )


# 6) inspect results
glimpse(geo_df)


# 7) save unmatched rows
geo_failed <- geo_df %>%
  filter(is.na(latitude) | is.na(longitude))


# 8) keep matched rows
geo_ok <- geo_df %>%
  filter(!is.na(latitude), !is.na(longitude))


# 9) make an sf object if you want to map it later
geo_sf <- st_as_sf(geo_ok, coords = c("longitude", "latitude"), crs = 4326)


# 10) write outputs

# CSV
write_csv(geo_ok, "NAME.csv")                     

# Shapefile
st_write(geo_sf, "NAME.shp", delete_layer = TRUE)

# GeoJSON
st_write(geo_sf, "NAME.geojson", delete_dsn = TRUE)  # QGIS

# GeoPackage
st_write(geo_sf, "NAME.gpkg", delete_dsn = TRUE)     # ArcGIS

