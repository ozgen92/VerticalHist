# VerticalHist
R function to create vertical histograms

Example use:

```
data <- matrix(c(rep(rnorm(500, 110, 20),5)), ncol=5, byrow=TRUE) # or dataframe
VerticalHistCaller(data)
```


_Based on [this](stackoverflow.com/a/13334294/903061) Stack Overflow answer created by Gregor Thomas_


