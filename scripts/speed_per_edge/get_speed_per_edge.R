require("RPostgreSQL")

pw <- {
  "y7dWwByZLWso"
}

drv <- dbDriver("PostgreSQL")

con <- dbConnect(drv, dbname = "sensemycity",
                 host = "localhost", port = 15432,
                 user = "marciofontes", password = pw)

df_speed_per_edge <- data.frame()

df_speed_per_edge <- dbGetQuery(con, "SELECT way_id, session_id, total_distance, total_time, total_distance / total_time AS speed
                                      FROM (
                                      	SELECT way_id, session_id, SUM(ST_Distance(geo, nextGeo)) AS total_distance, (MAX(seconds+(millis/1000.0)) - MIN(seconds+(millis/1000.0))) AS total_time
                                      	FROM (
                                      		SELECT  T1.way_id, T1.session_id, T1.seconds, T1.millis, T1.geo,
                                      			(SELECT T2.geo 
                                      			FROM marciofontes.osmlocation_april T2
                                      			WHERE (T2.seconds > T1.seconds
                                      			OR (T2.seconds = T1.seconds
                                      			AND T2.millis > T1.millis))
                                      			AND T1.session_id = T2.session_id
                                      			AND T1.way_id = T2.way_id
                                      			ORDER BY T2.seconds, T2.millis
                                      			LIMIT 1) nextGeo
                                      		FROM marciofontes.osmlocation_april T1) T3
                                        WHERE (extract(dow from to_timestamp(seconds)) != 0 AND extract(dow from to_timestamp(seconds)) != 6)
                                      	GROUP BY session_id, way_id
                                      ) T4
                                      WHERE total_time > 0
                                      ORDER BY speed DESC")

save(df_speed_per_edge, file = "df_speed_per_edge.Rda")