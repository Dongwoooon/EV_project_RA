library(dplyr)
library(data.table)
library(lubridate)

setwd('E:/patent')
date <- read.csv('veh_pid_date.csv', stringsAsFactors = F)
date$year <- year(ymd(date$date))
date <- data.table(date, key="patent_id")

deg <- read.csv("citation/veh_citation_degree.csv", stringsAsFactors = F)
deg$patent_id <- as.character(deg$patent_id)
deg <- data.table(deg, key="patent_id")

date_deg <- merge(date, deg, all.x=T, all.y=F)
sum(is.na(date_deg$backward) | is.na(date_deg$date))
rm(date,deg)

ass <- read.csv('veh_pid_assignee.csv', stringsAsFactors = F)
ass <- ass[,c(1,2,4)]

ass_date_deg <- merge(ass, date_deg, all.x=T, all.y=F)

write.csv(date_deg,'veh_pid_date_deg.csv',row.names = F)
write.csv(ass_date_deg,'veh_pid_assignee_date_deg.csv',row.names = F)

######## missing assignee 존재!! ㅅㅂ 뭐야 이거
pid1 <- ass$patent_id
pid2 <- date_deg$patent_id
rm(ass,ass_date_deg,date_deg)
pid1 <- as.data.frame(pid1)
pid2 <- as.data.frame(pid2)

pid1$zero <- 0
pid1$pid1 <- as.character(pid1$pid1)
pid2$pid2 <- as.character(pid2$pid2)

pid1 <- unique(pid1)

pid <- merge(pid2, pid1, by.x='pid2', by.y='pid1', all.x=T, all.y=F)
missing <- pid[is.na(pid$zero),]
write.csv(missing,'missing_assignee.csv',row.names = F)

####### 다시 합치기
dd <- read.csv('veh_pid_date_deg.csv', stringsAsFactors = F)
dd <- data.table(dd, key="patent_id")

ass <- read.csv('pid_assignee.csv',quote = "", row.names = NULL, stringsAsFactors = F)
ass <- unique(ass)
pinfo <- merge(ass, dd, all.x=T, all.y=F)
write.csv(pinfo,'veh_pid_assignee_date_deg.csv',row.names = F)