load("df_points_per_edge_night.Rda")

summary(df_points_per_edge_night$points)

boxplot(df_points_per_edge_night$points, main = "Points per Edge (Night)", ylab = "Points")
boxplot(df_points_per_edge_night$points, main = "Points per Edge (Night)", ylab = "Points", boxwex = 0.3, ylim = c(0, 650))

P <- ecdf(df_points_per_edge_night$points)

plot(P, main = "ECDF - Points per Edge (Night)", log = "x", xlab = "Points", xlim = c(1, max(df_points_per_edge_night$points)))