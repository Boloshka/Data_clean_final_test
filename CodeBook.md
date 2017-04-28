CodeBook for run\_analysis.R
================

Variable names in the final data frame "X\_final"
-------------------------------------------------

For each row: "Activity" - One of six options: Walking, walking downstairs, walking upstairs, sitting, laying, standing

"Subject" - One of 30 subjects

"...mean()" and "...std()" - means and standard deviations of sensors in time and frequency domain

Cleaning the data
-----------------

1.  Read in from "UCI HAR Dataset/train" sub-directory: activity - y\_train.txt, subject - subject\_train.txt and data file - X\_train.txt, repeat same from "UCI HAR Dataset/test" subdirectory and joined them into one data frame: X\_DataSet
2.  Attached meaningful column names from "UCI HAR Dataset/features.txt"
3.  Eliminate duplicates
4.  Form a new data frame "X\_set" that has only variables containing means and standard deviations
5.  Calculating means of each column in a data frame grouped by Activity and Subject and converting resulting list back into data frame, which does not however contain Activity and Subject variables in it
6.  Adding "Activity" and "Subject" to form final data frame X\_final
