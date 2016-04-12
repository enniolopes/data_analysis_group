#3. SUBSETTING AND REMOVING NAs_____________________


#There are three operators that can be used to extract subsets of R objects.
# - The [ operator always returns an object of the same class as the original. It can be
#   used to select multiple elements of an object
# - The [[ operator is used to extract elements of a list or a data frame. It can only be 
#   used to extract a single element and the class of the returned object will not necessarily
#   be a list or data frame.
# - The $ operator is used to extract elements of a list or data frame by literal name.
#   Its semantics are similar to that of [[.
                                          

##Subsetting a Vector
x <- c("a", "b", "c", "c", "d", "a")
x[1] ## Extract the first element
x[2] ## Extract the second element
x[1:4]
x[c(1, 3, 4)]
u <- x > "a" #pass a logical sequence
u
x[u]
x[x > "a"] #more compact way
rm(x,u)


##Subsetting a Matrix
x <- matrix(1:6, 2, 3)
x
x[1, 2]
x[2, 1]
x[1, ] ## Extract the first row
x[, 2] ## Extract the second column
##Dropping matrix dimensions
#By default, when a single element of a matrix is retrieved, it is returned as a
#vector of length 1, but this behavior can be turned off by setting drop = FALSE.
x[1, 2, drop = FALSE]
x[1, , drop = FALSE]
#Be careful of R's automatic dropping of dimensions.
rm(list = ls())


##Subsetting Lists
x <- list(foo = 1:4, bar = 0.6)
x
#The [[ operator can be used to extract single elements from a list.
x[[1]]
x[["bar"]]
x$bar

#One thing that differentiates the [[ operator from the $ is that the [[ 
#operator can be used with computed indices. The $ operator can only be used with literal names.
x <- list(foo = 1:4, bar = 0.6, baz = "hello")
name <- "foo"
## computed index for "foo"
x[[name]]
## element "name" doesn't exist! (but no error here)
x$name
## element "foo" does exist
x$foo


#Subsetting Nested Elements of a List
#The [[ operator can take an integer sequence if you want to extract a nested 
#element of a list.
x <- list(a = list(10, 12, 14), b = c(3.14, 2.81))
x
## Get the 3rd element of the 1st element
x[[c(1, 3)]]
x[[1]][[3]]






#4. VECTORIZED OPERATIONS___________________________
#5. DATE AND TIMES__________________________________
#6. MANAGING DATA FRAMES____________________________
#7. CONTROL STRUCTURES______________________________
#8. LOOP FUNCTIONS__________________________________
#9. REGULAR EXPRESSIONS_____________________________
#10.FUNCTIONS AND DEBBUGING_________________________
#11.CASE STUDY______________________________________


#Importing data
#Exploratory data analysis
#Reproducible research, LAteX in Sweave and httr