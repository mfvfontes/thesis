require("RPostgreSQL")

pw <- {
  "y7dWwByZLWso"
}

drv <- dbDriver("PostgreSQL")

con_osm <- dbConnect(drv, dbname = "sensemycity",
                     host = "localhost", port = 15432,
                     user = "marciofontes", password = pw)

df_users_per_day <- data.frame()

df_users_per_day <- dbGetQuery(con_osm, "SELECT extract(day from to_timestamp(start_time)) AS day, COUNT(DISTINCT daily_user_id) AS num_users
                                         FROM session_users
                                         GROUP BY day
                                         ORDER BY day")

save(df_users_per_day, file="df_users_per_day.Rda")