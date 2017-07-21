library(dplyr)
library(data.table)

setwd('E:/patent')
df <- read.csv("all_patent/grant_application.csv", stringsAsFactors = F)
pid <- read.csv('veh_pid_date.csv', stringsAsFactors = F)

df <- df[,c(2,6)]
pid <-as.data.frame(pid[,1])
names(pid) <- 'patent_id'

df.dt <- data.table(df, key="patent_id")
rm(df)

pid.dt <- data.table(pid, key="patent_id")
rm(pid)

date.dt <- merge(pid.dt, df.dt, all.x=T, all.y=F)
sum(is.na(date.dt[,2]))
sum(is.na(date.dt[,1]))

write.csv(date.dt,'veh_pid_date2.csv',row.names = F)
