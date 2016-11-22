require("RPostgreSQL")

pw <- {
  "y7dWwByZLWso"
}

drv <- dbDriver("PostgreSQL")

con_osm <- dbConnect(drv, dbname = "sensemycity",
                     host = "localhost", port = 15432,
                     user = "marciofontes", password = pw)

dbGetQuery(con_osm, "INSERT INTO marciofontes.session_users (SELECT A.*, 'smf' AS data_src
           FROM marciofontes.osmlocation, 
           (SELECT * FROM dblink('hostaddr=127.0.0.1 dbname=sensemyfeup user=marciofontes password=y7dWwByZLWso',
           'SELECT * FROM view_session') AS a(session_id integer, daily_user_id bigint, start_time integer, version smallint, hardware text, software text)) A
           WHERE marciofontes.osmlocation.session_id = A.session_id)")