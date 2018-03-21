# Keeps flexible reusable plotting functions

VerticalHist <- function(x, xscale = NULL, xwidth, hist,
                         fillCol = "gray80", lineCol = "gray40") {
  ## x (required) is the x position to draw the histogram
  ## xscale (optional) is the "height" of the tallest bar (horizontally),
  ##   it has sensible default behavior
  ## xwidth (required) is the horizontal spacing between histograms
  ## hist (required) is an object of type "histogram"
  ##    (or a list / df with $breaks and $density)
  ## fillCol and lineCol... exactly what you think.
  binWidth <- hist$breaks[2] - hist$breaks[1]
  if (is.null(xscale)) xscale <- xwidth * 0.90 / max(hist$density)
  n <- length(hist$density)
  x.l <- rep(x, n)
  x.r <- x.l + hist$density * xscale
  y.b <- hist$breaks[1:n]
  y.t <- hist$breaks[2:(n + 1)]
  
  rect(xleft = x.l, ybottom = y.b, xright = x.r, ytop = y.t,
       col = fillCol, border = lineCol)
}

# Wrapper to VerticalHist
VerticalHistCaller <- function(data, binWidth=1, xlab="", ylab="", xlim=NULL, ylim=NULL, fillCol="gray") {
  numberOfHists <- ncol(data)
  binStarts <- 1:numberOfHists
  binMids <- binStarts + binWidth / 2
  axisCol <- "gray80"
  
  ## Data handling
  allValues <- unlist(as.list(data))
  DOYrange <- range( allValues, na.rm = TRUE )
  DOYrange <- c(floor(DOYrange[1]), ceiling(DOYrange[2]))
  quantiles <- round(quantile( DOYrange, c(0.2, 0.4, 0.6, 0.8), na.rm=TRUE ), digits=0)
  gridlines <- round(quantile( DOYrange, c(0.1, 0.3, 0.5, 0.7, 0.9), na.rm=TRUE ), digits=0)
  
  
  
  ## Get the histogram obects
  histList <- apply( data, 2, function(x, hCol) hist(x, plot = FALSE))
  
  ## Plotting
  # par(mar = c(5, 5, 1, 1) + .1)
  if(is.null(xlim)){ xlim <- c(0,numberOfHists+1) }
  if(is.null(ylim)){ ylim <- DOYrange; }
  
  plot(c(0,0), DOYrange, type = "n", ann = FALSE, axes = FALSE, xaxs = "i", yaxs = "i", xlim=xlim, ylim=ylim )
  axis(1, cex.axis = 1.2, col = axisCol)
  mtext(side = 1, outer = F, line = 3, xlab, cex = 1.2)
  
  axis(2, cex.axis = 1.2, las = 1, line = -.7, col = "white", at = quantiles, labels = as.character(quantiles), tck = 0)
  mtext(side = 2, outer = F, line = 3.5, ylab, cex = 1.2)
  box(bty = "L", col = axisCol)
  
  ## Gridlines
  abline(h = gridlines, col = "gray80")
  
  # biggestDensity <- max(unlist(lapply(histList, function(h){max(h[[4]])})))
  # xscale <- binWidth * .9 / biggestDensity
  
  ## Plot the histograms
  for (lengthBin in 1:numberOfHists) {
    VerticalHist(binStarts[lengthBin], xscale = 1, xwidth = binWidth, histList[[lengthBin]], fillCol=fillCol)
  }
  
}


