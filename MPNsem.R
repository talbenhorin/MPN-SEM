rm(list=ls(all=TRUE))
set.seed(1234)
MPN <- read.csv("oysterMPN.csv", fill = FALSE, header = TRUE) 
# install.packages("lavaan", dependencies = TRUE)
# install.packages("semPlot", dependencies = TRUE)

library(lavaan)

oyster.df <- data.frame(chlo = MPN$chlo,temp = MPN$s.temp,
                        sal = MPN$s.sal, water = MPN$water.log.tlh,
                        oyster = MPN$log.tlh)

model <- 'oyster ~ temp + sal + chlo + water
          water ~ temp + sal + chlo
'

path.fit <- sem(model,
                meanstructure=T,
                data=oyster.df)
summary(path.fit)
semPlot::semPaths(path.fit,"reg",intercepts = FALSE)
