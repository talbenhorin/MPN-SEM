rm(list=ls(all=TRUE))
set.seed(1234)
MPN <- read.csv("oysterMPN.csv", fill = FALSE, header = TRUE) 
# install.packages("lavaan", dependencies = TRUE)
# install.packages("semPlot", dependencies = TRUE)

library(lavaan)

oyster.df <- data.frame(pheo = MPN$pheo,
                        chlo = MPN$chlo,
                        turb = MPN$turb,
                        temp = MPN$temp,
                        sal = MPN$sal, 
                        water = MPN$water.log.trh,
                        oyster = MPN$log.trh)

model <- 'oyster ~ temp + sal + chlo + water
          water ~ temp + sal 
'

path.fit <- sem(model,
                meanstructure=T,
                data=oyster.df)
AIC(path.fit)
summary(path.fit)
semPlot::semPaths(path.fit,what = "std",
                  whatLabels = "std",
                  layout = "tree3",
                  curvature = 2,
                  intercepts = FALSE,
                  nCharNodes = 0,
                  edge.label.cex = 0.8,
                  residuals = FALSE,
                  fade = TRUE,
                  cardinal = FALSE,
                  centerLevels = TRUE)
