load("df_points_per_hour.Rda")
load("df_points_per_hour_smc.Rda")
load("df_points_per_hour_smm.Rda")
load("df_points_per_hour_smf.Rda")

df_points_per_hour
df_points_per_hour_smc
df_points_per_hour_smm
df_points_per_hour_smf

plot(x=df_points_per_hour$hour_points, y=df_points_per_hour$num_points, type="o", main = "Points Per Hour", xlab = "Hour of the Day", ylab = "Points", ylim=c(-100, max(df_points_per_hour$num_points) + 2000))
axis(side=1, at=c(0:23))

lines(x=df_points_per_hour_smc$hour_points, y=df_points_per_hour_smc$num_points, type="o", col="blue")
axis(side=1, at=c(0:23))

lines(x=df_points_per_hour_smm$hour_points, y=df_points_per_hour_smm$num_points, type="o", col="red")
axis(side=1, at=c(0:23))

lines(x=df_points_per_hour_smf$hour_points, y=df_points_per_hour_smf$num_points, type="o", col="green")
axis(side=1, at=c(0:23))

legend(x=0, y=4000, c("Total", "SenseMyCity", "SenseMyMood", "SenseMyFEUP"), lty=c(1,1,1,1),lwd=c(2.5,2.5,2.5,2.5),col=c("black", "blue", "red", "green"))

