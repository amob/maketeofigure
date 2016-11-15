#!/usr/bin/Rscript
library(rgdal);library(raster);library(dismo)
library(maptools)

setwd("~/maketeofigure/")#pick a directory where your files are stored


#rasters, shapefiles, relevant spatial points, they come from here, from tile 22, which is the one I use: http://www.worldclim.org/tiles.php
alt <- raster("alt_22.tif")#
projection(alt) <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"

TAnn <- raster("bio1_22.tif")#mean annual temperature
projection(TAnn) <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"

PAnn <- raster("bio12_22.tif")#annual precip
projection(TAnn) <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"


#read points
teolocs <- read.csv("teosintes.csv",header=T)#THIS IS  in your points, needs column names "longitude" and "latitude"
teopoints <- teolocs
coordinates(teopoints) <- ~longitude+latitude
teopoints@proj4string <- CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")

png("teoonelev.png",width=4.75,height=3.7,units="in",res=200)#I have still to find a good way to quickly make white space around the raster go away, play with dimensions until it works
plot(alt,xlim=c(-117,90),ylim=c(12,29))
points(teopoints,pch=16,cex=.5)
dev.off()

#Color palettes
blgr <- colorRampPalette(c("blue4","darkolivegreen1"))
wbr <- colorRampPalette(c(rgb(1,1,1,alpha=1),rgb(0,0,1,alpha=1),rgb(1,0,0,alpha=1)))
rb.c  <- colorRampPalette(c(rgb(0,0,0,alpha=1),rgb(0,0,1,alpha=1),rgb(1,0,0,alpha=1)))

png("teoonTAnn.png",width=4.75,height=3.7,units="in",res=200)#I have still to find a good way to quickly make white space around the raster go away, play with dimensions/xlim/ylim until it works
plot(TAnn,xlim=c(-117,90),ylim=c(12,29),col = wbr(255))
points(teopoints,pch=16,cex=.5)
dev.off()

png("teoonPAnn.png",width=4.75,height=3.7,units="in",res=200)#
plot(PAnn,xlim=c(-117,90),ylim=c(12,29),col = blgr(255))
points(teopoints,pch=16,cex=.5)
dev.off()

