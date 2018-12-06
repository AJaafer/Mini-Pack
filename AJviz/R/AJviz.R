
#' @title AJviz
#' @description This package is for interactive visualization
#' @param
#' @return
#' @examples
#' @import coxplot
#' @import ggplot2
#' @import data.table
#' @import GGally
#' @export

# This function creates a boxplot, MDS plot, and parallel coordinate plot for five replications

makePlots <- function(A.1, A.2, A.3, A.4, A.5, i){
  dat <- data.frame(ID = paste0("ID", 1:50), A.1, A.2, A.3, A.4, A.5)
  datM <- melt(dat, id.vars = "ID")
  colnames(datM) <- c("ID", "Group", "Value")

  boxPlots[[i]] <<- ggplot(datM, aes(Group, Value)) + geom_boxplot(fill='#A4A4A4', color="#56B4E9") + theme(text = element_text(size=12))

  # Convert DF from scatterplot to PCP
  datt <- data.frame(t(dat))
  names(datt) <- as.matrix(datt[1, ])
  datt <- datt[-1, ]
  datt[] <- lapply(datt, function(x) type.convert(as.character(x)))
  setDT(datt, keep.rownames = TRUE)[]
  dat_long <- melt(datt, id.vars ="rn" )
  colnames(dat_long) <- c("Group", "ID", "Value")

  pcpPlots[[i]] <<- ggplot(dat_long) + geom_line(aes(x = Group, y = Value, group = ID, color = ID),size=1) + theme(legend.position="none", text = element_text(size=12))

  tDat <- t(dat[,2:6])
  datD <- as.matrix(dist(tDat))
  fit <- cmdscale(datD, eig = TRUE, k = 2)
  x <- fit$points[, 1]
  y <- fit$points[, 2]
  mdsPlots[[i]] <<- qplot(x,y, color = "red",
                          geom=c("point", "smooth")) + geom_text(label = names(x), nudge_y = 0.35) + labs(x = "Dim 1", y = "Dim 2") + theme(text = element_text(size=12))
}

ggpairs2 <- function (dat) {
p = ggpairs(dat, upper = list(continuous = wrap("cor", size = 3)),
        lower=list(continuous=wrap("smooth", colour='#A4A4A4')),
        diag=list(continuous=wrap("densityDiag", fill="#E69F00")))
return(p)
}
