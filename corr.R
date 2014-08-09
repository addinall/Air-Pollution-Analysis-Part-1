## CAPTAIN SLOG
## vim: set expandtab tabstop=4 shiftwidth=4 autoindent smartindent:
## File         : corr.R
## System       : Assignment 1 - Part Three 
## Date         : 09/08/2014
## Author       : Mark Addinall
## Synopsis     : This file is part of the course work
##                assignments for the Johns Hopkins
##                series of Data Science units.
##                This unit is R Programming
##
## Write a function that takes a directory of data files and a 
## threshold for complete cases and calculates the correlation 
## between sulfate and nitrate for monitor locations where the 
## number of completely observed cases (on all variables) is 
## greater than the threshold. The function should return a 
## vector of correlations for the monitors that meet the threshold 
## requirement. If no monitors meet the threshold requirement, 
## then the function should return a numeric vector of length 0.
##
## Expected results
##
## source("corr.R")
## source("complete.R")
## cr <- corr("specdata", 150)
## head(cr)
## [1] -0.01896 -0.14051 -0.04390 -0.06816 -0.12351 -0.07589
## summary(cr)
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -0.2110 -0.0500  0.0946  0.1250  0.2680  0.7630
## cr <- corr("specdata", 400)
## head(cr)
## [1] -0.01896 -0.04390 -0.06816 -0.07589  0.76313 -0.15783
## summary(cr)
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -0.1760 -0.0311  0.1000  0.1400  0.2680  0.7630
## cr <- corr("specdata", 5000)
## summary(cr)
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## 
## length(cr)
## [1] 0
## cr <- corr("specdata")
## summary(cr)
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -1.0000 -0.0528  0.1070  0.1370  0.2780  1.0000
## length(cr)
## [1] 323



## --------------------------------------------------------
corr <- function(directory = ".", threshold = 0) {

## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

## 'threshold' is a numeric vector of length 1 indicating the
## number of completely observed observations (on all
## variables) required to compute the correlation between
## nitrate and sulfate; the default is 0

## Return a numeric vector of correlations



## first make use of an earlier function I wrote, complete.R
## this returns a data frame with the id of datasets and the
## number of complete observations in the dataset.  There is a second
## argument to this function - id:range.
## if we leave this out of the call the function defaults to 'ALL'
##
## I added some functionality to complete to prepend the
## filenames examined and passed as to avoid doing the calculations here.
## I was going to polymorph the function, but as this is a Uni
## course, I may need to submit the original again so I just
## made a copy and gave it a new moniker!!!

    complete_cases <- complete_filenames(directory)

## we now hold a data table in the format

##      id nobs   filename
## 1     1  117   specdata/001.csv
## 2     2 1041   specdata/002.csv
## [...]

## now we strip our data set COLLECTION based on the value of the threshold passed
## in as an argument

    complete_cases <- complete_cases[complete_cases$nobs > threshold,]

## create an empty vector to hold the values used in the correlation analysis

    correlation <- vector(mode="numeric", nrow(complete_cases)) 
    index <- 0

# and go and fetch the relevant data

    for (file in complete_cases$filename) {

        data <- read.csv(file)
        data <- na.omit(data)               ## strip NA, NaN
        index <- index + 1
        correlation[index] <- cor(data$sulfate, data$nitrate)
    }

    return(correlation)
}
