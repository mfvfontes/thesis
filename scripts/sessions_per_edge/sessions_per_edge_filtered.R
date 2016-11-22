load("df_sessions_per_edge_filtered.Rda")

# Number of Edges: 2819

P = ecdf(df_sessions_per_edge_filtered$sessions)

#fun.ecdf <- ecdf(df_sessions_per_edge_filtered$sessions)

#my.ecdf <- fun.ecdf(sort(df_sessions_per_edge_filtered$sessions))

#my_ecdf_df <- data.frame(my.ecdf)

#my_ecdf_df$sessions <- sort(df_sessions_per_edge_filtered$sessions)

#tail(my_ecdf_df, 400)


#plot(P, xlab = "Sessions", main = "ECDF - Sessions Per Edge (Porto)", log = "x", xlim = c(1, max(df_sessions_per_edge_filtered$sessions)), col = "red")
#plot(P, xlab = "Sessions", main = "ECDF - Sessions Per Edge (Porto)", log = "x", xlim = c(1, max(df_sessions_per_edge_filtered$sessions)), col = "yellow")
plot(P, xlab = "Sessions", main = "ECDF - Sessions Per Edge (Porto)", log = "x", xlim = c(1, max(df_sessions_per_edge_filtered$sessions)), col = "green")
#plot(P, xlab = "Sessions", main = "ECDF - Sessions Per Edge (Porto)", log = "x", xlim = c(1, max(df_sessions_per_edge_filtered$sessions)))
#plot(P, xlab = "Sessions", main = "ECDF - Sessions Per Edge (Porto)", log = "x", xlim = c(1, max(df_sessions_per_edge_filtered$sessions)))

#abline(v = 146.0)
#abline(v = 56.0)

boxplot(df_sessions_per_edge_filtered$sessions, ylab = "Sessions", main = "Sessions per Edge")
boxplot(df_sessions_per_edge_filtered$sessions, ylab = "Sessions", main = "Sessions per Edge", ylim = c(0, 50.0), boxwex = 0.3)

summary(df_sessions_per_edge_filtered$sessions)
