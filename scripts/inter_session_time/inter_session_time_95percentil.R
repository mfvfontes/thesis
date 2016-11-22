require("RPostgreSQL")

pw <- {
  "y7dWwByZLWso"
}

drv <- dbDriver("PostgreSQL")

con <- dbConnect(drv, dbname = "sensemycity",
                 host = "localhost", port = 15432,
                 user = "marciofontes", password = pw)

df_inter_session_way_id <- data.frame()

list_way_ids <- df_inter_session[1:19, 1]

counter <- 1

set.seed(42)

#c1 <- rainbow(19)

rdm_colors <- c()

for(way_id in list_way_ids) {
  
  rdm_color_vec <- runif(3, 0.0, 1.0)
  rdm_color <- rgb(rdm_color_vec[1], rdm_color_vec[2], rdm_color_vec[3])
  rdm_colors <- c(rdm_colors, rdm_color)
  
  print(way_id)
  
  df_inter_session_way_id <- dbGetQuery(con, paste0("SELECT way_id, nextSeconds - seconds AS diff
                                                    FROM next_sessions
                                                    WHERE to_timestamp(seconds) BETWEEN '2016-04-01' AND '2016-04-30'
                                                    AND way_id = ", way_id))
  
  P <- ecdf(df_inter_session_way_id$diff/60)
  
  if(counter == 1) {
    plot(P, main = "IST (Top 1%) - 95% percentil", xlab = "Minutes", log = "x", col = rdm_color, xlim = c(1, max(df_inter_session_way_id$diff/60)), ylim = c(0.95, 1.0))
    counter <- counter + 1
  } else {
    plot(P, main = "IST (Top 1%) - 95% percentil", xlab = "Minutes", col=rdm_color, add=TRUE, xlim = c(1, max(df_inter_session_way_id$diff/60)), ylim = c(0.95, 1.0))
    counter <- counter + 1
  }
  
}
