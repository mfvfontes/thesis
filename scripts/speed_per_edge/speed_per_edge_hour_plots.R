load("df_speed_per_edge_hour.Rda")
load("/Users/marciofontes/df_inter_session.Rda")

df_inter_session_top1percent <- df_inter_session[1:19, ]

df_merged <- merge(df_speed_per_edge_hour, df_inter_session_top1percent, by="way_id")

df_merged <- df_merged[order(df_merged$way_id, df_merged$hour), ]

df_merged

par(mfrow=c(1,1))

plot(x = df_merged$hour, y = df_merged$speed, type = "o", ylim = c(0, 100))

# par(mfrow=c(2,2))
# 
# for(wid in df_inter_session_top1percent[1:19, 1]) {
#   
#   df_merged_way_id <- subset(df_merged, way_id == wid)
#   
#   print(df_merged_way_id)
#   
#   df_merged_way_id <- df_merged_way_id[order(df_merged_way_id$hour), ]
#   
#   plot(x = df_merged_way_id$hour, y = df_merged_way_id$speed, main = wid, type="o", xlab = "Hour", ylab = "Speed (Km/h)")  
#   
# }
