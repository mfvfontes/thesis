require("RPostgreSQL")

pw <- {
  "y7dWwByZLWso"
}

drv <- dbDriver("PostgreSQL")

con_osm <- dbConnect(drv, dbname = "sensemycity",
                     host = "localhost", port = 15432,
                     user = "marciofontes", password = pw)

df_points_per_hour <- data.frame()

df_points_per_hour <- dbGetQuery(con_osm, "SELECT extract(hour from to_timestamp(seconds)) AS hour, COUNT(*) AS points, CAST(COUNT(*) AS DECIMAL)/30 AS num_points
                                           FROM marciofontes.osmlocation
                                           WHERE to_timestamp(seconds) BETWEEN '2016-04-01' AND '2016-04-30'
                                           GROUP BY hour
                                           ORDER BY hour")

df_points_per_hour_smc <- dbGetQuery(con_osm, "SELECT extract(hour from to_timestamp(seconds)) AS hour, COUNT(DISTINCT *) AS sessions, CAST(COUNT(*) AS DECIMAL)/30 AS num_points
                                               FROM marciofontes.osmlocation
                                               WHERE to_timestamp(seconds) BETWEEN '2016-04-01' AND '2016-04-30'
                                               AND data_src = 'smc'
                                               GROUP BY hour
                                               ORDER BY hour")

df_points_per_hour_smm <- dbGetQuery(con_osm, "SELECT extract(hour from to_timestamp(seconds)) AS hour, COUNT(*) AS points, CAST(COUNT(*) AS DECIMAL)/30 AS num_points
                                               FROM marciofontes.osmlocation
                                               WHERE to_timestamp(seconds) BETWEEN '2016-04-01' AND '2016-04-30'
                                               AND data_src = 'smm'
                                               GROUP BY hour
                                               ORDER BY hour")

df_points_per_hour_smf <- dbGetQuery(con_osm, "SELECT extract(hour from to_timestamp(seconds)) AS hour, COUNT(*) AS points, CAST(COUNT(*) AS DECIMAL)/30 AS num_points
                                               FROM marciofontes.osmlocation
                                               WHERE to_timestamp(seconds) BETWEEN '2016-04-01' AND '2016-04-30'
                                               AND data_src = 'smf'
                                               GROUP BY hour
                                               ORDER BY hour")

plot(x=df_points_per_hour$hour, y=df_points_per_hour$num_points, type="o", main = "Points Per Hour (April)", xlab = "Hour of the Day", ylab = "Points", ylim=c(-100, max(df_points_per_hour$num_points) + 2000))
axis(side=1, at=c(0:23))

lines(x=df_points_per_hour_smc$hour, y=df_points_per_hour_smc$num_points, type="o", col="blue")
axis(side=1, at=c(0:23))

lines(x=df_points_per_hour_smm$hour, y=df_points_per_hour_smm$num_points, type="o", col="red")
axis(side=1, at=c(0:23))

lines(x=df_points_per_hour_smf$hour, y=df_points_per_hour_smf$num_points, type="o", col="green")
axis(side=1, at=c(0:23))

legend(x=0, y=4000, c("Total", "SenseMyCity", "SenseMyMood", "SenseMyFEUP"), lty=c(1,1,1,1),lwd=c(2.5,2.5,2.5,2.5),col=c("black", "blue", "red", "green"))