require("RPostgreSQL")
library("zoom")

pw <- {
  "y7dWwByZLWso"
}

drv <- dbDriver("PostgreSQL")

con <- dbConnect(drv, dbname = "sensemycity",
                 host = "localhost", port = 15432,
                 user = "marciofontes", password = pw)

df_inter_session_diff <- data.frame()

counter <- 0

limits <- c()
names <- c()
day <- 1
hour <- 0

par(mfrow=c(2,1))

while(counter < 720) {
  value <- 1459468800 + counter*3600
  limits <- c(limits, value)
  counter <- counter + 1
  names <- c(names, paste0(paste0(paste0(day, "/Apr ("), hour), "h)"))
  if(hour == 23) {
    hour <- 0
    day <- day + 1 
  } else {
    hour <- hour + 1  
  }
  
}

list_way_ids <- df_inter_session[1:14, 1]

counter <- 0

for(way_id in list_way_ids) {
  
  rdm_color_vec <- runif(3, 0.0, 1.0)
  rdm_color <- rgb(rdm_color_vec[1], rdm_color_vec[2], rdm_color_vec[3])
  rdm_colors <- c(rdm_colors, rdm_color)
  
  df_inter_session_diff_1stweek <- dbGetQuery(con, paste0(paste0("SELECT extract(hour from to_timestamp(nextSeconds)) AS hour, 
                                                 extract(day from to_timestamp(nextSeconds)) AS day,
                                              nextSeconds,
                                              nextSeconds - seconds AS diff
                                              FROM next_sessions
                                              WHERE way_id = ", way_id), "AND to_timestamp(seconds) BETWEEN '2016-04-01' AND '2016-04-08' ORDER BY nextSeconds"))
  
  df_inter_session_diff_2ndweek <- dbGetQuery(con, paste0(paste0("SELECT extract(hour from to_timestamp(nextSeconds)) AS hour, 
                                                 extract(day from to_timestamp(nextSeconds)) AS day,
                                                                 nextSeconds,
                                                                 nextSeconds - seconds AS diff
                                                                 FROM next_sessions
                                                                 WHERE way_id = ", way_id), "AND to_timestamp(seconds) BETWEEN '2016-04-08' AND '2016-04-15'
                                              ORDER BY nextSeconds"))
  
  df_inter_session_diff_3rdweek <- dbGetQuery(con, paste0(paste0("SELECT extract(hour from to_timestamp(nextSeconds)) AS hour, 
                                                 extract(day from to_timestamp(nextSeconds)) AS day,
                                                                 nextSeconds,
                                                                 nextSeconds - seconds AS diff
                                                                 FROM next_sessions
                                                                 WHERE way_id = ", way_id), "AND to_timestamp(seconds) BETWEEN '2016-04-15' AND '2016-04-22'
                                              ORDER BY nextSeconds"))
  
  df_inter_session_diff_4thweek <- dbGetQuery(con, paste0(paste0("SELECT extract(hour from to_timestamp(nextSeconds)) AS hour, 
                                                 extract(day from to_timestamp(nextSeconds)) AS day,
                                                                 nextSeconds,
                                                                 nextSeconds - seconds AS diff
                                                                 FROM next_sessions
                                                                 WHERE way_id = ", way_id), "AND to_timestamp(seconds) BETWEEN '2016-04-22' AND '2016-04-29'
                                              ORDER BY nextSeconds"))
  
  df_inter_session_diff_5thweek <- dbGetQuery(con, paste0(paste0("SELECT extract(hour from to_timestamp(nextSeconds)) AS hour, 
                                                 extract(day from to_timestamp(nextSeconds)) AS day,
                                                                 nextSeconds,
                                                                 nextSeconds - seconds AS diff
                                                                 FROM next_sessions
                                                                 WHERE way_id = ", way_id), "AND to_timestamp(seconds) BETWEEN '2016-04-29' AND '2016-04-30'
                                              ORDER BY nextSeconds"))
  
  plot_name <- paste0("IST Variations (1st Week): Way_ID - ", way_id)
  
  png(paste0(paste0(way_id, "/"), paste0(way_id, "_part1.png")), width=2500, height = 1500)
  par(mfrow=c(2,1))
  
  plot(x = df_inter_session_diff_1stweek$nextseconds, y = df_inter_session_diff_1stweek$diff/60, main = plot_name, type="o", xlab = "Day (Hour)", xaxt="n", xlim = c(1459468800, limits[168]), ylab = "IST Difference", ylim = c(0, 12*60), col=rdm_color)
  axis(1, at=limits[1:168], labels=names[1:168])
  
  plot_name <- paste0("IST Variations (2nd Week): Way_ID - ", way_id)
  
  plot(x = df_inter_session_diff_2ndweek$nextseconds, y = df_inter_session_diff_2ndweek$diff/60, main = plot_name, type="o", xlab = "Day (Hour)", xaxt="n", xlim = c(limits[169], limits[336]), ylab = "IST Difference", ylim = c(0, 12*60), col=rdm_color)
  axis(1, at=limits[169:336], labels=names[169:336])
  
  dev.off()
  
  plot_name <- paste0("IST Variations (3rd Week): Way_ID - ", way_id)
  
  png(paste0(paste0(way_id, "/"), paste0(way_id, "_part2.png")), width=2500, height = 1500)
  par(mfrow=c(2,1))
  
  plot(x = df_inter_session_diff_3rdweek$nextseconds, y = df_inter_session_diff_3rdweek$diff/60, main = plot_name, type="o", xlab = "Day (Hour)", xaxt="n", xlim = c(limits[337], limits[504]), ylab = "IST Difference", ylim = c(0, 12*60), col=rdm_color)
  axis(1, at=limits[337:504], labels=names[337:504])
  
  plot_name <- paste0("IST Variations (4th Week): Way_ID - ", way_id)
  
  plot(x = df_inter_session_diff_4thweek$nextseconds, y = df_inter_session_diff_4thweek$diff/60, main = plot_name, type="o", xlab = "Day (Hour)", xaxt="n", xlim = c(limits[505], limits[672]), ylab = "IST Difference", ylim = c(0, 12*60), col=rdm_color)
  axis(1, at=limits[505:672], labels=names[505:672])
  
  dev.off()
  
  plot_name <- paste0("IST Variations (5th Week): Way_ID - ", way_id)
  
  png(paste0(paste0(way_id, "/"), paste0(way_id, "_part3.png")), width=2500, height = 1500)
  par(mfrow=c(1,1))
  
  plot(x = df_inter_session_diff_5thweek$nextseconds, y = df_inter_session_diff_5thweek$diff/60, main = plot_name, type="o", xlab = "Day (Hour)", xaxt="n", xlim = c(limits[673], limits[720]), ylab = "IST Difference", ylim = c(0, 12*60), col=rdm_color)
  axis(1, at=limits[673:720], labels=names[673:720])
  
  dev.off()
}


