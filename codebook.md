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
    * features.txt is loaded into a table named varnames. 
        * varnames has 561 rows and 2 columns. 
        * The first column is position and goes from 1 to 561
        * The second column is a descpritive name for the measurements. These are not unique however.
        * A concatenaction of these two columns will be used to give descriptive names to the measurements in the test and train data sets. 
    * activity_labels.txt is loaded into a table named activity_labels
        * activity_labels has 6 rows and 2 columns
        * This is a mapping between the activity codes used in the y_train.txt and y_test.txt files and a descriptive activity name
5. Load and tidy test data
    * This is the data for 9 of the subjects in the experiment
    * subject_test.txt is loaded into a table named test_subjects
        * This table has 2947 observations of subject
    * 
6. Load and tidy train data
7. Merge test and train data
8. Extracts only the measurements on the mean and standard deviation
9. Create a tidy dada set with the average of each variable for each activity and each subject
10. Save the final tidy dataset




## 
test_subjects <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
test_activities <- read.table("./data/UCI HAR Dataset/test/Y_test.txt", 
                         colClasses = "factor", col.names = "code") %>%
  left_join(activity_labels)
test_data <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
names(test_data) <- paste(varnames$V2,varnames$V1)
test_data_set <- cbind(test_subjects, test_activities, test_data)

## 
train_subjects <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
train_activities <- read.table("./data/UCI HAR Dataset/train/Y_train.txt", 
                              colClasses = "factor", col.names = "code") %>%
  left_join(activity_labels)
train_data <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
names(train_data) <- paste(varnames$V2,varnames$V1)
train_data_set <- cbind(train_subjects, train_activities, train_data)

## 
combo <- bind_rows(test_data_set, train_data_set) %>% select(-code)

## 
combo_mean_std <- select(combo, subject, activity, matches("mean[^A-Z]|std", ignore.case = F))

## 
final <- group_by(combo_mean_std, activity, subject) %>%
  summarise_each(funs(mean))

## 
write.table(final, file = "./final.txt")
