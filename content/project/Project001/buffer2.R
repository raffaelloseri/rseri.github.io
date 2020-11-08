library(sphereplot)
library(geometry)

rgl.sphgrid <- function (radius = 1, col.long = "red", col.lat = "blue", deggap = 15, 
    longtype = "H", add = FALSE, radlab = "Radius") {
    if (add == F) {
        open3d()
    }
    for (lat in seq(-90, 90, by = deggap)) {
        if (lat == 0) {
            col.grid = "grey50"
        }
        else {
            col.grid = "grey"
        }
        plot3d(sph2car(long = seq(0, 360, len = 100), lat = lat, 
            radius = radius, deg = T), col = col.grid, add = T, 
            type = "l")
    }
    for (long in seq(0, 360 - deggap, by = deggap)) {
        if (long == 0) {
            col.grid = "grey50"
        }
        else {
            col.grid = "grey"
        }
        plot3d(sph2car(long = long, lat = seq(-90, 90, len = 100), 
            radius = radius, deg = T), col = col.grid, add = T, 
            type = "l")
    }
    if (longtype == "H") {
        scale = 15
    }
    if (longtype == "D") {
        scale = 1
    } 
}

sc.plot3d <- function(samplesToPlot, size=700, outputFile=NULL){
	suppressPackageStartupMessages(library(rgl))
	open3d(windowRect = c(0,0, size, size), zoom=0.7)
#	rgl.sphgrid(col.long='white',col.lat='')
	Z <- matrix(rnorm(900),ncol=3)
	Z <- Z*1/outer(sqrt(apply(Z*Z,1,sum)),rep(1,3))
	ps1 <- Z  # generate points on a sphere
	ts.surf1 <- t(convhulln(ps1))  # see the qhull documentations for the options
	convex1 <-  rgl.triangles(ps1[ts.surf1,1],ps1[ts.surf1,2],ps1[ts.surf1,3],col="gold2",alpha=.9)
	convex2 <-  rgl.linestrips(ps1[ts.surf1,1],ps1[ts.surf1,2],ps1[ts.surf1,3],col="black",lwd=1)
    outputFile = sub(".gif$","",outputFile)
    movie3d(spin3d(axis=c(0,0,1), rpm=5), duration=12, dir=getwd(), movie=outputFile)
}

sc.plot3d(1:3, size=700, outputFile="featured")

#####

library(sphereplot)
library(rgl)

open3d(zoom=0.7)
#rgl.sphgrid(col.long='', col.lat='',radaxis=FALSE)

Z <- matrix(rnorm(900),ncol=3)
Z <- Z*1/outer(sqrt(apply(Z*Z,1,sum)),rep(1,3))
library(geometry)
ps1 <- Z  # generate points on a sphere
ts.surf1 <- t(convhulln(ps1))  # see the qhull documentations for the options

convex1 <-  rgl.triangles(ps1[ts.surf1,1],ps1[ts.surf1,2],ps1[ts.surf1,3],col="gold2",alpha=.9)
convex2 <-  rgl.linestrips(ps1[ts.surf1,1],ps1[ts.surf1,2],ps1[ts.surf1,3],col="black",lwd=.5)

rgl.postscript("plot.pdf",fmt="pdf")
