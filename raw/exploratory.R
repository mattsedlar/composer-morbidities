dat = read.csv("data/composer-maladies.csv", colClasses = c("NULL","factor","factor"))

library(data.table)
library(ggplot2)
library(plotly)

Sys.setenv("plotly_username"="mattsedlar")
Sys.setenv("plotly_api_key"="5xgnmswdaw")

dat = data.table(dat)

dat[,`freq` := .N, by=maladies]

colnames(dat) = c("Composer","Morbidity","freq")

ggplot(dat, aes(x=Composer,y=Morbidity)) + geom_tile(aes(fill=freq)) +
  labs(x="Composers",y="Morbidities") +
  ggtitle("Most-Common Morbidities by Classical Composers") +
  scale_fill_gradient(low="pink",high="red", name="Frequency") +
  theme(panel.background=element_rect(color="#FF4C51"),
        panel.grid=element_blank(),
        panel.border=element_rect(fill=NA,color="#FFFFFF"),
        axis.text.x=element_text(angle=90,size=7),
        axis.text.y=element_text(size=7),
        axis.title.x=element_text(size=8,family = "Helvetica"),
        axis.title.y=element_text(size=8,family = "Helvetica"),        
        legend.title=element_text(size=8),
        legend.text=element_text(size=7),
        plot.title=element_text(size=15, family = "Helvetica", face="bold"))

g = ggplotly(tooltip=c("x","y"),width="700",height=750)

plotly_POST(g, "Most-Common Morbidities by Classical Composer")
