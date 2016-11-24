require("RPostgreSQL")

pw <- {
  "y7dWwByZLWso"
}

drv <- dbDriver("PostgreSQL")

con <- dbConnect(drv, dbname = "sensemycity",
                 host = "localhost", port = 15432,
                 user = "marciofontes", password = pw)

df_inter_session <- data.frame()

df_inter_session <- dbGetQuery(con, "SELECT way_id, AVG(diff) FROM (
	                                        SELECT next_sessions.way_id, session_id, seconds, nextSeconds, nextSeconds - seconds AS diff
                                          FROM next_sessions, (
                                            SELECT way_id, COUNT(session_id)
                                            FROM (
                                              SELECT way_id, MIN(seconds) AS first_session_seconds, session_id
                                              FROM marciofontes.osmlocation_april
                                              GROUP BY way_id, session_id
                                            ) A
                                            GROUP BY way_id
                                            HAVING COUNT(session_id) >= 20
                                          ) B
                                      WHERE next_sessions.way_id = B.way_id) AS average_time
                                      GROUP BY way_id
                                      HAVING AVG(diff) > 0
                                      ORDER BY AVG(diff)")

save(df_inter_session, file="df_inter_session.Rda")