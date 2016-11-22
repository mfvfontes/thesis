load("df_users_per_hour.Rda")
load("df_users_per_hour_smc.Rda")
load("df_users_per_hour_smm.Rda")
load("df_users_per_hour_smf.Rda")

plot(x=df_users_per_hour$hour, y=df_users_per_hour$num_users, type="o", main = "Users Per Hour", xlab = "Hour of the Day", ylab = "Users", ylim=c(0, max(df_users_per_hour$num_users)+5))
axis(side=1, at=c(1:31))

lines(x=df_users_per_hour_smc$hour, y=df_users_per_hour_smc$num_users, type="o", col="blue")
axis(side=1, at=c(1:31))

lines(x=df_users_per_hour_smm$hour, y=df_users_per_hour_smm$num_users, type="o", col="red")
axis(side=1, at=c(1:31))

lines(x=df_users_per_hour_smf$hour, y=df_users_per_hour_smf$num_users, type="o", col="green")
axis(side=1, at=c(1:31))

legend(x=0, y=7, c("Total", "SenseMyCity", "SenseMyMood", "SenseMyFEUP"), lty=c(1,1,1,1),lwd=c(2.5,2.5,2.5,2.5),col=c("black", "blue", "red", "green"))