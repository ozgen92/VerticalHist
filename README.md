# VerticalHist
R function to create vertical histograms

Example use:

`
data <- as.data.frame(matrix(c(rep(rnorm(500, 110, 20),5)), ncol=5, byrow=TRUE))
VerticalHistCaller(data)
`


