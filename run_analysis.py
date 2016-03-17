# -*- coding: utf-8 -*-
"""
Created on Thu Feb 25 09:42:24 2016

@author: Janos_Strasszer
"""
import pandas as pd

DATA_DIR = 'c:/Development/PROJECTS/R/GettingAndCleaningData_Coursera/UCI HAR Dataset/'


# 1. Loading all the data files needed
features = pd.read_csv(DATA_DIR+'features.txt', header=None, sep=' ',
                       names=['index', 'feature_name'])
y_train = pd.read_csv(DATA_DIR+'train/y_train.txt', header=None, sep=' ', names=['activity_id'])
y_test = pd.read_csv(DATA_DIR+'test/y_test.txt', header=None, sep=' ', names=['activity_id'])
x_train = pd.read_csv(DATA_DIR+'train/X_train.txt', header=None, delimiter=r'\s+')
x_train.columns = features['feature_name'].values
x_test = pd.read_csv(DATA_DIR+'test/X_test.txt', header=None, delimiter=r'\s+')
x_test.columns = features['feature_name'].values
activity_labels = pd.read_csv(DATA_DIR+'activity_labels.txt', header=None, sep=' ',
                              names=["activity_id", "activity"])
subject_test = pd.read_csv(DATA_DIR+'test/subject_test.txt', header=None, names=["subject"])
subject_train = pd.read_csv(DATA_DIR+'train/subject_train.txt', header=None, names=["subject"])

# 2. Filtering out features that aren't needed
def filter_features(data_to_filter):
    f = list()
    for i in list(data_to_filter.columns):
        if "-std" in i.lower() or ("-mean" in i.lower()):
            f.append(i)
    return data_to_filter[f]

x_train=filter_features(x_train)
x_test=filter_features(x_test)

# 3. Binding x and y together and also subject
x_train['activity_id'] = y_train['activity_id']
x_train['subject'] = subject_train['subject']
x_test['activity_id'] = y_test['activity_id']
x_test['subject'] = subject_test['subject']


# 4. Merging train and test data
data = x_train.append(x_test)

# 4. labeling output column
data = pd.merge(data, activity_labels, on='activity_id', sort=False).drop('activity_id', axis=1)


# 6. save data
data.to_csv(DATA_DIR+'../tidy_data_py.txt', index=False, sep=' ', float_format='%.9f')
output = data.groupby(['subject', 'activity'], as_index=False).mean()
output.to_csv(DATA_DIR+'../tidy_data_means_py.txt', index=False, sep=' ', float_format='%.16f')
