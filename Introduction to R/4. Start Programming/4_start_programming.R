# Introduction to R #

#4. Start Programming_______________________________

# CONTROL STRUCURES -------------------------------------------------------
#allow you to put some 'logic' and respond to inputs rather than executing the same code many times.
#some control structures are:


#IF-ELSE
#teste a condition (whether it's true or false):
#    if(<condition1>) {
#      ## do something
#    } else if(<condition2>) {
#      ## do something different
#    } else {
#      ## do something different
#    }

# Generate a uniform random number
x <- runif(1, 0, 10)
if(x > 3) {
      y <- 1
} else {
      y <- 0
}
rm(x,y)


#FOR
#maybe the only loop you need to know in R
#this loop take an interator variable and assign values.
for(i in 0:5) {
      print(i)
}

x <- c("a", "b", "c", "d")
for(i in 1:4) {
      ## Print out each element of 'x'
      print(x[i])
}

#nested example
x <- matrix(1:6, 2, 3)
for(i in seq_len(nrow(x))) {
      for(j in seq_len(ncol(x))) {
            print(x[i, j])
      }
}
rm(x,i,j)


#WHILE
#while loop test a condition, if TRUE it will execute the code until the condition is FALSE.
count <- 0
while(count < 10) {
      print(count)
      count <- count + 1
}
rm(count)

z <- 5
while(z >= 3 && z <= 10) {
      coin <- rbinom(1, 1, 0.5)
      if(coin == 1) { 
            z <- z + 1              # random walk
      } else {
            z <- z - 1
      }
}
print(z) ; rm(z,coin)


#REPEAT
#it compute an infinite loop, the only way to stop it is to call break.
x0 <- 0
tol <- 2
repeat {
      x1 <- rnorm(1)
      if(abs(x1 + x0) > tol) {
            break
      } else {
            x0 <- x1
      }
}
rm(x0,x1,tol)

#NEXT, used to skip an iteration of a loop.
for(i in 1:100) {
      if(i <= 20) {
            ## Skip the first 20 iterations
            next
      }
      ## Do something here
}

#BREAK, used to exit a loop immediately.
for(i in 1:100) {
      print(i)
      if(i > 20) {
            ## Stop loop after 20 iterations
            break
      }
}
rm(i)

#Control structures like if, while, and for allow you to control the flow of an R program
#Infinite loops should generally be avoided, even if (you believe) they are theoretically correct.
#Control structures mentiond here are primarily useful for writing programs; for commandline
#interactive work, the 'apply' functions are more useful.

# SCOPING RULES -----------------------------------------------------------
dt <- as.data.frame(cbind(y = rpois(10, 100), x1 = rnorm(10), x2 = rbinom(10,1,.5)))
lm(dt)
mqo <- lm(y ~ x1 + x2 - 1, dt)
mqo
names(mqo)
mqo$residuals

lm <- function(x) { x * x }
lm
lm(dt)
rm(lm, dt, mqo)

#When you need to retrieve the value of an R object, the order in which things occur is:
#1. Search the global environment for a symbol name matching the one requested;
#2. Search the namespaces of each of the packages on the search list;
#The search list can be found by using the search() function.
search()
#When loads a package with library() the namespace of that package gets put in position 2
#of the search list:
library(dplyr)
search()

#The scoping rules of a language determine how a value is associated with a free variable in a function.
#R uses lexical scoping or static scoping.
#(http://en.wikipedia.org/wiki/Scope_(computer_science)#Lexical_scope_vs._dynamic_scope)
f <- function(x, y) {
      x^2 + y / z
}

#This function has 2 formal arguments x and y. In the body of the function there is another symbol
#z. In this case z is called a free variable.
#The scoping rules of a language determine how values are assigned to free variables. Free variables
#are not formal arguments and are not local variables (assigned insided the function body).
#Lexical scoping in R means that
#the values of free variables are searched for in the environment in which the function
#was defined.
environment(f)
rm(f)

# CODING STANDARDS FOR R --------------------------------------------------
#are by no means universal and are often the subject of irrational flame wars on
#various language- or project-specfiic mailing lists
#Always use text files / text editor
#Indent your code
#sugested: 6 spaces (minimum 4)
#Limit the width of your code
#Limit the length of individual functions

# LOOP FUNCTIONS ----------------------------------------------------------
#Writing for and while loops is useful when programming but not particularly easy when working
#interactively on the command line.
#R has some functions which implement looping in a compact form to make your life easier.

##    lapply():   Loop over a list and evaluate a function on each element
#it does the following simple series of operations:
      #1. it loops over a list, iterating over each element in that list
      #2. it applies a function to each element of the list (a function that you specify)
      #3. and returns a list (the l is for "list").
lapply
x <- list(a = 1:5, b = rnorm(10))
lapply(x, mean)
x <- 1:4
lapply(x, rnorm, mean = 10, sd = 2)
rm(x)

##    sapply():   Same as lapply but try to simplify the result
#similarly to lapply but it will try to simplify the result of lapply() if possible
#Essentially, sapply() calls lapply() on its input and then applies the following algorithm:
      #1. If the result is a list where every element is length 1, then a vector is returned
      #2. If the result is a list where every element is a vector of the same length (> 1), 
      #a matrix is returned.
      #3. If it can't figure things out, a list is returned
x <- list(a = 1:5, b = rnorm(10))
sapply(x, mean)

##    split():    Takes a object and splits it into groups determined by a factor or list of factors.
str(split)
      #x is a vector (or list) or data frame
      #f is a factor (or coerced to one) or a list of factors
      #drop indicates whether empty factors levels should be dropped
x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10)
split(x, f)
library(datasets)
head(airquality)
#split the airquality by month
s <- split(airquality, airquality$Month)
str(s)
sapply(s, colMeans, na.rm=T)
sapply(split(airquality, airquality$Month),
       colMeans,
       na.rm=T)
rm(x,s,f)

##    tapply():   Apply a function over subsets of a vector
#It can be thought of as a combination of split() and sapply() for vectors only.
str(tapply)
      #X is a vector
      #INDEX is a factor or a list of factors (or else they are coerced to factors)
      #FUN is a function to be applied
      #... contains other arguments to be passed FUN
      #simplify, should we simplify the result?
x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10)
tapply(x, f, mean)
tapply(x, f, mean, simplify = FALSE)
tapply(x, f, range)
rm(x,f)

##    apply():    Apply a function over the margins of an array
#often used to apply a function to the rows or columns of a matrix.
str(apply)
      #X is an array
      #MARGIN is an integer vector indicating which margins should be "retained".
      #FUN is a function to be applied
      #... is for other arguments to be passed to FUN
x <- matrix(rnorm(200), 20, 10)
apply(x, 2, mean) ## Take the mean of each column
apply(x, 1, sum) ## Take the mean of each row
#you can compute quantiles of the columns or rows of a matrix using the quantile() function.
x <- matrix(rnorm(200), 20, 10)
apply(x, 2, quantile, probs = c(0.25, 0.75))
rm(x)

##    mapply():   Multivariate version of lapply
#others APPLYs() only interate over a single R object, mapply() is to iterate
#over multiple R objects in parallel
str(mapply)
      #FUN is a function to apply
      #... contains R objects to apply over
      #MoreArgs is a list of other arguments to FUN.
      #SIMPLIFY indicates whether the result should be simplified
list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1))
#With mapply(), instead we can do:
mapply(rep, 1:4, 4:1) #1:4 to the first argument of rep() and 4:1 to the second argument.

# DEBUGGING ---------------------------------------------------------------
#There are different levels of indication that something's not right can be used, ranging from
#mere notification to fatal error. Executing any function in R may result in the following conditions:
      #message:   A generic notification/diagnostic message produced by the message() function;
      #           execution of the function continues
      #warning:   An indication that something is wrong but not necessarily fatal; execution of the
      #           function continues. Warnings are generated by the warning() function
      #error:     An indication that a fatal problem has occurred and execution of the function stops.
      #           Errors are produced by the stop() function.
      #condition: A generic concept for indicating that something unexpected has occurred; programmers
      #           can create their own custom conditions if they want.
log(-1) #Warning

printmessage <- function(x) {
      if(x > 0)
            print("x is greater than zero")
      else
            print("x is less than or equal to zero")
      invisible(x)
}
printmessage(1) ; printmessage(-1) ; #Message

printmessage(NA) #Error (can't test if x > 0 if x is a NA or NaN value)
#fix this problem in the function:
printmessage2 <- function(x) {
      if(is.na(x))
            print("x is a missing value!")
      else if(x > 0)
            print("x is greater than zero")
      else
            print("x is less than or equal to zero")
      invisible(x)
}
printmessage2(NA)

#what about the following situation:
x <- log(c(-1, 2))
printmessage2(x)
#we simply need to check the length of the input.
printmessage3 <- function(x) {
      if(length(x) > 1L)
            stop("'x' has length > 1")
      if(is.na(x))
            print("x is a missing value!")
      else if(x > 0)
            print("x is greater than zero")
      else
            print("x is less than or equal to zero")
      invisible(x)
}
printmessage3(x)

#Vectorizing the function can be accomplished easily with the Vectorize() function.
printmessage4 <- Vectorize(printmessage2)
printmessage4(c(-1, 2)) #Vectorize() function it no longer preserves the invisibility
rm(list = ls())

#The primary task of debugging any R code is correctly diagnosing what the problem is.
#When diagnosing it's important first understand what you were expecting to occur.
#Then you need to idenfity what did occur and how did it deviate from your expectations.
#Some basic questions you need to ask are:
      #What was your input? How did you call the function?
      #What were you expecting? Output, messages, other results?
      #What did you get?
      #How does what you get differ from what you were expecting?
      #Were your expectations correct in the first place?
      #Can you reproduce the problem (exactly)?

##Debugging Tools in R
#The primary tools for debugging functions in R are
      #traceback():prints out the function call stack after an error occurs; does nothing if there's
      #           no error
      #debug():   flags a function for "debug" mode which allows you to step through execution of a
      #           function one line at a time
      #browser(): suspends the execution of a function wherever it is called and puts the function in
      #           debug mode
      #trace():   allows you to insert debugging code into a function a specific places
      #recover(): allows you to modify the error behavior so that you can browse the function call stack

#     traceback():
#prints out the sequence of functions that was called before the error occurred
lm(y ~ x)
traceback()
#eval() function tried to evaluate the formula y ~ x and realized the object y did not exist.
#The traceback must be called immediately after an error occurs.

#     debug():
#Initiates an interactive debugger (also known as the "browser")
#With the debugger, you can step through an function one expression at a time to pinpoint exactly 
#where an error occurs.
debug(lm)   #flag the lm() function for interactive debugging
lm(y ~ x)
undebug(lm)
#every time you call the lm() function it will launch the interactive debugger.
#To turn this behavior off you need to call the  function.

#     recover():
#can be used to modify the error behavior of R when an error occurs, when an error occurs,
#it should halt execution at the exact point at which the error occurred.
options(error = recover)      #Change default R error behavior
read.csv("nosuchfile")
#The recover() function will:
      #1. print out the function call stack when an error occurrs.
      #2. you can choose to jump around the call stack and investigate the problem.
      #When you choose a frame number, you will be put in the browser
            #(just like the interactive debugger triggered with debug())
            #and will have the ability to poke around.
