# Getting and Cleaning Data

This project include run_analysis.R scirpt which and read the downloaded files and clean up the data and write in to a text file named tidy_data.txt

Script requires reshape2 library to run and which will perform below tasks while running

Read both the train and test datasets and merge them into memory variables.

Load the feature, activity info and extract columns named 'mean'(-mean) and 'standard'(-std). Also, modify column names to meaningful names.

Generate 'Tidy Dataset' that consists of the average (mean) of each variable for each subject and each activity. finally save the data set to a file named tidy_dataset.txt.
