load("df_points_per_edge_day.Rda")

library(leaflet)

require("RPostgreSQL")

pw <- {
  "y7dWwByZLWso"
}

drv <- dbDriver("PostgreSQL")

con_osm <- dbConnect(drv, dbname = "openstreetmap",
                     host = "localhost", port = 15432,
                     user = "marciofontes", password = pw)

list_points_per_edge_day <- df_points_per_edge_day[1:500, 1]

fun.ecdf <- ecdf(df_points_per_edge_day$points)

my.ecdf <- fun.ecdf(sort(df_points_per_edge_day$points))

my_ecdf_df <- data.frame(my.ecdf)

my_ecdf_df$points <- sort(df_points_per_edge_day$points)

tail(my_ecdf_df, 500)

P <- ecdf(df_points_per_edge_day$points)
grid()
plot(P, log="x", xlim=c(1, max(df_points_per_edge_day$points)))

m <- leaflet() %>% setView(lng=-8.61419, lat=41.16311, zoom = 13)
m <- addTiles(m) 
m <- addProviderTiles(m, "CartoDB.Positron")

counter <- 1

for(way_id in list_points_per_edge_day) {
  
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
    
    if(df_points_per_edge_day[counter, 2] >= 22067) {
      
      m <- addPolylines(m, lons, lats, color='red')
      
    } else if (df_points_per_edge_day[counter, 2] >= 5269 && df_points_per_edge_day[counter, 2] < 22067) {
      
      m <- addPolylines(m, lons, lats, color='yellow')
      
    } else {
      
      m <- addPolylines(m, lons, lats, color='green')
      
    }
    
    counter <- counter + 1 
    
  }
  
  #print(line)
  
}

dbDisconnect(con_osm)

m