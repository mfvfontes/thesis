require("RPostgreSQL")

pw <- {
  "y7dWwByZLWso"
}

drv <- dbDriver("PostgreSQL")

con_osm <- dbConnect(drv, dbname = "sensemycity",
                     host = "localhost", port = 15432,
                     user = "marciofontes", password = pw)

df_top_1percent <- data.frame()

df_top_1percent <- dbGetQuery(con_osm, "SELECT way_id, AVG(diff) FROM (
	                                        SELECT next_sessions.way_id, session_id, seconds, nextSeconds, nextSeconds - seconds AS diff
                                          FROM next_sessions, (
                                            SELECT way_id, COUNT(session_id)
                                            FROM (
                                                  SELECT way_id, MIN(seconds) AS first_session_seconds, session_id
                                                  FROM marciofontes.osmlocation
                                                  GROUP BY way_id, session_id
                                            ) A
                                            GROUP BY way_id
                                            HAVING COUNT(session_id) >= 20
                                          ) B
                                        WHERE to_timestamp(seconds) BETWEEN '2016-04-01' AND '2016-04-30'
                                        AND next_sessions.way_id = B.way_id) AS average_time
                                        GROUP BY way_id
                                        HAVING AVG(diff) > 0
                                        ORDER BY AVG(diff)")

df_top_1percent[1:19, ]

save(df_top_1percent, file="df_top_1percent.Rda")