load("df_users_per_dow.Rda")
load("df_users_per_dow_smc.Rda")
load("df_users_per_dow_smm.Rda")
load("df_users_per_dow_smf.Rda")

df_users_per_dow$dow_name <- c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
df_users_per_dow_smc$dow_name <- c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
df_users_per_dow_smm$dow_name <- c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
df_users_per_dow_smf$dow_name <- c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")

df_users_per_dow

plot(x=df_users_per_dow$dow,xaxt = "n", y=df_users_per_dow$num_users, type="o", main = "Users Per Day of Week", xlab = "Day of Week", ylab = "Users", ylim=c(0, max(df_users_per_dow$num_users)+27))
axis(side=1, at=c(0:6), labels=df_users_per_dow[1:7, 3])

lines(x=df_users_per_dow_smc$dow, y=df_users_per_dow_smc$num_users, type="o", col="blue")
axis(side=1, at=c(0:6), labels=df_users_per_dow[1:7, 3])

lines(x=df_users_per_dow_smm$dow, y=df_users_per_dow_smm$num_users, type="o", col="red")
axis(side=1, at=c(0:6), labels=df_users_per_dow[1:7, 3])

lines(x=df_users_per_dow_smf$dow, y=df_users_per_dow_smf$num_users, type="o", col="green")
axis(side=1, at=c(0:6), labels=df_users_per_dow[1:7, 3])

legend(x=0, y=34, c("Total", "SenseMyCity", "SenseMyMood", "SenseMyFEUP"), lty=c(1,1,1,1),lwd=c(2.5,2.5,2.5,2.5),col=c("black", "blue", "red", "green"))