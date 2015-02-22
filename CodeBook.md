Getting and Cleaning Data Course Project CodeBook 
=================================================
This file describes the variables, the data, and any transformations or work that I have performed to clean up the data.  
* The site where the data was obtained:  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones      
The data for the project:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
* The run_analysis.R script performs the following steps to clean the data:

 1. Read the Activity files ( y_test.txt and y_train.txt ) from the "./data/test/" and "./data/train" folders and store them in *yTest* and *yTrain* variables respectively.
 
 2. Read the Subject files ( subject_train.txt and subject_test.txt ) from the "./data/train" and "./data/test/" folders and store them in *subjectTrain* and *subjectTest* variables respectively.
 
 3. Read Features files ( X_test.txt and X_train.txt ) from the "./data/test/" and "./data/train" folders and store them in *xTest* and *xTrain* variables respectively.
 
 4. Concatenate *subjectTrain* to *subjectTest* to generate a 10299x1 data frame, *dataSubject*.
 
 5. Concatenate *yTrain* to *yTest* to generate a 10299x1 data frame, *dataActivity*.
 
 6. Concatenate *xTest* to *xTrain* to generate a 10299x561 data frame, *dataFeatures*.
 
 7. Set names to variables.
 
 8. Read the features.txt file from the "/data" folder and store the data in a variable called *dataFeaturesNames*.
 
 9. Merge columns to get the data frame Data for all data 
 
 10. Subset Name of Features by measurements on the mean and standard deviation
 
 11. Subset the data frame Data by selected names of Features
 
 12. Read descriptive activity names ( activity_labels.txt ) from the "./data"" folder and store the data in a variable called *activityLabels*.  

 13. The Names of Features will be labelled using descriptive variable names.
 
 14. Finally, generate a second independent tidy data set ( Data2 ) with the average of each measurement for each activity and each subject and write it in the file 'tidyData.txt'.
  
