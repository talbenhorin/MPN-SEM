rm(list=ls(all=TRUE))
set.seed(1234)
MPN <- read.csv("oysterMPN.csv", fill = FALSE, header = TRUE) 
# install.packages("lavaan", dependencies = TRUE)
# install.packages("semPlot", dependencies = TRUE)

#library(lavaan)

oyster.df <- data.frame(temp = MPN$temp,
                        sal = MPN$sal, 
                        water = MPN$water.log.vvha,
                        oyster = MPN$log.vvha,
                        turb = MPN$turb,
                        chlo = MPN$chlo)

model <- 'water ~ 1 + temp + sal 
          oyster ~ 1 + temp + sal
          water~~oyster
'

path.fit <- sem(model,data=oyster.df)

fitMeasures(path.fit,c("npar","chisq","pvalue","aic"))
summary(path.fit)
parameterEstimates(path.fit,
                   se = FALSE, zstat = FALSE, pvalue = FALSE, ci = FALSE,
                   standardized = FALSE,
                   fmi = FALSE, level = 0.95, boot.ci.type = "perc",
                   cov.std = TRUE, fmi.options = list(),
                   rsquare = TRUE)
semPlot::semPaths(path.fit,what = "std",
                  whatLabels = "std",
                  layout = "tree",
                  curvature = 2,
                  intercepts = FALSE,
                  edge.color = rgb(0, 0, 0, maxColorValue = 255),
                  nCharNodes = 0,
                  edge.label.cex = 0.8,
                  residuals = FALSE,
                  fade = FALSE,
                  cardinal = FALSE,
                  centerLevels = TRUE)
