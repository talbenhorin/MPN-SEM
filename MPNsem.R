rm(list=ls(all=TRUE))
set.seed(1234)
MPN <- read.csv("oysterMPNstd.csv", fill = FALSE, header = TRUE) 
# install.packages("lavaan", dependencies = TRUE)
# install.packages("semPlot", dependencies = TRUE)

library(lavaan)

oyster.df <- data.frame(temp = MPN$temp,
                        sal = MPN$sal,
                        sal2 = MPN$sal2,
                        water = MPN$water.log.trh,
                        oyster = MPN$log.trh,
                        turb = MPN$turb,
                        chlo = MPN$chlo,
                        pheo = MPN$pheo)

model <- '
  # regressions
    water ~ 1 + temp + sal + sal2 + turb
    oyster ~ 1 + temp + sal + sal2

  # covariance
    water~~oyster
'

path.fit <- sem(model,data=oyster.df)

fitMeasures(path.fit,c("npar","chisq","pvalue","aic"))
summary(path.fit,standardized=TRUE, fit.measures=TRUE)
parameterEstimates(path.fit,
                   se = FALSE, zstat = FALSE, pvalue = FALSE, ci = FALSE,
                   standardized = FALSE,
                   fmi = FALSE, level = 0.95, boot.ci.type = "perc",
                   cov.std = TRUE, fmi.options = list(),
                   rsquare = TRUE)
semPlot::semPaths(path.fit,what = "std",
                  whatLabels = "std",
                  layout = "circle2",
                  intercepts = FALSE,
                  edge.color = rgb(0, 0, 0, maxColorValue = 255),
                  nCharNodes = 0,
                  edge.label.cex = 0.8,
                  residuals = FALSE,
                  fade = FALSE,
                  cardinal = FALSE,
                  centerLevels = TRUE)
