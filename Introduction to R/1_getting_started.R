# Introduction to R #

#1. GETTING STARTED_________________________________
      #R version:
      R.version.string

# Installing and using packages -------------------------------------------
installed.packages()
rownames(installed.packages())
update.packages(ask=FALSE)
install.packages("tseries")
help(package="tseries")
library(tseries)

# BASICS INTERACTING ------------------------------------------------------
1
5 + 7       #adition
7 - 2       #subtraction
2 * 3       #multiplication
5 / 2       #division
2 ^ 3 #or 2**3
5 %/% 2     #integer division
5 %% 2    #mod

# ENTERING INPUT ----------------------------------------------------------
x <- 5 + 7  #assignment operator
x
print(x)
y <- x - 3
y
z <- c(1.1, 9, 3.14)
?c
z
c(z, 555, z)
z*2 + 100
my_sqrt <- sqrt(z - 1)
my_sqrt
my_div <- z/my_sqrt
my_div
c(1, 2, 3, 4) + c(0, 10)
c(1, 2, 3, 4) + c(0, 10, 100)
z*2 + 1000
my_div

# SETTING WORKSPACE -------------------------------------------------------
getwd()
dir()
?list.files
args(list.files)
list.files()
old.dir <- getwd()
old.dir
setwd("D:/$github/data_analysis_group")

ls()
rm(x, y, z, my_sqrt, my_div)
ls()
dir.create("testdir")
setwd("testdir")
file.create("mytest.R")
list.files()
file.exists("mytest.R")
file.info("mytest.R")
file.rename("mytest.R", "mytest2.R")
file.copy("mytest2.R", "mytest3.R")
setwd(old.dir)
rm(old.dir)

# SEQUENCE OF NUMBERS -----------------------------------------------------
1:20
pi:10
15:1
?":"
seq(1, 20)
seq(0, 10, by=0.5)
my_seq <- seq(5, 10, length=30)
length(my_seq)
1:length(my_seq)
seq(along.with = my_seq)
seq_along(my_seq)
rep(0, times = 40)
rep(c(0, 1, 2), times=10)
rep(c(0, 1, 2), each=10)
rm(my_seq)

# OBJECTS CLASSES ---------------------------------------------------------
      ##R has five basic or "atomic" classes of objects:
            # character
            # numeric (real numbers)
            # integer
            # complex
            # logical (True/False)
      #Numbers are generally trated as numeric objects, if you explicitly want an integer, 
      #you need to specify the L suffix
      x <- 5
      class(x)
      y <- 5L
      class(y)

# CREATING VECTORS --------------------------------------------------------
#The c() function can be used to create vectors of objects by concatenating things together.
num_vect <- c(0.5, 55, -10, 6)
tf <- num_vect < 1
tf
num_vect >= 6
my_char <- c("My", "name", "is")
my_char
paste(my_char, collapse = " ")
my_name <- c(my_char, "Ennio")
my_name
paste(my_name, collapse = " ")
paste("Hello", "world!", sep = " ")
paste(1:3, c("X","Y","Z"), sep ="")
LETTERS
paste(LETTERS, 1:4, sep = "-")

#Mixing Objects
y <- c(1.7, "a") ## character
y <- c(TRUE, 2) ## numeric
y <- c("a", TRUE) ## character

  #Explicit Coercion
  x <- 0:6
  class(x)
  as.numeric(x)
  as.logical(x)
  as.character(x)
  #Warning: NAs introduced by coercion
  x <- c("a", "b", "c")
  as.numeric(x)
  rm(x,y)

# SIMULATIONS -------------------------------------------------------------
#The sample() function draws randomly from a specified set of (scalar) objects allowing you to
#sample from arbitrary distributions of numbers.
set.seed(51)
?sample
sample(1:6, 4, replace=TRUE)
sample(1:20, 10)
LETTERS
sample(LETTERS) #Doesn't have to be numbers
flips <- sample(c(0,1), 100, replace = TRUE, prob = c(0.3, 0.7))
flips
sum(flips)
?rbinom()
rbinom(1, size = 100, prob = 0.7)
flips2 <- rbinom(100, size = 1, prob = 0.7)
flips2
sum(flips2)
?rnorm()
rnorm(10)
rnorm(10, 100, 25)
rpois(5, 10)
my_pois <- replicate(100, rpois(5, 10))
my_pois
cm <- colMeans(my_pois)
hist(cm)
rm(list = ls())

# MISSING VALUES INTRO ----------------------------------------------------
x <- c(44, NA, 5, NA)
x*3
y <- rnorm(1000)
z <- rep(NA, 1000)
my_data <- sample(c(y, z), 100)
my_na <- is.na(my_data)
my_na
my_data == NA
sum(my_na)

notna <- !is.na(my_data)
sum(notna)

my_data
0/0
Inf - Inf
rm(list = ls())

# SUBSETTING VECTORS ------------------------------------------------------
x
x[1:3]
x[is.na(x)]
y <- x[!is.na(x)]
y
y[y > 0]
x[x > 0]
x[!is.na(x) & x > 0]
x[c(3,5,7)]
x[0]
x[3000]
x[c(-2, -10)]
x[-c(2, 10)]
vect <- c(foo = 11, bar = 2, norf = NA)
vect
names(vect)
vect2 <- c(11,2,NA)
names(vect2) <- c("foo", "bar", "norf")
identical(vect, vect2)
vect["bar"]
vect[c("foo", "bar")]

  #R objects can have attributes, which are like metadata for the object
  #Some examples of R object attributes are:
  # names, dimnames
  # dimensions (e.g. matrices, arrays)
  # class (e.g. integer, numeric)
  # length
  # other user-defined attributes/metadata
  #Attributes of an object (if any) can be accessed using the attributes() function:
rm(list = ls())

# MATRICES ----------------------------------------------------------------------
#Matrices are vectors with a dimension attribute.
#The dimension attribute is itself an integer vector of length 2 (number of rows, number of columns)
m <- matrix(nrow = 2, ncol = 3)
m
dim(m)
attributes(m)
#Matrices are constructed column-wise, so entries can be thought of starting in the 
#"upper left" corner and running down the columns.
m <- matrix(1:6, nrow = 2, ncol = 3)
m
n = matrix(
      1:10,            #the data elements
      nrow=2,          #number of rows
      ncol=5,          #number of columns
      byrow = TRUE)    #fill matrix by rows
#Matrices can also be created directly from vectors by adding a dimension attribute.
m <- 1:10
m
dim(m) <- c(2, 5)
m
#Matrices can be created by column-binding or row-binding with the cbind() and rbind() functions.
x <- 1:3
y <- 10:12
m <- cbind(x, y)
dim(m)
rbind(x, y)
rm(m,n,x,y)

# VECTORIZED OPERATIONS ----------------------------------------------------------------------
      #adding two vectors together
x <- 1:4
y <- 11:14
z <- x + y
z
z > 15 #logical operations return a logical vector of TRUE/FALSE
x >= 2
x - y
x * y
x / y
rm(x,y,z)

##Vectorized Matrix Operations
      #Matrix operations are also vectorized (element-by-element operations).
A <- matrix(1:4, 2, 2)
B <- matrix(11:14, 2, 2)
x <- rnorm(4)
b <- rbinom(2,1,.5)
k <- 5
A * B
A / B
A * k
      #Next some operators and functions specifically suited to linear algebra.
      install.packages("MASS")
      library(MASS)
A %*% B           #Matrix multiplication
crossprod(A,B)
crossprod(A)	#A'B and A'A
t(A)              #Transpose
diag(x)           #Creates diagonal matrix with elements of x in the principal diagonal
diag(A)           #Returns a vector containing the elements of the principal diagonal
diag(k)           #If k is a scalar, this creates a k x k identity matrix
solve(A, b)       #Returns vector x in the equation b = Ax (= A-1b)
solve(A)          #Inverse of A (square matrix).
ginv(A)           #Moore-Penrose Generalized Inverse of A (MASS package).
y <- eigen(A)     #(https://pt.wikipedia.org/wiki/Valor_pr%C3%B3prio)
                  #(https://pt.wikipedia.org/wiki/Vector_pr%C3%B3prio)
      y$val       #are the eigenvalues of A.
      y$vec       #are the eigenvectors of A.
y <- svd(A)	      #Single value decomposition of A.
                  #(https://pt.wikipedia.org/wiki/Decomposi%C3%A7%C3%A3o_em_valores_singulares).
      y$d         #vector containing the singular values of A
      y$u         #matrix with columns contain the left singular vectors of A 
      y$v         #matrix with columns contain the right singular vectors of A
y <- qr(A)        #QR decomposition of A.
      y$qr        #has an upper triangle that contains the decomposition and a lower triangle 
                  #that contains information on the Q decomposition.
      y$rank      #is the rank of A. 
      y$qraux     #a vector which contains additional information on Q. 
      y$pivot     #contains information on the pivoting strategy used.
rowMeans(A)
rowSums(A)
colMeans(A)
colSums(A)
      #for more details you can look up in: http://www.statmethods.net/advstats/matrix.html

# LISTS -------------------------------------------------------------------
#Lists are a special type of vector that can contain elements of different classes.
#Lists can be explicitly created using the list() function, which takes an arbitrary number of arguments.
x <- list(c(1:10), c("azul","amarelo","vermelho"), TRUE, 1 + 4i, m)
x
#We can also create an empty list of a prespecified length with the vector() function
x <- vector("list", length = 5)
x
rm(list = ls())

# FACTORS -----------------------------------------------------------------
#Factors are used to represent categorical data and can be unordered or ordered.
#One can think of a factor as an integer vector where each integer has a label.
#Using factors with labels is better than using integers because factors are self-describing.
#Factor objects can be created with the factor() function.
x <- factor(c("yes", "yes", "no", "yes", "no"))
x
table(x)
x
## See the underlying representation of factor
unclass(x)

#The order of the levels of a factor can be set using the levels argument to factor().
#This can be important in linear modelling because the first level is used as the baseline level.
x <- factor(c("yes", "yes", "no", "yes", "no"))
x ## Levels are put in alphabetical order
x <- factor(c("yes", "yes", "no", "yes", "no"), levels = c("yes", "no"))
x

# DATA FRAME --------------------------------------------------------------
#Data frames are used to store tabular data in R.
#package dplyr has an optimized set of functions designed to work efficiently with data frames.
#Unlike matrices, data frames can store different classes of objects in each column.
#In addition to column names, indicating the names of the variables or predictors,
#data frames have a special attribute called row.names which indicate information 
#about each row of the data frame.
rm(x)
my_vector <- 1:20
my_vector
dim(my_vector)
length(my_vector)
dim(my_vector) <- c(4, 5)
dim(my_vector)
attributes(my_vector)
my_vector
class(my_vector)
my_matrix <- my_vector
?matrix
my_matrix2 <- matrix(1:20, nrow=4, ncol=5)
identical(my_matrix, my_matrix2)

patients <- c("Jose", "Gina", "Kelly", "Sean")
cbind(patients, my_matrix)
my_data <- data.frame(patients, my_matrix)
my_data
class(my_data)
cnames <- c("patient", "age", "weight", "bp", "rating", "test")
colnames(my_data) <- cnames
my_data
colnames(my_data) <- c("patient", "age", "weight", "bp", "rating", "test")
rm(list = ls())

# LOGIC -------------------------------------------------------------------
?"&&"
TRUE == TRUE
2 == 3
(FALSE == TRUE) == FALSE
6 == 7
6 < 7
10 <= 10
5 != 7
!5 == 7
#use the `&` operator to evaluate 'AND' across a vector. The `&&` version of AND only
#evaluates the first member of a vector
FALSE & FALSE
TRUE & c(TRUE, FALSE, FALSE)
TRUE && c(TRUE, FALSE, FALSE)
TRUE | c(TRUE, FALSE, FALSE)
TRUE || c(TRUE, FALSE, FALSE)
5 > 8 || 6 != 8 && 4 > 3.9
isTRUE(6 > 4)
identical('twins', 'twins')
xor(5 == 6, !FALSE)
ints <- sample(10)
ints
ints > 5
which(ints > 7)
any(ints<0)
all(ints>0)

# DATE AND TIMES ----------------------------------------------------------------------
      #dates are represented by the Date class and times are represented by the POSIXct
      #or the POSIXlt class.
Sys.getlocale("LC_TIME")
Sys.Date()
Sys.time()
##Dates
d <- as.Date("1970-01-01")
d
class(d)
unclass(d)
unclass(as.Date("1970-01-02"))
unclass(as.Date("1969-01-01"))
      #some functions to work with dates:
weekdays(d)
months(d)
quarters(d)
##Times
      #POSIXct is a very large integer - useful for data frames;
      #POSIXlt is a list that stores informations of the date (day of the week, month).
t <- Sys.time()
t
class(t)
      #can be coerced using the as.POSIXlt() or as.POSIXct().
p <- as.POSIXlt(t)
names(unclass(p))
p$wday
      #to use as POSIXct()
d <- Sys.time()
d     #already in POSIXct class
unclass(d)
d$sec #can't extract with 'POSIXct'
d <- as.POSIXlt(d)
d$sec
rm(d,p,t)
      #in case your dates are written in a different format:
?strptime() #takes a character of dates and times and converts into POSIXlt.
d <- c("Janeiro 10, 2012 10:40", "Dezembro 9, 2011 9:10")
class(d)
d <- strptime(d, "%B %d, %Y %H:%M") #% are the formatting strings for dates and times
d
class(d)
      #for the formatting strings check ?strptime for details.
##Operations
      #can use '+' and '-', and comparisons (i.e. ==, <=)
d <- as.Date("2016-01-01")
t <- strptime("3 mar 2015 11:34:21", "%d %b %Y %H:%M:%S")
d-t
d <- as.POSIXlt(d)
d-t
      #it keep track of things about dates and times, like leap years, time zones
d <- as.Date("2016-03-01")
t <- as.Date("2016-02-20")
d-t
      #two different time zones
d <- as.POSIXct("2016-05-03 14:00:00")
t <- ?as.POSIXct("2016-05-03 14:00:00", tz = "GMT")
d-t
difftime(Sys.time(), d, units = 'days')
##good package to work with dates and times: 'lubridate'
rm(list = ls())

# REGULAR EXPRESSIONS ----------------------------------------------------------------------
      #here we will running example using data from homicides in Baltimore City:
      #http://data.baltimoresun.com/news/police/homicides/
      #The data are scrapped in "homicide.txt"
setwd("D:\\$github\\data_analysis_group\\Introduction to R\\datasets")
homicides <- readLines("homicides.txt")
length(homicides)
homicides[1]      #each element of the character vector represents one event
homicides[1000]   #data have the HTML tags - they were scraped directly from the website
      #The primary R functions for dealing with regular expressions are:
##grep(), grepl()
      #Search for regular expression/pattern in a character vector
g <- grep("iconHomicideShooting", homicides)
length(g)
g
      #grep() returns the indices into the character vector that contain a match
      #or the specific strings that happen to have the match.
      #for some entries the flag is different 'icon_homicide_shooting':
g <- grep("iconHomicideShooting|icon_homicide_shooting", homicides)
length(g)
      #can grep() on the cause of death field with the format 'Cause: shooting'
g <- grep("Cause: shooting", homicides)
length(g)
      #sometimes "shooting" uses a captial "S"
g <- grep("[Cc]ause: [Ss]hooting", homicides)
length(g)
      #be careful when processing text data to don't grep data out of context
g <- grep("[Ss]hooting", homicides)
length(g)
str(g)
i <- grep("[cC]ause: [Ss]hooting", homicides)
str(i)
setdiff(i, g)
setdiff(g, i)
homicides[318]
      #set 'value' = TRUE for elements of the character.
?state.name
state.name
grep("^New", state.name)
grep("^New", state.name, value=T)
      #grepl() works like grep() except that it differs in its return value
      #returns a TRUE/FALSE vector
g <- grepl("^New", state.name)
g
state.name[g]

# FUNCTIONS ---------------------------------------------------------------
?function(){}

    boring_function <- function(x) {
         print(x)
    }

boring_function('My first function!')
boring_function


     my_mean <- function(my_vector) {
       sum(my_vector) / length(my_vector)
     }

my_mean(c(4, 5, 10))

     remainder <- function(num, divisor = 2) {
       num %% divisor
     }

remainder(5)
remainder(11, 5)
remainder(divisor = 11, num = 5)
remainder(4, div = 2)
args(remainder)

     evaluate <- function(func, dat) {
       func(dat)
     }

evaluate(sd, c(1.4, 3.6, 7.9, 8.8))
evaluate(function(x){x+1},6)
evaluate(function(x){tail(x,1)}, c(8,4,0))


     telegram <- function(...){
       paste("START", ..., "STOP")  
     }

telegram("new","letter","test")

     mad_libs <- function(...){
       args <- list(...)
       place <- args[["place"]]
       adjective  <- args[["adjective"]]
       noun  <- args[["noun"]]
       paste("News from", place, "today where", adjective, "students took to the streets in protest of the new", noun, "being installed on campus.")
     }

mad_libs(place = "country", adjective = "crazy", noun = "bank")

     "%p%" <- function(...){
           paste(...)
     }
     
'I'%p%'love'%p%'R!'
