GettingCleaningDataProject
==========================

Repo for Course Project for Getting and Cleaning Data
Version 1.0
==================================================================

Maciej Gajewski

==================================================================

run_analysis.R script contains all the logic. It uses 2 packages dplyr & reshape2. 
 - First activity_labels.txt, features.txt, training data & test data is read inside R into variables.
 - Next training & test sets are merged together
 - All data sets are given descriptive labels especially variable names from the main data file are cleaned to get rid of unspoorted symbols
 - Measurements on the mean and standard deviation are extracted for further processing
 - Activities are given descriptive names
 - Next independent data set is created with the averages of each variable for each activity and each subject. This is done using 3 different methods. 
   2nd method was selected to output the result to the file because it gives the clean look at the data. It presents the data in melted long format
   with each feature and its average in its own row.
   Other two methods outputs the wide form of the set. They can be more usefull for some kind of processing but might be not that readable.
