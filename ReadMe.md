## The Course project
for the getting and cleaning data course

This is the repository for the course project

The descrition of the data, variables and the transformation one the data are giving in the CodeBook.md

The R code is for creating a new tidy data set with the average of each variable for each activity and each subject from the raw data.

You can download the data from : 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


more info about this where the data orignate from can you find here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

unzip you data in your R working directory

Then you run the script run_analysis.R. When done you wil get a text file named final.txt in you working dir.
this is the tidy data set

You might need to run:
install.packages("reshape2");library(reshape2)
to use the script
