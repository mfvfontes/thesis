require("RPostgreSQL")

pw <- {
  "y7dWwByZLWso"
}

drv <- dbDriver("PostgreSQL")

con <- dbConnect(drv, dbname = "sensemycity",
                 host = "localhost", port = 15432,
                 user = "marciofontes", password = pw)

df_points_per_edge <- data.frame()

df_points_per_edge <- dbGetQuery(con, "SELECT way_id, COUNT(*) AS points
                                       FROM marciofontes.osmlocation
                                       LEFT JOIN annotation USING (session_id, seconds, millis)
                                       WHERE NOT notmoving 
                                       AND NOT duplicate  
                                       AND NOT locationproblem  
                                       AND NOT wrongclock
                                       GROUP BY way_id
                                       ORDER BY points DESC")

save(df_points_per_edge, file="df_points_per_edge.Rda")