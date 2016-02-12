CodeBook
===
Janos Strasszer
---
This file described how to replicate the results presented in this repository. The R code for the is all presented in the file [run_analysis.R](/run_analysis.R).

Instructions
---
1. Make sure that data.table package is installed for R
2. Manually download data set from the internet (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
3. Unzip data set to the working directory
4. Run run_analysis.R script
5. Enjoy the result

Input
---
Input data is coming from the accelerometer of Samsung Galaxy S devices during various activities of test subjects.

* features.txt : Names for the input features (561)
* X_train.txt, X_test.txt : 10299 rows of input data, one column for each feature
* subject_train.txt, subject_test.txt : 10299 rows of subject IDs
* y_train.txt, y_test.txt : 10299 rows of activity IDs 
* activity_labels.txt : Assigns a textual description for each activity IDs (6)

Output
---
* tidy_data.txt : aggregated and cleaned data
* tidy_data_means.txt : calculated means for each activity of each test subject.

Transformations
---
For additional details please check the corresponding code part in run_analysis.R

1. Loading all the data files needed
2. Merging train and test data
3. labeling y
4. Filtering out features that aren't needed and naming the columns
5. Binding x and y together
6. save data: tidy_data.txt
7. create averages and save data: tidy_data_means.txt

