require("RPostgreSQL")

pw <- {
  "y7dWwByZLWso"
}

drv <- dbDriver("PostgreSQL")

con <- dbConnect(drv, dbname = "sensemycity",
                 host = "localhost", port = 15432,
                 user = "marciofontes", password = pw)

df_sessions_per_edge <- data.frame()

df_sessions_per_edge <- dbGetQuery(con, "SELECT way_id, COUNT(DISTINCT session_id) AS sessions
                                   FROM marciofontes.osmlocation_april
                                   GROUP BY way_id
                                   ORDER BY sessions DESC")

save(df_sessions_per_edge, file="df_sessions_per_edge.Rda")