require("RPostgreSQL")

pw <- {
  "y7dWwByZLWso"
}

drv <- dbDriver("PostgreSQL")

con <- dbConnect(drv, dbname = "sensemycity",
                 host = "localhost", port = 15432,
                 user = "marciofontes", password = pw)

df_speed_per_edge_hour <- data.frame()

df_speed_per_edge_hour <- dbGetQuery(con, "SELECT T4.way_id, hour, AVG((total_distance / total_time)*3.6) AS speed 
FROM (
                                     SELECT way_id, session_id, extract(hour from to_timestamp(seconds)) AS hour, SUM(ST_Distance(geo, nextGeo)) AS total_distance, (MAX(seconds) - MIN(seconds)) AS total_time
                                     FROM (
                                     SELECT  T1.way_id, T1.session_id, T1.seconds, T1.geo,
                                     (SELECT T2.geo 
                                     FROM marciofontes.osmlocation_april T2
                                     WHERE T2.seconds > T1.seconds
                                     AND T1.session_id = T2.session_id
                                     ORDER BY T2.seconds
                                     LIMIT 1) nextGeo
                                     FROM marciofontes.osmlocation_april T1) T3
                                     GROUP BY way_id, session_id, hour
) T4, (SELECT way_id, COUNT(DISTINCT session_id)
                                     FROM marciofontes.osmlocation_april
                                     GROUP BY way_id
                                     HAVING COUNT(DISTINCT session_id) >= 20
) T5
                                     WHERE total_time > 0
                                     AND T4.way_id = T5.way_id
                                     GROUP BY T4.way_id, hour")

save(df_speed_per_edge_hour, file = "df_speed_per_edge_hour.Rda")
