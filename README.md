Coursera_GettinAndCleaningData_Project
======================================

Coursera Getting And Cleaning Data Course Project


run_analysis.R does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Script run consideration:

In order to run first use setwd() to select directory where files are extracted from the ZIP file provided
similar to this: > setwd("~/Documents/R/GetDat/UCI HAR Dataset")

The result will be stored in a file called tidy_data_set.txt in the same directory
