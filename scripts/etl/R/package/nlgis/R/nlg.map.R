nlg.map <- function(df, year, filename, 
                    cuts = cuts.default) {
    # get map
    destfile = paste0(filename, ".geojson")
    download.file(
        paste("http://nlgis.nl/api/maps?year=", 
              "&format=geojson", sep = as.character(year)),
        destfile = destfile)
    
    map <- readOGR(destfile, "OGRGeoJSON")
    
    # to merge with data.frame from SpatialPolygonsDataFrame it is advised to 
    # take out data.frame, do the merge and put it back in.  
    temp <- map@data
    temp$sorder <- c(1:length(temp$id))
    
    # check for duplicate amsterdam_code in df
    #if ( y == 0 ) { warning( "Divide by 0" )
    if (any(duplicated(df$amsterdam_code)) == TRUE) { 
        warning("Duplicated cases in amsterdam_code removed")
        df <- subset(df, !duplicated(amsterdam_code))
    }
    
    temp <- merge(temp, df,
                  by.x = "amsterdamcode",
                  by.y = "amsterdam_code",
                  all.x = TRUE, sort = FALSE)
    temp <- temp[order(temp$sorder), ]
    # temp$sorder <- NULL # uncomment to remove sorder-variable
    # overwrite map@data with merged data.frame
    map@data <- temp
    rm(temp)
    mapgeo <- toGeoJSON(data = map, dest = "./", name = paste0(paste0(filename, year), "Map"))
    
    #cuts.default <- seq(round(min(map@data$value, na.rm = TRUE),0), 
    #                    round(max(map@data$value, na.rm = TRUE),0), 
    #                    length=8)
    cuts.default <- round(quantile(map@data$value, na.rm = TRUE),0) 
    
    
    popup<-c("name", "amsterdamcode", "value")
    sty<-styleGrad(prop="value", breaks=cuts, right=FALSE, style.par="col",
                   style.val=rev(heat.colors(length(cuts)-1)), 
                   leg=paste(filename,year,sep = " "), lwd=1)
    lfmap <- leaflet(mapgeo, 
                     incl.data = TRUE, 
                     popup=popup, 
                     style = sty, base.map = "mqsat")
    lfmap
}

