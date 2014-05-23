GettingAndCleaningDataCourseProject
===================================

This repository contains the course project of the "Getting and Cleaning Data" course. Please download the Samsung data set (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ) and extract it. The folder "UCI HAR Dataset" should be in your R working directory. If you run the script "run_analysis.R", it will return a tidy data set named "tidyData.txt" with the average of each variable (that is a mean or standard deviation) for each activity and each subject.

## What the script does

1. the script checks if the Samsung data is in the folder. If not, it prints "Samsung Data is Missing!" and nothing else happens.
2. the features in the second column of the feature.txt are read into the variable "features".
3. the characters "," and "-" are replaced by ".", "(" and ")" are deleted.
4. the subject files are into the variables "subjectTrain" and "subjectTest".
5. the y test and train files are read into the variables "yTrainActivity"" and "yTestActivity".
6. the activity labels are read into the variable "activityLabels"
7. the activity labels are merged ("merge" function) with their corresponding activitiy IDs into the variables "trainLabels" "testLabels".
8. x train and test data are read with "features" as col.names and combined with the coresponding activity labels from "trainLabels" and "testLabels" and the subjects from "subjectTrain" and "subjectTest". The resulting data frame ist stored in the variables "xTrainData" and "xTestData".
9. the data frames from "xTrainData" and "xTestData" are combined using rbind and stored in the variable "xDataCombined".
10. only the columns containing "mean", ".std", "Subject" or "ActivityLabel" in their colnames are stored into the variable "xDataCombinedExtracted".
11. the tidy data set with the average of each variable for each activity and each subject is created using the "ddply" function from the "plyr" package
12. the tidy data set is writen into "tidyData.txt" the with tabs as delimiter.