require("RPostgreSQL")

load("df_inter_session.Rda")

pw <- {
  "y7dWwByZLWso"
}

drv <- dbDriver("PostgreSQL")

con <- dbConnect(drv, dbname = "sensemycity",
                 host = "localhost", port = 15432,
                 user = "marciofontes", password = pw)

df_inter_session_way_id <- data.frame()

list_way_ids <- df_inter_session[1:19, 1]

counter <- 0

set.seed(42)

rdm_colors <- c()

par(mfrow=c(2,2))

for(way_id in list_way_ids) {
  
  rdm_color_vec <- runif(3, 0.0, 1.0)
  rdm_color <- rgb(rdm_color_vec[1], rdm_color_vec[2], rdm_color_vec[3])
  rdm_colors <- c(rdm_colors, rdm_color)
  
  print(way_id)
  
  query <- paste0("SELECT nextSeconds, 
                          nextSeconds - seconds AS diff
                  FROM next_sessions
                  WHERE to_timestamp(seconds) BETWEEN '2016-04-01' AND '2016-04-30'
                  AND way_id = ", way_id)
  
  query <- paste0(query, " ORDER BY nextSeconds")
  
  df_inter_session_diff <- dbGetQuery(con, query)
  
  df_inter_session_diff$diff <- df_inter_session_diff$diff/60 
  
  plot_name <- paste0("IST Variations: Way_ID - ", way_id)
  
  date_names <- c("1/Apr", "7/Apr", "13/Apr", "19/Apr", "25/Apr", "30/Apr")
  
  plot(df_inter_session_diff, main = plot_name, type="o", xlab = "Day", xaxt="n", xlim = c(1459468800, 1462060799), ylab = "IST Difference", ylim = c(0, 12*60), col = rdm_color)
  axis(1, at=c(1459512000, 1460030400, 1460548800, 1461067200, 1461585600, 1462017600), labels=date_names)
  
  #boxplot(df_inter_session_diff$diff, main = plot_name, ylab = "IST Difference (Minutes)", ylim = c(0, 30+counter), boxwex = 0.5)
  
  counter <- counter + 15
  
}
