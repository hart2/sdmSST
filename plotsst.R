library(tidyverse)
library(sf)
library(mapview)
library(rgdal)
library(raster)
library(ggplot2)

setwd("~/SST/modis-a")
# Level 2 file, Derived geophysical variables at the same resolution and location as Level 1 source data.
fn       <- "20160608-MODIS_A-JPL-L2P-A2016160005000.L2_LAC_GHRSST_D-v01.nc" 

ncfile   <- nc_open(fn)
print(ncfile)

rasbrick <- brick(fn) # raster of the netcdf

# convert to a df for plotting in two steps,
# First, to a SpatialPointsDataFrame
rasbrick_pts <- rasterToPoints(rasbrick, spatial = TRUE)
# Then to a 'conventional' dataframe
rasbrick_df  <- data.frame(rasbrick_pts)

ggplot() +
  geom_raster(data = rasbrick_df , aes(x = x, y = y, fill = X2016.06.08.00.50.43)) + 
  ggtitle("MODIS Aqua June 8 2016")