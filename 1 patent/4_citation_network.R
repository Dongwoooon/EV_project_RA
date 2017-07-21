install.packages(igraph)
library(igraph)
library(data.table)
library(dplyr)

setwd('E:/patent/citation')
# practice
cit.data<-read.csv("test.csv",header=T)
cit.net <- graph.data.frame(cit.data)
cit.net <- graph.data.frame(cit.data, directed=F)

plot(cit.net)
forward <- degree(cit.net,mode="out")
backward <- degree(cit.net,mode="in")
deg=cbind(forward,backward)
write.csv(deg,'veh_citation_degree.csv')

bon.cent <- power_centrality(cit.net)
eig.cent <- eigen_centrality(cit.net,directed=T)$vector
cent=cbind(bon.cent,eig.cent)
write.csv(cent,'veh_citation_centrality.csv')

prank <- page_rank(cit.net,directed=T)$vector
sum(prank)

### real
# deg centrality (forward, backward)
cit.data<-read.csv("veh_citation_network.csv",stringsAsFactors = F)
cit.net <- graph.data.frame(cit.data)
rm(cit.data)
forward <- degree(cit.net,mode="out")
backward <- degree(cit.net,mode="in")
deg=cbind(forward,backward)
write.csv(deg,'veh_citation_degree.csv')
rm(deg,forward,backward)

# eig centrality - useless...
eig.cent <- eigen_centrality(cit.net,directed=T)$vector
rm(cit.net)

# bon centrality - fail to calculate
cit.data<-read.csv("veh_citation_network.csv",header=T)
cit.net <- graph.data.frame(cit.data, directed=F)
rm(cit.data)
bon.cent <- power_centrality(cit.net)
rm(cit.net)

cent=cbind(bon.cent,eig.cent)
write.csv(cent,'veh_citation_centrality.csv')

### merge
pid <- read.csv('E:/patent/veh_pid_assignee.csv',stringsAsFactors = F)
deg <- read.csv('veh_citation_degree.csv')

names(deg) <- c('patent_id','forward','backward')

pid$patent_id <- as.character(pid$patent_id)
deg$patent_id <- as.character(deg$patent_id)

md <- left_join(pid, deg, by='patent_id')
md1 <- md[c(2,3,1,4:6)]
write.csv(md1,'veh_pid_assignee_deg.csv',row.names = F)
