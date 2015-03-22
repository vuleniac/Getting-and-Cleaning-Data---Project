---
title: "Code Book"
output: html_document
---
##Human Activity Recognition Using Smartphones Dataset

The data dowloaded from UCI's Machine Learning Repository on Human Activity Recognition Using Smartphones corresponds to the experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers were selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with  0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

For each record it is provided: 

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

More information at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

### Data Downloaded

The dataset can be downloaded from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The information is presented in a series of tables:

* **activity_labels.txt**: string list of 6 activities labels (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
* **features.txt**: a 561 string list of variable names
* ***test***:
    + **subject_test.txt**: subject identifiers for the test group
    + **X_test.txt**: 561 variable data table
    + **y_test.txt**: activity identifiers for the test group
* ***train***:
    + **subject_train.txt**: subject identifiers for the train group
    + **X_train.txt**: 561 variable data table
    + **y_train.txt**: activity identifiers for the train group

### Processed Data

The R script created to generate the tidy dataset can be found [here](https://github.com/vuleniac/Getting-and-Cleaning-Data---Project/blob/master/run_analysis.R). The [README](https://github.com/vuleniac/Getting-and-Cleaning-Data---Project/blob/master/README.md) file in this repo explains how all of the scripts work and how they are connected.

The processsed dataset has the following characteristics:

####**ind_tidy** (dataframe): 
Dataframe with 68 variables and 180 observations

* **Variables:**

    + subject: integer. subject identifier (1L:30L)
    + activity: factor. 6 levels. (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
    + Signals: numeric. 66 variables
        + These signals were used to estimate variables of the feature vector for each pattern:  
        '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

            tBodyAcc-XYZ   
            tGravityAcc-XYZ  
            tBodyAccJerk-XYZ  
            tBodyGyro-XYZ  
            tBodyGyroJerk-XYZ  
            tBodyAccMag  
            tGravityAccMag  
            tBodyAccJerkMag  
            tBodyGyroMag  
            tBodyGyroJerkMag  
            fBodyAcc-XYZ  
            fBodyAccJerk-XYZ  
            fBodyGyro-XYZ  
            fBodyAccMag  
            fBodyAccJerkMag  
            fBodyGyroMag  
            fBodyGyroJerkMag
    
        + The set of variables that were estimated from these signals and included in the tidy dataset are: 

            mean(): Mean value  
            std(): Standard deviation
        
* **Observations**

    + The observations are the average of the records from the original dataset (train and test sets combined) for each variable for each activity and each subject:
    
        + 30 Subjects x
        + 6 Activities =
        + 180 observations
        
More details on the process and transformations can be found in the [README](https://github.com/vuleniac/Getting-and-Cleaning-Data---Project/blob/master/README.md) file of this repo.
        
        


   