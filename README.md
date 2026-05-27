# Automated-Geocoding-Workflow-in-R-for-Spatial-Data-Processing

## 🕵️ Overview

A small R script for batch-geocoding addresses from a CSV using OpenStreetMap's Nominatim service, with output as CSV, Shapefile, GeoJSON, or GeoPackage for mapping.

## 🤔 Why R instead of ArcGIS?

In ArcGIS Pro, geocoding is a lot of clicking. This script takes a CSV in, returns a desired file format with address validation, and requires mimnial manual intervention. 

## 📚 Libraries
```r
library(readr)            # for csv writing
library(dplyr)            # for data manipulation
library(tidygeocoder)     # for geocoding addresses
library(sf)               # for spatial object conversion
```

## 💻 How To Replicate
Install R and RStudio:<br>
https://posit.co/download/rstudio-desktop <br>

In RStudio, install and load all of the **4 libraries**:<br>
```r
install.packages("tidygeocoder")
library(tidygeocoder)
```
Create a folder on your desktop.<br>

In RStudio, set a working directory (Mac):<br>
https://www.learn-r.org/r-tutorial/setwd-r.php
```r
getwd()
setwd("/Users/USER/Desktop/FOLDER")
```
## 🗒️ Notes

OSM/Nominatim has a usage policy of one request per second and isn't internded for heavy bulk use. For larger US-only batches, switch 
```r 
method = "osm"
```
to
```r
method = "census"
```
in the script to use the US Census geocoder. <br><br>

For QGIS, export as GeoJSON. <br>

For ArcGIS Pro, export as GeoPackage.
