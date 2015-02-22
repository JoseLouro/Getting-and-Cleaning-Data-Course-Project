##########################################################################################################
## Coursera Getting and Cleaning Data Course Project
## José Manuel Teles Louro da Silva 
## JoseLouro@gmail.com

### runAnalysis.r File Description:

### This script will perform the following steps on the UCI HAR Dataset downloaded from 
### https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
###
### All the data is stored in a folder named 'data'
###
### 1. Merge the training and the test sets to create one data set.
### 2. Extract only the measurements on the mean and standard deviation for each measurement. 
### 3. Use descriptive activity names to name the activities in the data set
### 4. Appropriately label the data set with descriptive activity names. 
### 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
##########################################################################################################
### Set working directory to the location where the UCI HAR Dataset was unzipped and the folder renamed to 'data'
# setwd('~/A. Pessoal/Carreira/Coursera Courses/Data Science Specialization/3. Getting and Cleaning Data/3. Quizzes/Peer Assignment/');

# Read in the data from files
## Read the Activity files
yTest  <- read.table('./data/test/y_test.txt',header=FALSE)
yTrain <- read.table('./data/train/y_train.txt',header=FALSE)

## Read the Subject files
subjectTrain <- read.table('./data/train/subject_train.txt',header=FALSE)
subjectTest  <- read.table('./data/test/subject_test.txt',header=FALSE)

## Read Features files
xTest       <- read.table('./data/test/x_test.txt',header=FALSE)
xTrain      <- read.table('./data/train/x_train.txt',header=FALSE)

# Concatenate the data tables by rows
dataSubject <- rbind(subjectTrain, subjectTest)
dataActivity<- rbind(yTrain, yTest)
dataFeatures<- rbind(xTrain, xTest)

# set names to variables
names(dataSubject)  <-c("subject")
names(dataActivity) <- c("activity")
dataFeaturesNames   <- read.table('./data/features.txt',header=FALSE)
names(dataFeatures) <- dataFeaturesNames$V2

# Merge columns to get the data frame Data for all data
dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)

# Subset Name of Features by measurements on the mean and standard deviation
subdataFeaturesNames <- dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

# Subset the data frame Data by seleted names of Features
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)

# Read descriptive activity names from “activity_labels.txt”
activityLabels <- read.table('./data/activity_labels.txt',header=FALSE)

# Names of Features will labelled using descriptive variable names.
# 
#   prefix t is replaced by time
#   Acc is replaced by Accelerometer
#   Gyro is replaced by Gyroscope
#   prefix f is replaced by frequency
#   Mag is replaced by Magnitude
#   BodyBody is replaced by Body

names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

#  Creates a second,independent tidy data set and output it
library(plyr);
Data2 <- aggregate(. ~subject + activity, Data, mean)
Data2 <- Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)
