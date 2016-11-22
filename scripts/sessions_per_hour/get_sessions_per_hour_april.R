require("RPostgreSQL")

pw <- {
  "y7dWwByZLWso"
}

drv <- dbDriver("PostgreSQL")

con_osm <- dbConnect(drv, dbname = "sensemycity",
                     host = "localhost", port = 15432,
                     user = "marciofontes", password = pw)

df_sessions_per_hour <- data.frame()

df_sessions_per_hour <- dbGetQuery(con_osm, "select extract(hour from to_timestamp(start_time)) AS hour, COUNT(DISTINCT session_id) AS sessions, CAST(COUNT(DISTINCT session_id) AS DECIMAL)/30 AS num_sessions
FROM marciofontes.session_users
                                   WHERE to_timestamp(start_time) BETWEEN '2016-04-01' AND '2016-04-30'
                                   GROUP BY hour
                                   ORDER BY hour")

df_sessions_per_hour_smc <- dbGetQuery(con_osm, "select extract(hour from to_timestamp(start_time)) AS hour, COUNT(DISTINCT session_id) AS sessions, CAST(COUNT(DISTINCT session_id) AS DECIMAL)/30 AS num_sessions
FROM marciofontes.session_users
                                   WHERE to_timestamp(start_time) BETWEEN '2016-04-01' AND '2016-04-30'
AND data_src = 'smc'
                                   GROUP BY hour
                                   ORDER BY hour")

df_sessions_per_hour_smm <- dbGetQuery(con_osm, "select extract(hour from to_timestamp(start_time)) AS hour, COUNT(DISTINCT session_id) AS sessions, CAST(COUNT(DISTINCT session_id) AS DECIMAL)/30 AS num_sessions
FROM marciofontes.session_users
                                   WHERE to_timestamp(start_time) BETWEEN '2016-04-01' AND '2016-04-30'
AND data_src = 'smm'
                                   GROUP BY hour
                                   ORDER BY hour")

df_sessions_per_hour_smf <- dbGetQuery(con_osm, "select extract(hour from to_timestamp(start_time)) AS hour, COUNT(DISTINCT session_id) AS sessions, CAST(COUNT(DISTINCT session_id) AS DECIMAL)/30 AS num_sessions
FROM marciofontes.session_users
                                   WHERE to_timestamp(start_time) BETWEEN '2016-04-01' AND '2016-04-30'
AND data_src = 'smf'
                                   GROUP BY hour
                                   ORDER BY hour")

plot(x=df_sessions_per_hour$hour, y=df_sessions_per_hour$num_sessions, type="o", main = "Sessions Per Hour", xlab = "Hour of the Day", ylab = "Sessions", ylim=c(0, max(df_sessions_per_hour$num_sessions) + 5))
axis(side=1, at=c(0:23))

lines(x=df_sessions_per_hour_smc$hour, y=df_sessions_per_hour_smc$num_sessions, type="o", col="blue")
axis(side=1, at=c(0:23))

lines(x=df_sessions_per_hour_smm$hour, y=df_sessions_per_hour_smm$num_sessions, type="o", col="red")
axis(side=1, at=c(0:23))

lines(x=df_sessions_per_hour_smf$hour, y=df_sessions_per_hour_smf$num_sessions, type="o", col="green")
axis(side=1, at=c(0:23))

legend(x=0, y=30, c("Total", "SenseMyCity", "SenseMyMood", "SenseMyFEUP"), lty=c(1,1,1,1),lwd=c(2.5,2.5,2.5,2.5),col=c("black", "blue", "red", "green"))

