# Introduction to R #

#1. GETTING STARTED_________________________________
#This topic cover an introduction for the issues:
#- Basic Interactions
#- Entering Input
#- Setting Workspace
#- Sequence of Numbers
#- Creating Vectors
#- Simulations
#- Missing Values
#- Subsetting Vectors
#- Matrices
#- Lists
#- Factors
#- Data Frames
#- Logic
#- Writing Functions


#R version:
R.version.string

#Installing and using packages:
installed.packages()
rownames(installed.packages())
update.packages(ask=FALSE)
install.packages("tseries")
help(package="tseries")
library(tseries)

## BASICS INTERACTING
1
5 + 7       #adition
7 - 2       #subtraction
2 * 3       #multiplication
5 / 2       #division
2 ^ 3 #or 2**3
5 %/% 2     #integer division
5 %% 2    #mod


## ENTERING INPUT
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


##SETTING WORKSPACE
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


##SEQUENCE OF NUMBERS
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


##CREATING VECTORS
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

    
#SIMULATIONS
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

#MISSING VALUES INTRO
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

#SUBSETTING VECTORS
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

#MATRICES
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



#LISTS
#Lists are a special type of vector that can contain elements of different classes.
#Lists can be explicitly created using the list() function, which takes an arbitrary number of arguments.
x <- list(c(1:10), c("azul","amarelo","vermelho"), TRUE, 1 + 4i, m)
x
#We can also create an empty list of a prespecified length with the vector() function
x <- vector("list", length = 5)
x
rm(list = ls())



#FACTORS
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


##DATA FRAMEs
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


#LOGIC
?"&&"
TRUE == TRUE
2 == 3
(FALSE == TRUE) == FALSE
6 == 7
6 < 7
10 <= 10
5 != 7
!5 == 7
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



##FUNCTIONS
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
