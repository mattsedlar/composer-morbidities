dat = read.csv("data/composer-maladies.csv", colClasses = c("NULL","factor","factor"))

library(data.table)
library(ggplot2)
library(vcd)
library(plotly)

dat = data.table(dat)

dat[,`freq` := .N, by=maladies]

colnames(dat) = c("Composer","Malady","freq")

ggplot(dat, aes(x=Composer,y=Malady)) + geom_tile(aes(fill=freq)) +
  labs(x="Composers",y="Morbidities") +
  ggtitle("Most-Common Maladies by Classical Composers") +
  scale_fill_gradient(low="pink",high="#6A2022", name="Frequency") +
  theme(panel.background=element_blank(),
        panel.grid=element_blank(),
        axis.text.x=element_text(angle=90,size=7,hjust=0),
        axis.text.y=element_text(size=7,hjust=0),
        axis.title.x=element_text(size=8,family = "Helvetica"),
        axis.title.y=element_text(size=8,family = "Helvetica"),        
        legend.title=element_text(size=8),
        legend.text=element_text(size=7),
        plot.title=element_text(size=15, family = "Helvetica", face="bold"))

g = ggplotly(tooltip=c("x","y"))

plotly_POST(g, "Most-Common Morbidities by Classical Composer")
