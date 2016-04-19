# Introduction to R #

#2. GETTING DATA IN AND OUT_________________________

#There are a few principal functions reading data into R.
# - read.table, read.csv, for reading tabular data
# - readLines, for reading lines of a text file
# - source, for reading in R code files (inverse of dump)
# - dget, for reading in R code files (inverse of dput)
# - load, for reading in saved workspaces
# - unserialize, for reading single R objects

#There are analogous functions for writing data to files
# - write.table, for writing tabular data to text files (i.e. CSV) or connections
# - writeLines, for writing character data line-by-line to a file or connection
# - dump, for dumping a textual representation of multiple R objects
# - dput, for outputting a textual representation of an R object
# - save, for saving an arbitrary number of R objects in binary format (possibly compressed)
#   to a file.
# - serialize, for converting an R object into a binary format for outputting to a connection (or file).

rm(list = ls())
setwd("D:/$github/data_analysis_group/Introduction to R/2. Getting Data In and Out")
getwd()
dir()



##READING DATA FILES WITH read.table()
#Arguments:
# - file, the name of a file, or a connection
# - header, logical indicating if the file has a header line
# - sep, a string indicating how the columns are separated
# - colClasses, a character vector indicating the class of each column in the dataset
# - nrows, the number of rows in the dataset. By default read.table() reads an entire file.
# - comment.char, a character string indicating the comment character. This defalts to "#".
#   If there are no commented lines in your file, it's worth setting this to be the empty string "".
# - skip, the number of lines to skip from the beginning
# - stringsAsFactors, should character variables be coded as factors? This defaults to TRUE.

data <- read.table("SPETR4.txt")
data
head(data)
tail(data)
rm(data)
#For large data sets:
initial <- read.table("SPETR4.txt", nrows = 100)
classes <- sapply(initial, class)
rm(initial)
tabAll <- read.table("SPETR4.txt", colClasses = classes)
tabAll
head(tabAll)
tail(tabAll)
rm(tabAll, classes)

#to use another read.'' you can use the same idea but the args and the defaults changes
?read.table

#In general, when using R with larger datasets, it's also useful to know a 
#few things about your system.
# - How much memory is available on your system?
# - What other applications are in use? Can you close any of them?
# - Are there other users logged into the same system?
# - What operating system are you using? Some operating systems can limit the amount of 
#   memory a single process can access



##USING THE 'readr' PACKAGE
install.packages("readr")
#recently developed by Hadley Wickham to deal with reading in large flat files quickly
#The analogous functions in readr are read_table() and read_csv().
#This functions are oven much faster than their base R analogues and provide a few other 
#nice features such as progress meters.
library("readr")
data <- read_table("SPETR4.txt")
data
head(data)
tail(data)
rm(data)
?read_table



##INTERFACES TO THE OUTSIDE WORLD
#Data are read in using connection interfaces. Connections can be made to files 
#(most common) or to other more exotic things.
# - file, opens a connection to a file
# - gzfile, opens a connection to a file compressed with gzip
# - bzfile, opens a connection to a file compressed with bzip2
# - url, opens a connection to a webpage

#File Connections
#file() function arguments:
#- description is the name of the file
#- open is a code indicating what mode the file should be opened in
  #The open argument allows for the following options:
  #Interfaces to the Outside World 33
  #- "r" open file in read only mode
  #- "w" open a file for writing (and initializing a new file)
  #- "a" open a file for appending
  #- "rb", "wb", "ab" reading, writing, or appending in binary mode (Windows)


## Create a connection to 'SPETR4.txt'
con <- file("SPETR4.txt")
## Open connection to 'SPETR4.txt' in read-only mode
open(con, "r")
## Read from the connection
data <- read.table(con)
## Close the connection
close(con)
    #which is the same as
    #data <- read.table("SPETR4.txt")
rm(data,con)


#Reading Lines of a Text File
#Text files can be read line by line using the readLines() function.
#This function is useful for reading text files that may be unstructured or contain 
#non-standard data.


#Reading From a URL Connection
#The readLines() function can be useful for reading in lines of webpages. 
#Since web pages are basically text files that are stored on a remote server, 
#there is conceptually not much difference between a web page and a local text file. 
#However, we need R to negotiate the communication between your computer and the web server.
#This is what the url() function can do for you, by creating a url connection to a web server.
#This code might take time depending on your connection speed.

## Open a URL connection for reading
con <- url("https://www5.usp.br/", "r")
## Read the web page
x <- readLines(con)
## Print out the first few lines
head(x, 1)
close(con)
#While reading in a simple web page is sometimes useful, 
#particularly if data are embedded in the web page somewhere.
#However, more commonly we can use URL connection to read in specific data files 
#that are stored on web servers. Using URL connections can be useful for producing a 
#reproducible analysis, because the code essentially documents where the data came 
#from and how they were obtained. This is approach is preferable to opening a web browser
#and downloading a dataset by hand. Of course, the code you write with connections 
#may not be executable at a later date if things on the server side are changed or 
#reorganized.
rm(list = ls())


#A little more complex read
read.table("PETR4.txt")
readLines("PETR4.txt",10)
PETR <- read.table("PETR4.txt", header = T, sep=";", dec=",", stringsAsFactors = F, skip = 4, na.strings = "-")
head(PETR)




#3. SUBSETTING AND REMOVING NAs_____________________
#There are three operators that can be used to extract subsets of R objects.
# - The [ operator always returns an object of the same class as the original. It can be
#   used to select multiple elements of an object
# - The [[ operator is used to extract elements of a list or a data frame. It can only be 
#   used to extract a single element and the class of the returned object will not necessarily
#   be a list or data frame.
# - The $ operator is used to extract elements of a list or data frame by literal name.
#   Its semantics are similar to that of [[.

PETR <- read.table("PETR4.txt", header = T, sep=";", dec=",", stringsAsFactors = F, skip = 4, na.strings = "-")
PETR <- PETR[-1,]
names(PETR)
PETR <- PETR[,c(1,2,3,13,14,16)]
names(PETR)
colnames(PETR) <- c("date", "close", "open", "return", "returnUS", "liquidity")
names(PETR)
head(PETR)
PETR <- PETR[,-3]

#Do the same for GOLL4.txt
GOL <- read.table("GOLL4.txt", header = T, sep=";", dec=",", stringsAsFactors = F, skip = 4, na.strings = "-")
GOL <- GOL[,c(1,2,3,13,14,16)]
colnames(GOL) <- c("date", "close", "open", "return", "returnUS", "liquidity")
GOL <- GOL[,-3,drop=T]
head(GOL)
tail(GOL)
head(GOL[!is.na(GOL[,2]),])

#Subset the GOL data from 01/01/2014 to 31/12/2014
GOL[GOL[,"date"]=="31/12/2013",]
GOL[GOL[,"date"]=="31/12/2014",]
GOL <- GOL[2873:3133,]
head(GOL)
tail(GOL)

#Subset PETR for the same period
head(PETR)
PETR[PETR[,"date"]=="31/12/2013",]
PETR[PETR[,"date"]=="31/12/2014",]
PETR <- PETR[7305:7565,]
head(PETR)
tail(PETR)


#Put data frames into a list
quotes <- list(GOL=GOL,PETR=PETR)
names(quotes)
names(quotes[["PETR"]])
names(quotes[["GOL"]])

## computed index for "PETR"
name <- "PETR"
head(quotes[[name]])
## element "name" doesn't exist! (but no error here)
quotes$name
## element "PETR" does exist
head(quotes$PETR[2])
rm(name)

#Data pooled
#compute the id (ticker)
PETR$id <- "PETR"
head(PETR)
GOL$id <- "GOL"
head(GOL)

pooled <- rbind(PETR,GOL)
head(pooled)
tail(pooled)
pooled[pooled$id=="GOL",]

#Pooled from a list
install.packages(data.table)
library("data.table")
pooled2 <- rbindlist(quotes)
head(pooled2)
tail(pooled2)

#Split pooled data into a list
quotes2 <- split(pooled, pooled$id)


#Summary analysis
str(PETR)
str(GOL)
PETR[c("close","return","returnUS","liquidity")] <- sapply(PETR[c("close","return","returnUS","liquidity")], type.convert, dec=",")
PETR$date <- as.Date(PETR$date, format = "%d/%m/%Y")
GOL[c("close","return","returnUS","liquidity")] <- sapply(GOL[c("close","return","returnUS","liquidity")], type.convert, dec=",")
GOL$date <- as.Date(GOL$date, format = "%d/%m/%Y")
str(PETR)
str(GOL)
summary(PETR)


#NAs
rm(pooled,pooled2,quotes,quotes2,GOL)

#How to work with NAs?
#In general the functions have the argument "na.rm" to compute or not NAs on the process

mean(PETR$close)
mean(PETR$close, na.rm=T)

#The function complete.cases() returns a logical vector indicating which cases are complete
complete.cases(PETR)
cPETR <- PETR[complete.cases(PETR),]

#only "close" data complete cases:
closePETR <- PETR[complete.cases(PETR$close),]

#or use the function na.omit()
#it returns the object with listwise deletion of missing values.
cPETR <- na.omit(PETR)

#For a vector replacing with some value:
PETR$close0 <- PETR$close
PETR$close0[is.na(PETR$close0)] <- 0
PETR$close0

PETR$closeM <- PETR$close
PETR$closeM[is.na(PETR$closeM)] <- mean(PETR$closeM, na.rm = T)

  #a function for this:
  na.zero <- function (x) {
    x[is.na(x)] <- 0
    return(x)
  }

PETR$close0 <- na.zero(PETR$close)
tail(PETR)

#Functions to fill NAs
library(zoo)
#you can use the args from the fuction na.fill to choose how to fill NAs:
#extend to indicate repetition of the leftmost or rightmost non-NA value or 
#linear interpolation in the interior
tail(na.fill(PETR$close,"extend"))

## use underlying time scale for interpolation
tail(na.approx(PETR$close),20)
#with and without na.rm = FALSE
na.approx(PETR$close, na.rm = FALSE)


