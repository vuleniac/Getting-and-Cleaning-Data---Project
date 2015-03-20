## This script is part of the Johns Hopkings' Getting and Cleaning Data course project offered in COURSERA.
## The script produces a tidy dataset from data collected from accelerometers in Samsung Galaxy S smartphones. 
## A full description is available at the site where the data was obtained: 
##      http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
## The routine folows these steps:

##      0. Setup
##      1. Download
##      2. Loading Descriptive Data
##      3. Merges the training and the test sets to create one data set.
##      4. Extracts only the measurements on the mean and standard deviation for each measurement.
##      5. Uses descriptive activity names to name the activities in the data set
##      7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
##         for each activity and each subject.
##      8. Write tidy data

# 0. Setup: Loads the necessary packages and set the URL for the data to be downloaded

library(reshape2)
library(dplyr)
file_url='https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

## 1. Download: Checks the existance of the data from UCI Machine Learning Repository on Human Activity Recognition Using Smartphones.
##               If the data does not exist, downloads it and decompresses it.

    if(!file.exists("./FUCI_dataset.zip")){
        download.file(file_url,destfile="./FUCI_dataset.zip")
        unzip("./FUCI_dataset.zip",exdir=".")
        }else{ if(!file.exists("./UCI HAR Dataset")){
            unzip("./FUCI_dataset.zip",exdir=".")
            }
        }
    }

## 2. Loading Descriptive Data: Reads in the descriptive information that is common to the "Train" and "Test" sets of data.

#Variable Names
features <- read.table('UCI HAR Dataset/features.txt', header=F, sep=" ", stringsAsFactors=F)

#Activity Lables
act_lables <- read.table('UCI HAR Dataset/activity_labels.txt', header=F, sep=" ", stringsAsFactors=F)

## 3. Merges the training and the test sets to create one data set.

#Train Dataset
train_dat <- read.table('UCI HAR Dataset/train/X_train.txt', header=F)
#Test Dataset
test_dat <- read.table('UCI HAR Dataset/test/X_test.txt', header=F)
#Combining "Train" and "Test" dataset
data_df <- rbind(train_dat, test_dat)

## 4. Extracts only the measurements on the mean and standard deviation for each measurement.

#Getting the index of the variables corresponding to mean and standard deviation for each measurement.
mean_std <- grep("mean()|std()", features$V2)
#Subsetting the combined dataset using "mean_std" index
data_df <- data_df[,mean_std]

## 5. Uses descriptive activity names to name the activities in the data set

#Reading in the activity information for the "Train" and "Test" datasets
train_lab <- read.table('UCI HAR Dataset/train/y_train.txt', header=F, sep=" ")
test_lab <- read.table('UCI HAR Dataset/test/y_test.txt', header=F, sep=" ")
#Combining the activity information for the "Train" and "Test" datasets
acti_fct <- rbind(train_lab, test_lab)
#Turning the activity variable from Numeric to Factor via cut() and assaigning the corresponding activity lables (act_lables)
acti_fct <- cut(acti_fct[,1],breaks=(length(act_lables[,1])), labels=act_lables[,2])

## 6. Appropriately labels the data set with descriptive variable names

#Creating a character vector with the names of the variables corresponding to "mean_std"
variables <- features[mean_std,2]
#Assaigning the names to the variables in the combined data in "data_df"
names(data_df) <- variables
#Reading in the subject ID for the "Train" and "Test" datasets
train_sub <- read.table('UCI HAR Dataset/train/subject_train.txt', header=F, sep=" ")
test_sub <- read.table('UCI HAR Dataset/test/subject_test.txt', header=F, sep=" ")
#Creating a factor to identify the Train" and "Test" datasets
train_sub$set <- factor("train")
test_sub$set <- factor("test")
#Combining the subject and set ideintifiers for the "Train" and "Test" datasets
subject_df <- rbind(train_sub, test_sub)
#Naming the "subject" and "set" identifiers
names(subject_df) <- c("subject","set")
#Creating a varibale for subject_df corresponding the activity factors (acti_fct) 
subject_df$activity <- acti_fct
#Combining the identifiers (subject_df) and the data values (data_df) into a single dataframe (tidy_df)
tidy_df <- cbind(subject_df, data_df)

## 7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
##    for each activity and each subject.

# Getting the average of each variable for each activity for each subject via melt() -> dcast() -> mean()
#       melt():  Produces a skinny flat dataset that staks all the observations of the variable into a single measure variable,
#                using as identifyer "subject" and "activity".
#       dcast(): Unstacks the melted dataframe (making it wide again) by keeping the identifiers (subject + activity) and "dcasting" 
#                the variables aplying the mean() function.

ind_tidy <- dcast(melt(select(tidy_df,-set), 
                       id.vars=c('subject', 'activity'), 
                       measure.vars=variables, 
                       variable.name="measures"), 
                  subject + activity ~ measures, 
                  mean)

## 8. Write tidy data

write.table(ind_tidy, file = "tidy_data.txt", row.name=FALSE)
View(ind_tidy)

#############################  END SCRIPT  ##################################