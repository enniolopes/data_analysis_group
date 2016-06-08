# Introduction to R #

#3. MANAGING DATA AND MISSING VALUES___________________

#There are 3 operators that can be used to subset R objects:
# - "[]"    - always returns the same class of the original object;
#             extract multiple elements.
# - "[[]]"  - subset a list or a data frame;
#             only extract a single element;
#             class will not necessarily be the same of the original object.
# - "$"     - subset elements of a data frame or list by literal name.


##Subsetting a Vector
x <- c(sample(LETTERS,6,replace=T))
# Extract some elements
x[1]
x[2:4]
x[c(1, 3, 5)]
u <- x > "E"
u
x[u]
x[x > "E"]
rm(x,u)

##Subsetting a Matrix
x <- matrix(rnorm(20), 4, 5)
x
x[1, 2]   # the elements are [row,column]
x[2, 1]
x[1, ]    # extract the first row for all columns
x[, 2]    # extract the second column for all rows
#Dropping matrix dimensions
#By default a matrix subsetting return a vector, to cancel this default
#set the argument drop = FALSE, and it return a matrix
x[1, 2, drop = FALSE]
x[1, , drop = FALSE]


##Read the data "PETR4.txt"
rm(list = ls())
setwd("D:/$github/data_analysis_group/Introduction to R/datasets")
getwd()
dir()
PETR <- read.table("PETR4.txt"
                   , header = T
                   , sep=";"
                   , dec=","
                   , stringsAsFactors = F
                   , skip = 4
                   , na.strings = "-")

#Use some functions for some data summary:
head(PETR)
tail(PETR)
str(PETR)
names(PETR)

#We'll use only the columns 1,2,3,13,14 and 16. Filter it.
PETR <- PETR[,c(1,2,3,13,14,16)]
names(PETR)
#replace the all columns names
colnames(PETR) <- c("date", "close", "open", "return", "returnUS", "liquidity")
names(PETR)
head(PETR)
#drop the 3rd column ("open")
PETR <- PETR[,-3]

#Do the same for GOLL4.txt
GOL <- read.table("GOLL4.txt"
                  , header = T
                  , sep=";"
                  , dec=","
                  , stringsAsFactors = F
                  , skip = 4
                  , na.strings = "-")
GOL <- GOL[,c(1,2,13,14,16)]
colnames(GOL) <- c("date", "close", "return", "returnUS", "liquidity")
head(GOL)
tail(GOL)
#The initial observations are missing, look for the begining of non missing values
head(GOL[!is.na(GOL[,2]),])

#Summary analysis
str(PETR)
str(GOL)
#Use sapply to coerce the columns close, return, returnUS, liquidity to numeric
#and date with as.Date()
PETR[c("close","return","returnUS","liquidity")] <- sapply(PETR[c("close","return","returnUS","liquidity")], type.convert, dec=",")
PETR$date <- as.Date(PETR$date, format = "%d/%m/%Y")
GOL[c("close","return","returnUS","liquidity")] <- sapply(GOL[c("close","return","returnUS","liquidity")], type.convert, dec=",")
GOL$date <- as.Date(GOL$date, format = "%d/%m/%Y")
str(PETR)
str(GOL)
summary(PETR)

#Subset the GOL data from 01/01/2014 to 31/12/2014
GOL[GOL[,"date"]=="2013-12-31",]
GOL[GOL[,"date"]=="2014-12-31",]
GOL <- GOL[2873:3133,]
head(GOL)
tail(GOL)

#Subset PETR for the same period
PETR[PETR[,"date"]=="2013-12-31",]
PETR[PETR[,"date"]=="2014-12-31",]
PETR <- PETR[7306:7566,]
head(PETR)
tail(PETR)

#Subseting using "dplyr"
install.packages("dplyr")
library(dplyr)
select(PETR, close)
filter(PETR, return > 0)
filter(PETR, date > "2014-06-01", date < "2014-06-30")

#Put data frames into a list
quotes <- list(GOL=GOL,PETR=PETR)
names(quotes)
#The subset operators can be used to extract elements from a list
quotes[[1]]
quotes[["PETR"]]
quotes$PETR
names(quotes[["PETR"]])
names(quotes[["GOL"]])
#Get the 2nd element of the 1st element (ie. close from GOL)
quotes[[c(1, 2)]]
quotes[[1]][[2]]
quotes[[c("GOL", "close")]]
quotes[["GOL"]][["close"]]

#Data pooled
#compute the id (ticker) to identify the ticker into the pooled data
PETR$id <- "PETR"
head(PETR)
GOL$id <- "GOL"
head(GOL)

pooled <- rbind(GOL,PETR)
head(pooled)
tail(pooled)
pooled[pooled$id=="GOL",]


#Pooled from a list
install.packages("data.table")
library("data.table")
quotes[["PETR"]]["id"] <- "PETR"
quotes[["GOL"]]["id"] <- "GOL"
pooled2 <- rbindlist(quotes)
head(pooled2)
tail(pooled2)

#Split pooled data into a list for different ticker
quotes2 <- split(pooled, pooled$id)
names(quotes2)



##NAs
rm(pooled,pooled2,quotes,quotes2,GOL)
#How to work with NAs?
#In general the functions have the argument "na.rm" to compute or not NAs on the process
mean(PETR$close)
mean(PETR$close, na.rm=T)

#The function complete.cases() returns a logical vector indicating which cases are complete
complete.cases(PETR)
cPETR <- PETR[complete.cases(PETR$close,PETR$liquidity),] #keep only lines that 'close' and 'liquidity' are complete
cPETR <- PETR[complete.cases(PETR),] #keep only lines that are complete

#only "close" data complete cases (drop all lines that have NAs on the column "close"):
closePETR <- PETR[complete.cases(PETR$close),]

#or use the function na.omit()
#it returns the object with listwise deletion of missing values.
cPETR <- na.omit(PETR)


#For a vector replacing with some value:
PETR$close0 <- PETR$close
PETR$close0[is.na(PETR$close0)] <- 0 #replace all NAs with 0
PETR$close0

PETR$closeM <- PETR$close
PETR$closeM[is.na(PETR$closeM)] <- mean(PETR$close, na.rm = T) #replace all NAs with "close" mean
PETR$closeM

    #a function for replacing vectors NAs with 0:
    na.zero <- function (x) {
      x[is.na(x)] <- 0
      return(x)
    }
PETR$close0 <- na.zero(PETR$close)
tail(PETR)
str(PETR)

#Some functions to fill NAs
library(zoo)
#you can use the args from the fuction na.fill to choose how to fill NAs:
#extend to indicate repetition of the leftmost or rightmost non-NA value
PETR$closeE <- na.fill(PETR$close,"extend")
tail(PETR)

#use underlying time scale for interpolation
closeI <- na.approx(PETR$close)
#the interpolation cant fill the first and last values, so the vector returned has fewer length
length(closeI)
nrow(PETR)
  #Its possible complete with NAs or other values:
  closeI <- c(NA,closeI,0)
  #or make the interpolation with na.rm = FALSE and keed NAs
  closeI <- na.approx(PETR$close, na.rm = F)
PETR$closeI <- closeI
tail(PETR)
str(PETR)
summary(PETR)


#Write out
write.csv2(PETR, file = "PETR4.csv", row.names = F, dec = ",")




###   QUESTIONS   ###

#How to drop the name of the rows (index) when subsetting?
    row.names(PETR) <- NULL
    #Using NULL for the value resets the row names to seq_len(nrow(x)), regarded as 'automatic'.
    row.names(PETR) <- seq_len(nrow(PETR)) #the same if use NULL

#How to know the position of a logical subset?
    #eg. I want to filter by this interval below without setting the rows references manualy:
    PETR[PETR[,"date"]=="2013-12-31",]
    PETR[PETR[,"date"]=="2014-12-31",]
    PETR <- PETR[7306:7566,]
    
#If the median is minor than the mean, when you fill NAs with interpolation it will get down the final mean?
