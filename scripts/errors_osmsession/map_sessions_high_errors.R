load("df_errors.Rda")

library(leaflet)

require("RPostgreSQL")

pw <- {
  "y7dWwByZLWso"
}

drv <- dbDriver("PostgreSQL")

con_osm <- dbConnect(drv, dbname = "openstreetmap",
                     host = "localhost", port = 15432,
                     user = "marciofontes", password = pw)

con_smc <- dbConnect(drv, dbname = "sensemycity",
                     host = "localhost", port = 15432,
                     user = "marciofontes", password = pw)

df_sessions_high_errors <- subset(df_errors, std == 0.0)

# df_sessions_high_errors <- df_sessions_high_errors[order(-df_sessions_high_errors$avg), ]

print(df_sessions_high_errors)

for(session_id in df_sessions_high_errors[, 1]) {
  
  m <- leaflet() %>% setView(lng=-8.61419, lat=41.16311, zoom = 13)
  m <- addTiles(m)
  m <- addProviderTiles(m, "CartoDB.Positron")
  
  df_way_ids <- dbGetQuery(con_smc, paste0("SELECT DISTINCT way_id
                                            FROM marciofontes.osmlocation
                                            WHERE session_id = ", session_id))
  
  for(way_id in df_way_ids[, 1]) {
     
    df_way_id <- dbGetQuery(con_osm, paste0("SELECT st_astext(st_transform(way, 4326)) AS line FROM planet_osm_line WHERE planet_osm_line.osm_id = ", way_id))
    
    line <- df_way_id$line
    line <- as.character(line)
    
    line <- unlist(strsplit(line, split='(', fixed=TRUE))[2]
    line <- substr(line, 1, nchar(line) - 1)
    
    parsed_line <- strsplit(line, ",")
    
    lons <- c()
    lats <- c()
    
    if(length(parsed_line) != 0) {
      
      for(coord in parsed_line[[1]]) {
        
        lon <- unlist(strsplit(coord, split=' ', fixed=TRUE))[1]
        lat <- unlist(strsplit(coord, split=lon, fixed=TRUE))[2]
        lat <- substr(lat, 2, nchar(lat))
        
        lon <- as.numeric(lon)
        lat <- as.double(lat)
        
        lons <- c(lons, lon)
        lats <- c(lats, lat)
        
      }
      
      m <- addPolylines(m, lons, lats, color='red')
      
      counter <- counter + 1
      
    }
    
  }
  
  print(m)
}

dbDisconnect(con_osm)
dbDisconnect(con_smc)
