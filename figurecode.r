library(rgdal);library(raster);library(dismo)
library(maptools)

setwd("~/maketeofigure/")


#rasters, shapefiles, relevant spatial points
alt=raster("~/alt_22.tif")
projection(alt)="+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"
me = readOGR('/mexico', layer = 'MEX_adm0')

#read points
teolocs=read.csv("/teosintes.csv",header=T)
teopoints=teolocs
coordinates(teopoints)=~longitude+latitude
teopoints@proj4string=CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")

png("teoonelev.png",width=4.75,height=3.7,units="in",res=200)#I have still to find a good way to quickly make white space around the raster go away
plot(alt,xlim=c(-117,90),ylim=c(12,29))
points(teopoints,pch=16,cex=.5,col=rgb(1*(as.numeric(teolocs$species)-1),0,0, alpha=1))
plot(me,add=T,usePolypath=FALSE)
legend(-117,17,c("Zea mays ssp. parviglumis","Zea mays ssp. mexicana"),pch=16,col=c("red","black"),bty="n")
dev.off()

