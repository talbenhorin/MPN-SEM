rm(list=ls(all=TRUE))
set.seed(1234)
MPN <- read.csv("oysterMPN.csv", fill = FALSE, header = TRUE) 
# install.packages("lavaan", dependencies = TRUE)
# install.packages("semPlot", dependencies = TRUE)

library(lavaan)

oyster.df <- data.frame(chlo = MPN$chlo,temp = MPN$s.temp,
                        sal = MPN$s.sal, water = MPN$water.log.pilf,
                        oyster = MPN$log.pilf)

model <- 'oyster ~ temp + sal + chlo + water
          water ~ temp + sal + chlo
'

path.fit <- sem(model,
                meanstructure=T,
                data=oyster.df)
summary(path.fit)
semPlot::semPaths(path.fit,what = "std",
                  whatLabels = "std",
                  layout = "tree3",
                  curvature = 2,
                  intercepts = FALSE,
                  nCharNodes = 0,
                  edge.label.cex = 0.8,
                  residuals = FALSE,
                  pastel = TRUE,
                  fade = TRUE,
                  cardinal = FALSE,
                  centerLevels = TRUE)
