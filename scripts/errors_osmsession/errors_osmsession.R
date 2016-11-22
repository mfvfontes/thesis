require("RPostgreSQL")

pw <- {
  "y7dWwByZLWso"
}

drv <- dbDriver("PostgreSQL")

con <- dbConnect(drv, dbname = "sensemycity",
                 host = "localhost", port = 15432,
                 user = "marciofontes", password = pw)

df_err <- data.frame()

con2 <- dbConnect(drv, dbname = "moodsensor",
                 host = "localhost", port = 15432,
                 user = "marciofontes", password = pw)

con3 <- dbConnect(drv, dbname = "sensemyfeup",
                 host = "localhost", port = 15432,
                 user = "marciofontes", password = pw)

df_err <- dbGetQuery(con, "SELECT meanerr FROM osmsession")
df_err2 <- dbGetQuery(con2, "SELECT meanerr FROM osmsession")
df_err3 <- dbGetQuery(con3, "SELECT meanerr FROM osmsession")

df_err4 <- dbGetQuery(con, "SELECT DISTINCT(osmsession.session_id), osmsession.meanerr
                            FROM osmsession, marciofontes.osmlocation
                            WHERE osmsession.session_id = marciofontes.osmlocation.session_id")
df_err5 <- dbGetQuery(con, "SELECT DISTINCT(marciofontes.osmlocation.session_id), meanerr 
                            FROM marciofontes.osmlocation, 
                                 (SELECT * FROM dblink('hostaddr=127.0.0.1 dbname=moodsensor user=marciofontes password=y7dWwByZLWso', 
                                                       'SELECT session_id, meanerr FROM osmsession') AS a(session_id integer, meanerr real)) A
                            WHERE marciofontes.osmlocation.session_id = A.session_id")
df_err6 <- dbGetQuery(con, "SELECT DISTINCT(marciofontes.osmlocation.session_id), meanerr 
                            FROM marciofontes.osmlocation, 
                                 (SELECT * FROM dblink('hostaddr=127.0.0.1 dbname=sensemyfeup user=marciofontes password=y7dWwByZLWso', 
                                                       'SELECT session_id, meanerr FROM osmsession') AS a(session_id integer, meanerr real)) A
                            WHERE marciofontes.osmlocation.session_id = A.session_id")

#boxplot(df_err, ylim=c(0, 100), boxwex=0.3, main="SMC")
#boxplot(df_err2, ylim=c(0, 100), boxwex=0.3, main="SMM")
#boxplot(df_err3, ylim=c(0, 100), boxwex=0.3, main="SMF")

#df_err4

P <- ecdf(df_err$meanerr)
P2 <- ecdf(df_err2$meanerr)
P3 <- ecdf(df_err3$meanerr)

P4 <- ecdf(df_err4$meanerr)
P5 <- ecdf(df_err5$meanerr)
P6 <- ecdf(df_err6$meanerr)

#plot(P, main = "SenseMyCity Sessions Mean Errors", xlab = "Mean Error", log = "x", xlim = c(1.0, max(df_err$meanerr)))
#plot(P2, main = "SenseMyMood Sessions Mean Errors", xlab = "Mean Error", log = "x", xlim = c(1, max(df_err2$meanerr)))
#plot(P3, main = "SenseMyFEUP Sessions Mean Errors", xlab = "Mean Error", log = "x", xlim = c(1, max(df_err3$meanerr)))

plot(P4, main = "SenseMyCity Sessions Mean Errors", xlab = "Mean Error", log = "x", xlim = c(1, max(df_err4$meanerr)))
plot(P5, main = "SenseMyMood Sessions Mean Errors", xlab = "Mean Error", log = "x", xlim = c(1, max(df_err5$meanerr)))
plot(P6, main = "SenseMyFEUP Sessions Mean Errors", xlab = "Mean Error", log = "x", xlim = c(1, max(df_err6$meanerr)))

boxplot(df_err4$meanerr, ylim=c(0, 100), boxwex=0.3, main="SenseMyCity Sessions Mean Errors")
boxplot(df_err5$meanerr, ylim=c(0, 100), boxwex=0.3, main="SenseMyMood Sessions Mean Errors")
boxplot(df_err6$meanerr, ylim=c(0, 100), boxwex=0.3, main="SenseMyFEUP Sessions Mean Errors")