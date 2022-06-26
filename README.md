# ProjectGettingAndCleaningDataCourse
Project for third Course(Getting and Cleaning Data) of Data science Specialization offered by Jonh Hopkin University

The R script (run_analysis.R) aim to work with raw data, inside data folder, for cleaning, combining and transforming them for obtain a tidy data set for future works.

Step 1:
For merging Training and Test set first need is to load the group of file for train/test (inside data folder), for combining them and create test/train data set and then merge it.

Step2:
For extracting the "mean" and "std" feature is possible to select all column names of data set that cointain the word "mean" or "std"

Step3:
For renaming activity with proper labeling, it's enough to read the file activity_labels.txt and use the resulting labels for change "activity" feature

Step4:
Labeling that data set in a proper way is possible by appliyng some substitution by regular expresion and sub() function

Step5:
Appling melt() and dcast() function is possible to obtain a tidy data set with the average of each variable for each activity and each subject.