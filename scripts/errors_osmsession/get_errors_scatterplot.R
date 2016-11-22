require("RPostgreSQL")

pw <- {
  "y7dWwByZLWso"
}

drv <- dbDriver("PostgreSQL")

con_osm <- dbConnect(drv, dbname = "sensemycity",
                     host = "localhost", port = 15432,
                     user = "marciofontes", password = pw)

df_errors <- data.frame()

df_errors <- dbGetQuery(con_osm, "SELECT session_id, AVG(err) AS avg, stddev_samp(err) AS std, std/avg AS ratio
                                     FROM marciofontes.osmlocation 
                                     GROUP BY session_id")

save(df_errors, file = "df_errors.Rda")

# plot(df_errors$avg, df_errors$std, xlim=c(0, 20000), ylim=c(0, 15000))