load("df_errors.Rda")

plot(df_errors$avg, df_errors$std, xlim=c(0, 20000), ylim=c(0, 15000))

df_errors_sorted <- df_errors[order(-df_errors$avg, -df_errors$std), ]

df_errors_sorted[1:10, ]

df_errors_sorted$ratio <- df_errors_sorted$std / df_errors_sorted$avg

df_errors_sorted

#df_errors_sorted_min <- subset(df_errors_sorted, avg < 50)

df_errors_sorted_others <- subset(df_errors_sorted, avg >= 50)

#df_errors_sorted_others <- df_errors_sorted_others[order(-df_errors_sorted_min$std / df_errors_sorted_min$avg), ]

#df_errors_sorted_min <- df_errors_sorted_min[order(-df_errors_sorted_min$std / df_errors_sorted_min$avg), ]

P <- ecdf(df_errors_sorted_others$ratio)



plot(P, , log="x", xlim = c(10e-3, 1e03))

#length(df_errors_sorted_min$session_id)

#f_errors_sorted_min[1:100, ]