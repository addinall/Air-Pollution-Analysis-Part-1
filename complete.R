## CAPTAIN SLOG
## vim: set expandtab tabstop=4 shiftwidth=4 autoindent smartindent:
## File         : complete.R
## System       : Assignment 1 (Part 2)
## Date         : 09/08/2014
## Author       : Mark Addinall
## Synopsis     : This file is part of the course work
##                assignments for the Johns Hopkins
##                series of Data Science units.
##                This unit is R Programming
##
## Write a function that reads a directory full of files 
## and reports the number of completely observed cases 
## in each data file. The function should return a data 
## frame where the first column is the name of the file 
## and the second column is the number of complete cases. 
##
## Expected output
##
## source("complete.R")
## complete("specdata", 1)
##   id nobs
## 1  1  117
## complete("specdata", c(2, 4, 8, 10, 12))
##   id nobs
## 1  2 1041
## 2  4  474
## 3  8  192
## 4 10  148
## 5 12   96
## complete("specdata", 30:25)
##   id nobs
## 1 30  932
## 2 29  711
## 3 28  475
## 4 27  338
## 5 26  586
## 6 25  463
## complete("specdata", 3)
##   id nobs
## 1  3  243


## -------------------------------------------------
complete <- function(directory = '.', id = 1:332) {

## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

## 'id' is an integer vector indicating the monitor ID numbers
## to be used
                                            
## Return a data frame of the form:
## id nobs
## 1  117
## 2  1041
## ...
## where 'id' is the monitor ID number and 'nobs' is the
## number of complete cases



## initialise data
##
## build an empty data frame as we don't know
## how many records will be required so pre-allocating
## space is problamatical

    complete_cases  <- data.frame(  id = numeric(), 
                                    nobs = numeric(), 
                                    stringsAsFactors = FALSE)

## start the processing

    for (index in id) {

## first build a file name 
## what we are doing in this line is using the paste
## function to build the file name as we iterate
## through id
##
        file <- paste(  directory,"/", 
                        sprintf("%03d", index), 
                            ".csv", sep="")

        data        <- read.csv(file)
        data        <- na.omit(data)
        n_nobs      <- nrow(data)
       
        ## nrow returns NULL if data is an empty set...
        ## it would make a LOT more sense if it returned zero...
        ## if we have some complete cases, then append them
        ## to the data frame

        if (!is.null(n_nobs)) {
            complete_cases <- rbind(complete_cases, 
                                    data.frame( id = index, 
                                                nobs = n_nobs))
        }
    }
    complete_cases
}

