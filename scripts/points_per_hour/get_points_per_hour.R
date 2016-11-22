require("RPostgreSQL")

pw <- {
  "y7dWwByZLWso"
}

drv <- dbDriver("PostgreSQL")

con_osm <- dbConnect(drv, dbname = "sensemycity",
                     host = "localhost", port = 15432,
                     user = "marciofontes", password = pw)

df_points_per_hour <- data.frame()

df_points_per_hour <- dbGetQuery(con_osm, "SELECT extract(hour from to_timestamp(seconds)) AS hour_points, 
                                           COUNT(*)/COUNT(DISTINCT to_char(to_timestamp(seconds), 'YYYY-MM-DD')) AS num_points
                                           FROM marciofontes.osmlocation
                                           GROUP BY hour_points
                                           ORDER BY hour_points ASC")

df_points_per_hour_smc <- dbGetQuery(con_osm, "SELECT extract(hour from to_timestamp(seconds)) AS hour_points, 
                                               COUNT(*)/COUNT(DISTINCT to_char(to_timestamp(seconds), 'YYYY-MM-DD')) AS num_points
                                               FROM marciofontes.osmlocation
                                               WHERE data_src = 'smc'
                                               GROUP BY hour_points
                                               ORDER BY hour_points ASC")

df_points_per_hour_smm <- dbGetQuery(con_osm, "SELECT extract(hour from to_timestamp(seconds)) AS hour_points, 
                                               COUNT(*)/COUNT(DISTINCT to_char(to_timestamp(seconds), 'YYYY-MM-DD')) AS num_points
                                               FROM marciofontes.osmlocation
                                               WHERE data_src = 'smm'
                                               GROUP BY hour_points
                                               ORDER BY hour_points ASC")

df_points_per_hour_smf <- dbGetQuery(con_osm, "SELECT extract(hour from to_timestamp(seconds)) AS hour_points, 
                                               COUNT(*)/COUNT(DISTINCT to_char(to_timestamp(seconds), 'YYYY-MM-DD')) AS num_points
                                               FROM marciofontes.osmlocation
                                               WHERE data_src = 'smf'
                                               GROUP BY hour_points
                                               ORDER BY hour_points ASC")

save(df_points_per_hour_smc, file="df_points_per_hour_smc.Rda")
save(df_points_per_hour_smm, file="df_points_per_hour_smm.Rda")
save(df_points_per_hour_smf, file="df_points_per_hour_smf.Rda")
