load("df_inter_session.Rda")

par(mfrow = c(1,1))

df_inter_session[1:10, ]

boxplot(df_inter_session$avg, main = "Inter-Session Time (Seconds)", ylim = c(0, 150000))

df_inter_session$avg <- df_inter_session$avg/3600

boxplot(df_inter_session$avg, main = "Inter-Session Time (Hours)", ylim = c(0, 35))

P <- ecdf(df_inter_session$avg)

#for two percent...
#P2 <- ecdf(df_inter_session[1:38, ]$avg) 

plot(P, main = "ECDF - Inter-Session Time (Hours)", log = "x", xlab = "Hours", xlim = c(1, max(df_inter_session$avg)))
#plot(P, main = "ECDF - Inter-Session Time (Hours)", log = "x", xlab = "Hours", xlim = c(1, 10), ylim = c(0, 0.1))
#plot(P2, main = "ECDF - Inter-Session Time (Hours)", xlim = c(0, max(df_inter_session[1:19, ]$avg)))
