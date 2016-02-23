## Getting and Cleaning Data Course Project Codebook
This code book describes the variables, the data, and any transformations or work that I performed to clean up the data.

The data is downloaded from:
* site: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
* file: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The downloaded file is a zipped file that contains:
* test - data for 30% of of the subjects
    * Inertial Signals - the data in this folder was not used in run_analysis.R
    * subject_test.txt - 2947 observations of subject
    * X_test.txt - test data set (2947 observations of 561 variables identified in "features.txt")
    * y_test.txt - 2947 observations of activity
* train - data for 70% of the subjects
    * Inertial Signals - the data in this folder was not used in run_analysis.R
    * subject_test.txt - 7352 observations of subject
    * X_train.txt - training data set (7352 observations of 561 variables identified in "features.txt"
    * y_train.txt - 7352 observations of activity
* activity_labels.txt - used to assign the activity numbers a name
* features.txt - used to label the variables in the feature vector
* features_info.txt - information about the variables in the feature vector
* README.txt - General information about the data/contents in this file

The run_analysis.R script performs the following:

1. Setup
    * Creates a data folder if one doesn't exist
    * installs the dplyr package
2. Download files
    * Downloads the file if it doesn't already exist in the data folder
3. Unzip files
    * Upzips the file if it hasn't already been unzipped in the data folder
4. Load variable names and activity labels
    * features.txt is loaded into a data frame named varnames. 
        * varnames has 561 rows and 2 columns. 
        * The first column is position and goes from 1 to 561
        * The second column is a descpritive name for the measurements. These are not unique however.
        * A concatenaction of these two columns will be used to give descriptive names to the measurements in the test and train data sets. 
    * activity_labels.txt is loaded into a data frame named activity_labels
        * activity_labels has 6 rows and 2 columns
        * This is a mapping between the activity codes used in the y_train.txt and y_test.txt files and a descriptive activity name
5. Load and tidy test data
    * This is the data for 9 of the subjects in the experiment
    * subject_test.txt is loaded into a data frame named test_subjects
        * This data frame has 2947 observations of subject. There are 9 subjects in total
        * This will become a column in the full dataset
    * y_test.txt is loaded into a data frame named test_activities
        * This data frame has 2947 observations of activity codes. There are 6 activity codes in total
        * This will become a column in the full dataset
        * These codes are joined with activity_labels to give a descriptive name to each activity
    * X_test.txt is loaded into a data frame named test_data
        * This data frame has 2947 observations of 561 measurements
        * This data will make up 561 columns in the full dataset
        * The columns in this data frame are named using the data in the varnames data frame
    * These 3 tables are combined column-wise creating a new data frame test_data_set
        * Each subject is matched to an activity and to 561 measurements
        * test_data_set has 2947 observations with 564 columns (561 meaurements + 1 subject + 1 code + 1 activity label)
6. Load and tidy train data
    * This is the data for 21 of the subjects in the experiment
    * subject_train.txt is loaded into a data frame named train_subjects
        * This data frame has 7352 observations of subject. There are 21 subjects in total
        * This will become a column in the full dataset
    * y_train.txt is loaded into a data frame named train_activities
        * This data frame has 7352 observations of activity codes. There are 6 activity codes in total
        * This will become a column in the full dataset
        * These codes are joined with activity_labels to give a descriptive name to each activity
    * X_train.txt is loaded into a data frame named train_data
        * This data frame has 7352 observations of 561 measurements
        * This data will make up 561 columns in the full dataset
        * The columns in this data frame are named using the data in the varnames data frame
    * These 3 tables are combined column-wise creating a new data frame train_data_set
        * Each subject is matched to an activity and to 561 measurements
        * train_data_set has 7352 observations with 564 columns (561 meaurements + 1 subject + 1 code + 1 activity label)
7. Merge test and train data
    * test_data_set and train_data_set combined row-wise into the combo table
    * combo has 10299 observations (7352 + 2947)
    * the code column is removed. It is not necessary because the descriptive activity label is included in this data set
8. Extracts only the measurements on the mean and standard deviation
    * The descriptive columns (subject and activity) are retained
    * the 561 variables originally from the features.txt file are narrowed down
    * Only measurements on the mean and standard deviation are kept
    * NOTE: The requirements could have different interpretations here, specifically for "mean"
        * This script takes a strict intepretation of measurements that should be kept. See example below to illustrate:
          * 1 tBodyAcc-mean()-X - kept
          * 375 fBodyAccJerk-meanFreq()-Z - discarded
          * 556 angle(tBodyAccJerkMean),gravityMean) - discarded
    * This results in a data set with 68 columns and 10299 observations
9. Create a tidy dada set with the average of each variable for each activity and each subject
    * Group the combo data set by subject and activity and perform an average of each measurment
    * This results in a tidy data set with 180 observations and 68 columns 
10. Save the final tidy dataset
    * Saved to final.txt in the working directory

The final.txt file


