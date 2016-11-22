load("df_points_per_edge.Rda")

# Number of Edges: 2819

P = ecdf(df_points_per_edge$points)

plot(P, xlab = "Points", main = "ECDF - Points Per Edge (Porto)", log = "x", xlim = c(1, max(df_points_per_edge$points)), col = "green")

boxplot(df_points_per_edge$points, ylab = "Points", main = "Points per Edge")
boxplot(df_points_per_edge$points, ylab = "Points", main = "Points per Edge", ylim = c(0, 700), boxwex = 0.3)

summary(df_points_per_edge$points)
