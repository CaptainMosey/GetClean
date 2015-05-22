##Code Book for Getting and Cleaning Data (Coursera course project).

###full description of data set:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


###project data archive:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


After unzipping archive in the working directory, load "run_analysis.R" script
and run "run_analysis" function with no arguments. function will load the train
and test data from the /UCI HAR Dataset/ folders, as well as labels for 
activities and features:

* X_test, subject_test, y_test 
* X_train, subject_train, y_train
* activity_labels, features

These data are merged into complete "test" and"train" sets, which are then
 bound together in a data table named "total".  This dataset has descriptive
labels for activities performed (activity labels) and for measuremnts taken 
(features). It consists of 10299 observations of 564 variables

From the complete "total" data set "smallDataSet" is extracted. this data table
only contains the mean and standard deviations recorded in the measurements.

A final tidy data set is then created from the "smallDataSet". "smallMelt"
averages the measurements taken from specific subjects during specific 
activities. this cleaner data set now summarizes the data with 40
observations of 82 variables. This final data table is written to a file named "ans.txt" in the working dirtectory


