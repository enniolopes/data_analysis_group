# compute returns

# simple 1-period returns
n = nrow(sbuxPrices.df)
# Note: to ensure that sbux.ret is a data.frame use drop=FALSE when computing returns
sbux.ret.df = (sbuxPrices.df[2:n,1,drop=FALSE] - sbuxPrices.df[1:(n-1),1,drop=FALSE])/sbuxPrices.df[1:(n-1),1,drop=FALSE]

# continuously compounded 1-month returns
sbux.ccret = log(1 + sbux.ret)
# alternatively
sbux.ccret = log(sbuxPrices.df[2:n,1]) - log(sbuxPrices.df[1:(n-1),1])

# plot the simple and cc returns in separate graphs
# split screen into 2 rows and 1 column
par(mfrow=c(2,1))
# plot simple returns first
plot(sbux.ret, type="l", col="blue", lwd=2, ylab="Return",
     main="Monthly Simple Returns on SBUX")
abline(h=0)     
# next plot the cc returns
plot(sbux.ccret, type="l", col="blue", lwd=2, ylab="Return",
     main="Monthly Continuously Compounded Returns on SBUX")
abline(h=0)     
# reset the screen to 1 row and 1 column
par(mfrow=c(1,1))     

# plot the returns on the same graph
plot(sbux.ret, type="l", col="blue", lwd=2, ylab="Return",
     main="Monthly Returns on SBUX")
# add horizontal line at zero
abline(h=0)     
# add the cc returns
lines(sbux.ccret, col="red", lwd=2)
# add a legend
legend(x="bottomright", legend=c("Simple", "CC"), 
       lty=1, lwd=2, col=c("blue","red"))


# calculate growth of $1 invested in SBUX
# compute gross returns
sbux.gret = 1 + sbux.ret
# compute future values
sbux.fv = cumprod(sbux.gret)
plot(sbux.fv, type="l", col="blue", lwd=2, ylab="Dollars", 
     main="FV of $1 invested in SBUX")