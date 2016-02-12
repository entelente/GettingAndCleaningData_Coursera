# This script is the result of the final assignment for the Getting and Cleaning Data - Coursera course
# Please read additional details in CodeBook.md

# Important: This script assumes that data is downloaded and in the working directory.

# 1. Loading all the data files needed
features <- features <- gsub('(-|\\(\\)|,)', '', toupper(t(read.table('UCI HAR Dataset/features.txt')[2])))   # + Cleaning sysmbols from feature names
y_train <- read.table('UCI HAR Dataset/train/y_train.txt')
y_test <- read.table('UCI HAR Dataset/test/y_test.txt')
X_train <- read.table('UCI HAR Dataset/train/X_train.txt')
X_test <- read.table('UCI HAR Dataset/test/X_test.txt')
activity_labels<- read.table('UCI HAR Dataset/activity_labels.txt')[2] # + Removing trivial index column