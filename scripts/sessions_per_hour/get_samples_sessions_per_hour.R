require("RPostgreSQL")

pw <- {
  "y7dWwByZLWso"
}

drv <- dbDriver("PostgreSQL")

con_osm <- dbConnect(drv, dbname = "sensemycity",
                     host = "localhost", port = 15432,
                     user = "marciofontes", password = pw)

df_samples_sessions_per_hour <- data.frame()

df_samples_sessions_per_hour <- dbGetQuery(con_osm, "SELECT extract(hour from to_timestamp(start_time)) AS hour_session, 
                                                            COUNT(DISTINCT to_char(to_timestamp(start_time), 'YYYY-MM-DD')) AS num_samples
                                                     FROM marciofontes.session_users
                                                     GROUP BY hour_session
                                                     ORDER BY hour_session ASC")

df_samples_sessions_per_hour_smc <- dbGetQuery(con_osm, "SELECT extract(hour from to_timestamp(start_time)) AS hour_session, 
                                                                COUNT(DISTINCT to_char(to_timestamp(start_time), 'YYYY-MM-DD')) AS num_samples
                                                         FROM marciofontes.session_users
                                                         WHERE data_src = 'smc'
                                                         GROUP BY hour_session
                                                         ORDER BY hour_session ASC")

df_samples_sessions_per_hour_smm <- dbGetQuery(con_osm, "SELECT extract(hour from to_timestamp(start_time)) AS hour_session, 
                                                                COUNT(DISTINCT to_char(to_timestamp(start_time), 'YYYY-MM-DD')) AS num_samples
                                                         FROM marciofontes.session_users
                                                         WHERE data_src = 'smm'
                                                         GROUP BY hour_session
                                                         ORDER BY hour_session ASC")

df_samples_sessions_per_hour_smf <- dbGetQuery(con_osm, "SELECT extract(hour from to_timestamp(start_time)) AS hour_session, 
                                                                COUNT(DISTINCT to_char(to_timestamp(start_time), 'YYYY-MM-DD')) AS num_samples
                                                         FROM marciofontes.session_users
                                                         WHERE data_src = 'smf'
                                                         GROUP BY hour_session
                                                         ORDER BY hour_session ASC")

save(df_samples_sessions_per_hour, file="df_samples_sessions_per_hour.Rda")
save(df_samples_sessions_per_hour_smc, file="df_samples_sessions_per_hour_smc.Rda")
save(df_samples_sessions_per_hour_smm, file="df_samples_sessions_per_hour_smm.Rda")
save(df_samples_sessions_per_hour_smf, file="df_samples_sessions_per_hour_smf.Rda")