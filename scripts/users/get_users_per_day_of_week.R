require("RPostgreSQL")

pw <- {
  "y7dWwByZLWso"
}

drv <- dbDriver("PostgreSQL")

con_osm <- dbConnect(drv, dbname = "sensemycity",
                     host = "localhost", port = 15432,
                     user = "marciofontes", password = pw)

df_users_per_dow <- data.frame()

df_users_per_dow <- dbGetQuery(con_osm, "SELECT extract(dow from to_timestamp(start_time)) AS dow, 
                                                CAST(COUNT(DISTINCT daily_user_id) AS DECIMAL)/COUNT(DISTINCT to_char(to_timestamp(start_time), 'YYYY-MM-DD')) AS num_users
                                          FROM session_users
                                          GROUP BY dow
                                          ORDER BY dow")

df_users_per_dow_smc <- dbGetQuery(con_osm, "SELECT extract(dow from to_timestamp(start_time)) AS dow, 
                                    CAST(COUNT(DISTINCT daily_user_id) AS DECIMAL)/COUNT(DISTINCT to_char(to_timestamp(start_time), 'YYYY-MM-DD')) AS num_users
                                    FROM session_users
                                    WHERE data_src = 'smc'
                                    GROUP BY dow
                                    ORDER BY dow")

df_users_per_dow_smm <- dbGetQuery(con_osm, "SELECT extract(dow from to_timestamp(start_time)) AS dow, 
                                    CAST(COUNT(DISTINCT daily_user_id) AS DECIMAL)/COUNT(DISTINCT to_char(to_timestamp(start_time), 'YYYY-MM-DD')) AS num_users
                                    FROM session_users
                                    WHERE data_src = 'smm'
                                    GROUP BY dow
                                    ORDER BY dow")

df_users_per_dow_smf <- dbGetQuery(con_osm, "SELECT extract(dow from to_timestamp(start_time)) AS dow, 
                                    CAST(COUNT(DISTINCT daily_user_id) AS DECIMAL)/COUNT(DISTINCT to_char(to_timestamp(start_time), 'YYYY-MM-DD')) AS num_users
                                    FROM session_users
                                    WHERE data_src = 'smf'
                                    GROUP BY dow
                                    ORDER BY dow")

save(df_users_per_dow, file="df_users_per_dow.Rda")
save(df_users_per_dow_smc, file="df_users_per_dow_smc.Rda")
save(df_users_per_dow_smm, file="df_users_per_dow_smm.Rda")
save(df_users_per_dow_smf, file="df_users_per_dow_smf.Rda")