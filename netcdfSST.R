library(raster)
library(ncdf4)

# opening netcdf as a raster file
setwd("~/SST/ghrsst-GDS1-L2P-AVHRR19/20090906-AVHRR19_L-NEODAAS-L2P-06sep091548_
      wsst.8bit-v01.nc")
fn       <- "20090906-AVHRR19_L-NEODAAS-L2P-06sep091548_wsst.8bit-v01.nc"

ncfile   <- nc_open(fn)
print(ncfile)

rasbrick <- brick(fn)
rasbrick

# saving netcdf as a csv
nc.brick <- brick(file.choose()) # allows me to choose the nc file on my desktop
dim(nc.brick) #gives rows columns layers
nc.df    <- as.data.frame(nc.brick[[1]],xy=T) #choosing first layer, xy=T gives xy coordinates
head(nc.df) # shows xy coordinates and x2009.09.06.16.03.05 variable

# create empty csv that we can import data into
# name this empty csv as output.csv in out filpath
write.csv(nc.df, file.choose()) #this takes time

# make sure there is actually data in the csv (max and min should be different)
max(nc.df$X2009.09.06.16.03.05, na.rm = T)
min(nc.df$X2009.09.06.16.03.05, na.rm = T)
mean(nc.df$X2009.09.06.16.03.05, na.rm = T)

# now we can read in the csv
test     <- read.csv(file.choose())
# make sure the csv and data frame have same values
max(test$X2009.09.06.16.03.05, na.rm = T)

# open netcdf file and get data
library(ncdf4)
fn       <- "20090906-AVHRR19_L-NEODAAS-L2P-06sep091548_wsst.8bit-v01.nc"
nc <- nc_open(fn)
print(nc)
attributes(nc$var) # gives us the variables in the netcdf
dat <- ncvar_get(nc,attributes(nc$var)$names[1]) # gives matrix of data
dim(dat) # gives dimensions of the data