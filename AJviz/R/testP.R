# Script demonstrating that boxplots and MDS plots do not show information about individual observations. In contrast, parallel coordinate plots do show individual observations and allow for us to better see whether replications are consistent for individual observations.

library(ggplot2)
library(cowplot) # Need for combining ggplot2 output into one plot aesthetically
library(data.table)


set.seed(5)
boxPlots <- vector('list', 2)
pcpPlots <- vector('list', 2)
mdsPlots <- vector('list', 2)

# In the first case, we purposely create individual observations that will be inconsistent across their replications
A.1=sort(rnorm(50,10))
A.2=rev(sort(rnorm(50,10)))
A.3=sort(rnorm(50,10))
A.4=rev(sort(rnorm(50,10)))
A.5=sort(rnorm(50,10))

makePlots(A.1, A.2, A.3, A.4, A.5, 1)

# In the second case, we purposely create individual observations that will be more consistent across their replications
A.2=sort(rnorm(50,10))
A.4=sort(rnorm(50,10))

makePlots(A.1, A.2, A.3, A.4, A.5, 2)

# View the first case
plot_grid(boxPlots[[1]], mdsPlots[[1]], pcpPlots[[1]], labels=c("A", "B", "C"), ncol = 1, nrow = 3)

# View the second case
plot_grid(boxPlots[[2]], mdsPlots[[2]], pcpPlots[[2]], labels=c("A", "B", "C"), ncol = 1, nrow = 3)

A.1=sort(rnorm(50,10))
A.2=sort(rnorm(50,10))
A.3=sort(rnorm(50,10))
A.4=sort(rnorm(50,10))
A.5=sort(rnorm(50,10))

A.1 <- c(sort(runif(50, 1, 3)), runif(50, 1, 3))
A.2 <- c(sort(runif(50, 1, 3)), runif(50, 1, 3))
B.1 <- c(sort(runif(50, 5, 10)), runif(50, 5, 10))
B.2 <- c(sort(runif(50, 5, 10)), runif(50, 5, 10))

dat <- data.frame(A.1, A.2,B.1, B.2)
ggpairs2(dat)

