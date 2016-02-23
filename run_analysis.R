##  Setup
setwd("~/DataScienceCert/03-Getting and Cleaning Data/Project")
if (!file.exists("data")) {
  dir.create("data")
}
library(dplyr)

## Download files [if necessary]
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("./data/dataset.zip")) {
  download.file(url, destfile = "./data/dataset.zip")
}

## Unzip files [if necessary]
if (!file.exists("./data/UCI HAR Dataset")) {
  unzip("./data/dataset.zip", exdir = "./data")
}

## Load variable names and activity labels
## varnames will be used to label the dataset with descriptive variable names
## activity_labels will be used to name the activities in the data set
varnames <- read.table("./data/UCI HAR Dataset/features.txt")
di

## Load and tidy test data
test_subjects <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
test_activities <- read.table("./data/UCI HAR Dataset/test/Y_test.txt", 
                         colClasses = "factor", col.names = "code") %>%
  left_join(activity_labels)
test_data <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
names(test_data) <- paste(varnames$V2,varnames$V1)
test_data_set <- cbind(test_subjects, test_activities, test_data)

## Load and tidy train data
train_subjects <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
train_activities <- read.table("./data/UCI HAR Dataset/train/Y_train.txt", 
                              colClasses = "factor", col.names = "code") %>%
  left_join(activity_labels)
train_data <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
names(train_data) <- paste(varnames$V2,varnames$V1)
train_data_set <- cbind(train_subjects, train_activities, train_data)

## Merge test and train data
combo <- bind_rows(test_data_set, train_data_set) %>% select(-code)

## Extracts only the measurements on the mean and standard deviation
combo_mean_std <- select(combo, subject, activity, matches("mean[^A-Z]|std", ignore.case = F))

## Create a tidy dada set with the average of each variable for each activity and each subject
final <- group_by(combo_mean_std, activity, subject) %>%
  summarise_each(funs(mean))

## Save the final tidy dataset
write.table(final, file = "./final.txt")
