load("df_points_per_edge_day.Rda")

summary(df_points_per_edge_day$points)

boxplot(df_points_per_edge_day$points, main = "Points per Edge (Day)", ylab = "Points")
boxplot(df_points_per_edge_day$points, main = "Points per Edge (Day)", ylab = "Points", boxwex = 0.3, ylim = c(0, 2000))

P <- ecdf(df_points_per_edge_day$points)

plot(P, main = "ECDF - Points per Edge (Day)", log = "x", xlab = "Points", xlim = c(1, max(df_points_per_edge_day$points)))