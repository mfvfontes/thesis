require("RPostgreSQL")

pw <- {
  "y7dWwByZLWso"
}

drv <- dbDriver("PostgreSQL")

con_smc <- dbConnect(drv, dbname = "sensemycity",
                     host = "localhost", port = 15432,
                     user = "marciofontes", password = pw)

df_points_per_edge_night <- data.frame()

df_points_per_edge_night <- dbGetQuery(con_smc, "SELECT way_id, COUNT(*) AS points
                                     FROM marciofontes.osmlocation
                                     WHERE cast(to_char(to_timestamp(seconds), 'HH24:MI:SS') as time) >= cast('20:30:01' as time)
                                     OR cast(to_char(to_timestamp(seconds), 'HH24:MI:SS') as time) <= cast('7:29:59' as time)
                                     GROUP BY way_id
                                     ORDER BY points DESC")

save(df_points_per_edge_night, file="df_points_per_edge_night.Rda")