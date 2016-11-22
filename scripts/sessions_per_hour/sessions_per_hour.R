load("df_sessions_per_hour.Rda")
load("df_sessions_per_hour_smc.Rda")
load("df_sessions_per_hour_smm.Rda")
load("df_sessions_per_hour_smf.Rda")

df_sessions_per_hour
df_sessions_per_hour_smc
df_sessions_per_hour_smm
df_sessions_per_hour_smf

plot(x=df_sessions_per_hour$hour_session, y=df_sessions_per_hour$num_sessions, type="o", main = "Sessions Per Hour", xlab = "Hour of the Day", ylab = "Sessions", ylim=c(0, max(df_sessions_per_hour$num_sessions) + 5))
axis(side=1, at=c(0:23))

lines(x=df_sessions_per_hour_smc$hour_session, y=df_sessions_per_hour_smc$num_sessions, type="o", col="blue")
axis(side=1, at=c(0:23))

lines(x=df_sessions_per_hour_smm$hour_session, y=df_sessions_per_hour_smm$num_sessions, type="o", col="red")
axis(side=1, at=c(0:23))

lines(x=df_sessions_per_hour_smf$hour_session, y=df_sessions_per_hour_smf$num_sessions, type="o", col="green")
axis(side=1, at=c(0:23))

legend(x=0, y=9, c("Total", "SenseMyCity", "SenseMyMood", "SenseMyFEUP"), lty=c(1,1,1,1),lwd=c(2.5,2.5,2.5,2.5),col=c("black", "blue", "red", "green"))

