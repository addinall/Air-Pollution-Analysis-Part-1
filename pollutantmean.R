## CAPTAIN SLOG
## vim: set expandtab tabstop=4 shiftwidth=4 autoindent smartindent:
## File         : pollutantmean.R
## System       : Assignment 1
## Date         : 08/08/2014
## Author       : Mark Addinall
## Synopsis     : This file is part of the course work
##                assignments for the Johns Hopkins
##                series of Data Science units.
##                This unit is R Programming
## Expected output
## source("pollutantmean.R")
##	pollutantmean("specdata", "sulfate", 1:10)
## 	[1] 4.064
##	pollutantmean("specdata", "nitrate", 70:72)
## 	[1] 1.706
##	pollutantmean("specdata", "nitrate", 23)
## 	[1] 1.281


## -----------------------------------------------------------------
pollutantmean <- function(directory = ".", pollutant, id = 1:332) {

pollutant

## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

## 'pollutant' is a character vector of length 1 indicating
## the name of the pollutant for which we will calculate the
## mean; either "sulfate" or "nitrate".

## 'id' is an integer vector indicating the monitor ID numbers
## to be used

## Return the mean of the pollutant across all monitors list
## in the 'id' vector (ignoring NA values)


## first build a file list
## what we are doing in this line is using the paste
## function to iterate over the id vector, applying
## the function of sprintf to each iteration to 
## pad that portion of the string as "000".."00n".
##
## we also use this iteration to build the fully qualified
## file name "specdata/005.csv" etc., and return them
## in the vector files.

    files <- paste( directory,"/", 
                    sprintf("%03d", as.numeric(id)), 
                    ".csv", sep="")

    files

## SUCK in the data set
## being a Perl Monk this suits me more than FOR loops!
## we iterate though our files vector, read the
## appropriate CSV file, and combine the individual
## data into a combined data set.

    combined_data <- lapply(files, read.csv)

    class(combined_data)
    
    combined_data

    #colnames(combined_data) <- c("Date","sulfate","nitrate","ID")

    #names(combined_data)

##    mean(combined_data[,pollutant], na.rm = TRUE)


}


