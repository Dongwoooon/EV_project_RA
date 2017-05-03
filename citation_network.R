install.packages(igraph)
library(igraph)

setwd('E:/patent/citation')
# practice
cit.data<-read.csv("test.csv",header=T)
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

# real
cit.data<-read.csv("veh_citation_network.csv",header=T)
cit.net <- graph.data.frame(cit.data)
rm(cit.data)
forward <- degree(cit.net,mode="out")
backward <- degree(cit.net,mode="in")
deg=cbind(forward,backward)
write.csv(deg,'veh_citation_degree.csv')
rm(deg,forward,backward)

eig.cent <- eigen_centrality(cit.net,directed=T)$vector
rm(cit.net)
cit.data<-read.csv("veh_citation_network.csv",header=T)
cit.net <- graph.data.frame(cit.data, directed=F)
rm(cit.data)
bon.cent <- power_centrality(cit.net)
rm(cit.net)

cent=cbind(bon.cent,eig.cent)
write.csv(cent,'veh_citation_centrality.csv')
