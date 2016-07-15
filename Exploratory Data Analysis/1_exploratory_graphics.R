# Exploratory data analysis #

# 1. Checklist ------------------------------------------------------------
#1. Formulate your question
#2. Read in your data
#3. Check the packaging
#4. Run str()
#5. Look at the top and the bottom of your data
#6. Check your "n"s
#7. Validate with at least one external data source
#8. Try the easy solution first
#9. Challenge your solution
#10. Follow up
      #1. Do you have the right data?
      #2. Do you need other data?
      #3. Do you have the right question?
#The goal of exploratory data analysis is to get you thinking about your data and reasoning
#about your question. At this point, we can refine our question or collect new data, all in
#an iterative process to get at the truth.

# Principles of Analytic Graphics -----------------------------------------
#1. Show comparisons
      #evidence for a hipothesis is aways relative to another comparing hipothesis
#2. Show causality, mechanism, explanations, systematic structure
      #it's difficult to prove that one thing causes another thing even with the most 
            #carefully collected data.
      #useful for your data graphics to indicate what you are thinking about in terms of cause
      #the display may suggest hypotheses or refute them
      #raise new questions that can be followed up with new data or analyses
#3. Show multivariate data
      #world is multivariate
      #make a lot of plots
#4. Integation of evidence
      #include printed numbers, words, images, and diagrams to tell your story
      #data graphics should make use of many modes of data presentation simultaneously
#5. Describe and document the evidence
      #documented with apropriate labels, scales and sources
      #data graphic should tell a complete story all by itself
      #should not have to refer to extra text or descriptions when interpreting a plot, if possible
#6. Content is the King!
      #Analytical presentations ultimately stand or fall depending on the quality, relevance,
            #and integrity of their content
      #Starting with a good question, developing a sound approach, and only presenting
            #information that is necessary for answering that question, is essential to every data
            #graphic.

# Exploratory Graphics ----------------------------------------------------
#important at the beginning stages of data analysis to understand basic properties of the data,
      #to find simple patterns in data, and to suggest possible modeling strategies.
#make a distinction between exploratory graphs and final graphs

setwd("D:\\$github\\data_analysis_group\\Introduction to R\\datasets")
petr <- read.csv2("PETR4.csv", dec = ",")
petr$date <- as.Date(petr$date,"%Y-%m-%d")
str(petr)
petr <- petr[!is.na(petr$return),]

quantile(petr$return, na.rm = T)
library(lubridate)
petr$year <- year(petr$date)
petr <- petr[petr[,"year"] >= 2005 & petr[,"year"] <= 2013,]
unique(petr$year)
petr$crisis <- as.factor(petr$year == 2008 | petr$year == 2009)
str(petr)

#Boxplot
      boxplot(petr$return, col = "blue")
      abline(h=0)
      #outliers according to the boxplot() algorithm.

#Histogram
      hist(petr$return, col="green")
      rug(petr$return)
      hist(petr$return, col="green", breaks = 100)
      hist(petr$return, col="green")
      abline(v=median(petr$return, na.rm = T), col="magenta", lwd=3)

#Barplot
      barplot(table(petr$crisis), col = "wheat" ,main="Number of obs. in crisis period")
      barplot(quantile(petr$return, na.rm = T))


#Multiple Boxplots
      #simplest ways to show the relationship between two variables
      boxplot(return ~ crisis, data = petr, col = "red")
      boxplot(return ~ year, data = petr, col = "red")

      petr$month <- month(petr$date)
      levels(petr$crisis)
      boxplot(return ~ month + year, data = petr[petr$crisis == TRUE,], col = "red")
      petr$crisis <- as.factor((petr$year == 2008 & petr$month >= 9) | (petr$year == 2009 & petr$month == 1))
      boxplot(return ~ crisis, data = petr, col = "red")

#Multiple Histograms
      #see changes in the shape of the distribution of a variable across different categories
      par(mfrow = c(2, 1), mar = c(4, 4, 2, 1))
      hist(subset(petr, crisis == FALSE)$return, col = "green", xlim = c(-15,15), breaks = 10)
      hist(subset(petr, crisis == TRUE)$return, col = "green", xlim = c(-15,15), breaks = 10)
      par(mfrow = c(1, 1))
      
#Scatterplots
      #For continuous variables, the most common visualization technique is the scatterplot
      petr$volatility = log(1 + (petr$return/100))*100
      with(petr, plot(date, volatility))
      with(subset(petr, crisis == TRUE), plot(date, volatility))
      with(petr, plot(liquidity, volatility))
      abline(h = 0, lwd = 2, lty = 2, col = "red")
      
      #Using colors
      with(petr, plot(liquidity, volatility, col = crisis))
      abline(v = 11.5, lwd = 2, lty = 2, col = "blue")
      levels(petr$crisis)
      
#Multiple Scatterplots
      #Using multiple scatterplots can be necessary when overlaying points with different
      #colors or shapes is confusing
      par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))
      with(subset(petr, crisis == FALSE),
           plot(liquidity, volatility,
                main = "Non Crisis",
                ylim = c(-15,15),
                xlim = c(4,17)))
      with(subset(petr, crisis == TRUE),
           plot(liquidity, volatility,
                main = "Crisis",
                ylim = c(-15,15),
                xlim = c(4,17)))

      ## Lattice
      library(lattice)
      xyplot(volatility ~ liquidity | crisis, data = petr)
      ## ggplot2
      library(ggplot2)
      qplot(liquidity, volatility, data = petr, facets = . ~ crisis)
