Coursera_datascience_03_project
===============================

Project assignement For Datascience course 3

This repository contains the script used for the course project for Data science - Getting and Cleanising data.

  A full description of the data used for this script is available at the site where the data was obtained: 
    http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
  The cook book can be found in this repository. It is an adjusted copy of the original README included in the data.
  

The script is store under the filename run_analysis.R

This script will 

1) get the list of files in the file getdata-projectfiles-UCI HAR Dataset.zip (stored in the workin directory)
2) extract the content of activity_labels.txt // features.txt into separated data frames
3) separate the required variables *mean() and *std() from the rest
4) extract the data sets
  4.1) Subject list
  4.2) X.txt (both test and training files) into one data frame (called X in the script), but only the required variables
  4.3) Y.txt (both test and training files) into one data frame (called y in the script), but only the required variables
  
5) replace the activity labels by their related descriptions
6) join the 3 data sets into one (called first_DT)
7) rename the subject and activity columns to "Subject" and "activity" instead of meaningless "V1" and "V2"

8) aggregate the values for the numerical variables into another data frame, grouping by subject and activity
9) clean up the result of the aggregation by removing duplicated columns (3 and 4)
10) rename the subject and activity columns to "Subject" and "activity" instead of "Group.1" and "Group.2"

11) Generate the ouptut of the script, as the file "second_DT.txt" of the working directory

