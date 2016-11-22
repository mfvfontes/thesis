load("df_sessions_per_edge.Rda")

# Number of Edges: 2819

P = ecdf(df_sessions_per_edge$sessions)

plot(P, xlab = "Sessions", main = "ECDF - Sessions Per Edge (Porto)", log = "x", xlim = c(1, max(df_sessions_per_edge$sessions)))

boxplot(df_sessions_per_edge$sessions, ylab = "Sessions", main = "Sessions per Edge")
boxplot(df_sessions_per_edge$sessions, ylab = "Sessions", main = "Sessions per Edge", ylim = c(0, 50.0), boxwex = 0.3)

summary(df_sessions_per_edge$sessions)
