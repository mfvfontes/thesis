require("RPostgreSQL")

pw <- {
  "y7dWwByZLWso"
}

drv <- dbDriver("PostgreSQL")

con_osm <- dbConnect(drv, dbname = "sensemycity",
                     host = "localhost", port = 15432,
                     user = "marciofontes", password = pw)

df_sessions_per_edge_filtered <- data.frame()

df_sessions_per_edge_filtered <- dbGetQuery(con_osm, "SELECT way_id, COUNT(DISTINCT session_id) AS sessions
                                                      FROM marciofontes.osmlocation
                                                      LEFT JOIN annotation USING (session_id, seconds, millis)
                                                      WHERE NOT notmoving 
                                                      AND NOT duplicate  
                                                      AND NOT locationproblem  
                                                      AND NOT wrongclock
                                                      GROUP BY way_id
                                                      ORDER BY sessions DESC")

save(df_sessions_per_edge_filtered, file="df_sessions_per_edge_filtered.Rda")

