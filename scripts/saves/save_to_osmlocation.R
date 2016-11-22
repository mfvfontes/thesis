require("RPostgreSQL")

pw <- {
  "y7dWwByZLWso"
}

drv <- dbDriver("PostgreSQL")

con_smc <- dbConnect(drv, dbname = "sensemycity",
                     host = "localhost", port = 15432,
                     user = "marciofontes", password = pw)

df_sessions_edge_smc <- data.frame()

df_sessions_edge_smc <- dbGetQuery(con_smc, "INSERT INTO marciofontes.osmlocation (SELECT public.osmlocation.*, 'smc' AS data_src
                                           FROM public.osmlocation
                                           WHERE ST_Intersects(geo, (select  * FROM dblink('hostaddr=127.0.0.1
                                           dbname=openstreetmap user=marciofontes password=y7dWwByZLWso',
                                           'SELECT st_transform(way,4326) from planet_osm_polygon where osm_id
                                           = -3372453') as u(tembvh geometry))))")

df_sessions_edge_smm <- data.frame()

df_sessions_edge_smm <- dbGetQuery(con_smc, "INSERT INTO marciofontes.osmlocation_porto 
                                            (SELECT *, 'smm' AS data_src FROM 
                                   (SELECT * FROM dblink('hostaddr=127.0.0.1 dbname=moodsensor user=marciofontes password=y7dWwByZLWso',
                                   'SELECT * FROM osmlocation') as a(session_id integer, seconds integer, millis smallint, geo geography, lat double precision, lon double precision, err real, way_id bigint, node_src bigint, node_dst bigint)) A
                                   
                                   WHERE ST_Intersects(geo, (select  * FROM dblink('hostaddr=127.0.0.1
                                   dbname=openstreetmap user=marciofontes password=y7dWwByZLWso',
                                   'SELECT st_transform(way,4326) from planet_osm_polygon where osm_id
                                   = -3372453') as u(tembvh geometry))))")

df_sessions_edge_smf <- dbGetQuery(con_smc, "INSERT INTO marciofontes.osmlocation_porto 
                                            (SELECT *, 'smf' AS data_src FROM 
                                   (SELECT * FROM dblink('hostaddr=127.0.0.1 dbname=sensemyfeup user=marciofontes password=y7dWwByZLWso',
                                   'SELECT * FROM osmlocation') as a(session_id integer, seconds integer, millis smallint, geo geography, lat double precision, lon double precision, err real, way_id bigint, node_src bigint, node_dst bigint)) A
                                   
                                   WHERE ST_Intersects(geo, (select  * FROM dblink('hostaddr=127.0.0.1
                                   dbname=openstreetmap user=marciofontes password=y7dWwByZLWso',
                                   'SELECT st_transform(way,4326) from planet_osm_polygon where osm_id
                                   = -3372453') as u(tembvh geometry))))")
