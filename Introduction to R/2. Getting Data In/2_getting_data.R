# Introduction to R #

#2. GETTING DATA IN_________________________________

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

#We will use here the files: "PETR4.txt", "SPETR4.txt", "GOLL4.txt"
#Set the working directory where the files are or use the complete location when read it
rm(list = ls())
setwd("D:/$github/data_analysis_group/Introduction to R/")
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

#Read the file SPETR4.txt with the function read.table()
#this file contains two columns, date and closed price for PETR4 quotation
data <- read.table("./datasets/SPETR4.txt")
data
head(data)
tail(data)
rm(data)

#For large data sets we can optimize the function inserting the argument colClasses - a vector
#specifying the classes of the columns:
initial <- read.table("./datasets/SPETR4.txt", nrows = 100)
classes <- sapply(initial, class) #the function sapply will apply class() over all columns (vectors) of initial
rm(initial)
#We created a vector of the classes of the columns of SPETR4.txt reading just 100 rows of the file
#(don't need too much memory for this), now let's read the entire data using this vector:
tabAll <- read.table("./datasets/SPETR4.txt", colClasses = classes)
tabAll
head(tabAll)
tail(tabAll)
#That's it, the same data frame, but when working with big datas reading the file can be
#optimized with the argument colClasses
rm(tabAll, classes)

#to use another read.'' you can use the same idea but the args and the defaults changes
?read.table


##USING THE 'readr' PACKAGE
install.packages("readr")
#This package have some functions for reading files that are much faster than base R analogues functions 
#and provide a nice feature for progress meter.
#The analogous functions in readr are read_table(), read_csv() and read_csv2().
library("readr")
data <- read_table("./datasets/SPETR4.txt")
data
head(data)
tail(data)
rm(data)


#A little more complex read
read.table("./datasets/PETR4.txt")
readLines("PETR4.txt",10)
PETR <- read.table("./datasets/PETR4.txt"
                   , header = T
                   , sep=";"
                   , dec=","
                   , stringsAsFactors = F
                   , skip = 4
                   , na.strings = "-")
class(PETR)
head(PETR)
rm(list = ls())


###   QUESTIONS   ###

#How to use the memory calculations more efficiently?
    #In general, when using R with larger datasets, it's also useful to know a 
    #few things about your system.
    # - How much memory is available on your system?
    # - What other applications are in use? Can you close any of them?
    # - Are there other users logged into the same system?
    # - What operating system are you using? Some operating systems can limit the amount of 
    #   memory a single process can access


#Make the topic below cleaner:
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
    