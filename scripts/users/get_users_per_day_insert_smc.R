require("RPostgreSQL")

pw <- {
  "y7dWwByZLWso"
}

drv <- dbDriver("PostgreSQL")

con_osm <- dbConnect(drv, dbname = "sensemycity",
                     host = "localhost", port = 15432,
                     user = "marciofontes", password = pw)

df_users_per_day_smf <- data.frame()

dbGetQuery(con_osm, "INSERT INTO marciofontes.session_users 
                        (SELECT public.view_session.* FROM public.view_session, marciofontes.osmlocation_porto
                         WHERE public.view_session.session_id = marciofontes.osmlocation_porto.session_id)")


