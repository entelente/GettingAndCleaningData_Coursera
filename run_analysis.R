# This script is the result of the final assignment for the Getting and Cleaning Data - Coursera course
# Please read additional details in CodeBook.md

# Important: This script assumes that data is downloaded and in the working directory.

# 1. Loading all the data files needed
features <- features <- gsub('(-|\\(\\)|,)', '', toupper(t(read.table('UCI HAR Dataset/features.txt')[2])))   # + Removing index column and cleaning sysmbols from feature names
y_train <- read.table('UCI HAR Dataset/train/y_train.txt')
y_test <- read.table('UCI HAR Dataset/test/y_test.txt')
x_train <- read.table('UCI HAR Dataset/train/X_train.txt')
x_test <- read.table('UCI HAR Dataset/test/X_test.txt')
activity_labels<- read.table('UCI HAR Dataset/activity_labels.txt')
subject_test <- read.table('UCI HAR Dataset/test/subject_test.txt')
subject_train <- read.table('UCI HAR Dataset/train/subject_train.txt')

# 2. Merging train and test data
y_data <- rbind(y_train, y_test)
x_data <- rbind(x_train, x_test)
subject_data <- rbind(subject_train, subject_test)

# 3. labeling y
y_data$rowid <- 1:nrow(y_data) # Adding row id because merging destroy the original order of rows
y_data <- merge(y_data, activity_labels, by="V1")
y_data <- y_data[order(y_data$rowid), ]
y_data <- y_data[, "V2"]

# 4. Filtering out features that aren't needed and naming the columns
filtered_features <- grep("MEAN|STD", features)
x_data <- x_data[, filtered_features]
names(x_data) <- features[filtered_features]

# 5. Binding x and y together
data <- cbind(x_data, y_data, subject_data)
colnames(data)[which(names(data) == "y_data")] <- "ACTIVITY"
colnames(data)[which(names(data) == "V1")] <- "SUBJECT"

# 6. save data: tidy_data.txt
write.table(data, file="tidy_data.txt", row.names = FALSE)

# 7. create averages and save data: tidy_data_means.txt
library(data.table)
dataTable <- data.table(data)
output <- dataTable[, lapply(.SD, mean), by=c("SUBJECT", "ACTIVITY")]
write.table(output, file="tidy_data_means.txt", row.names = FALSE)

