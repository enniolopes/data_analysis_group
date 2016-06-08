# Introduction to R #

#5. Plotting________________________________________
      #Basically there are 3 plotting system in R: base plotting, lattice and ggplot
      #Here, for introductory content, we focus on base plotting
setwd("D:/$github/data_analysis_group/Introduction to R/datasets")

# The Base Plotting System ------------------------------------------------
      #plotting with the base system you can make a plot and add things in it. Therefore, there are
      #two phases: 1. initializing a new plot; 2. annotating (adding to) an explicit plot.
      #start with plot() function and in a cumulative form you add pieces one by one, 
      #like points, lines, colors, etc.
      #Read the data 'PETR4.csv'
PETR <- read.csv2("PETR4.csv", header = T, stringsAsFactors = F)[,c(-6,-7)]
str(PETR)

?plot
hist(PETR$close)  #defaults arguments
hist(PETR$close, breaks = 15)
plot(PETR$liquidity, PETR$close)
with(PETR, plot(return, returnUS))

library(lubridate)
PETR$month <- month(PETR$date)
str(PETR)
PETR <- transform(PETR, month = factor(month))
boxplot(return ~ month, PETR, xlab = "month", ylab="return")
      # the function colors() gives a list of possibilities
colors()
      #the R command par() which specifies how we want to lay out the plots, also use par to 
      #specify margins, a 4-long vector which indicates the number of lines for the bottom, 
      #left, top and right.
names(par())      #possible parameters
par()             #defaults parameters, it changes all plots
example(points)

      #plotting with parameters
plot(y = PETR$close, x = PETR$liquidity, xlab = "Liquidity")
plot(y = PETR$close, x = PETR$liquidity, ylab = "Closing Price")
plot(y = PETR$close, x = PETR$liquidity, 
     ylab = "Closing Price", 
     xlab = "Liquidity",
     main = "PETR4 2014 quotations",
     sub = "Liquidity and price graph",
     col = 2,
     xlim = c(4,8),
     ylim = c(12,20),
     pch = 2)


#When you open multiples graphics you just can plot in one device at a time, the current active
#it can be found by dev.cur(), to change the active one use dev.set(<integer>)
#to copy a device use dev.copy()
#Vector formats are good for line drawings and plots with solid colors using a modest number of 
#points, while bitmap formats are good for plots with a large number of points, natural scenes 
#or web-based plots

# Graphic Devices ---------------------------------------------------------
?Devices #choose a device and a name for it, like pdf(file = "pdf_plot_test.pdf"), its open a new device
#when the plotting are finished, close the device with the function dev.off(), example:
windows(title = "Plotting PETR4")
x <- seq(1:nrow(PETR))
plot(PETR$return~x, pch = 13)
title("PETR4 2014 time series return")
text(30,-10, "simple return")
legend("topleft", legend = "return", pch = 13)
fit <- lm(PETR$return ~x)
abline(fit, lwd = 2, col = "blue")
rm(x,fit)
dev.off()
      #now make it for an image device!
?bmp
bmp(filename = 'plotPETR.bmp', width = 480, height = 480)
x <- seq(1:nrow(PETR))
plot(PETR$return~x, pch = 13)
title("PETR4 2014 time series return")
text(30,-10, "simple return")
legend("topleft", legend = "return", pch = 13)
fit <- lm(PETR$return ~x)
abline(fit, lwd = 2, col = "blue")
rm(x,fit)
dev.off()

?pdf
pdf(file = 'plotPETR4.pdf')
x <- seq(1:nrow(PETR))
plot(PETR$return~x, pch = 13)
title("PETR4 2014 time series return")
text(30,-10, "simple return")
legend("topleft", legend = "return", pch = 13)
fit <- lm(PETR$return ~x)
abline(fit, lwd = 2, col = "blue")
rm(x,fit)
dev.off()

# The Lattice System ------------------------------------------------------
#implemented by lattice package - install.packages("lattice")
#created with a single function, like (xyplot, bwplot)
#can't add to the plot once it is created
#example: 

if (installed.packages()["lattice",1] == "lattice") {
      print("lattice package already installed")
      library(lattice)
} else {
      install.packages("lattice")
      library(lattice)
}

PETR$quarter <- as.factor(quarter(PETR$date))
str(PETR)
xyplot(close ~ liquidity | quarter, data=PETR, layout=c(4,1))
