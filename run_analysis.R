library(dplyr)
#----Read in train and data set and merge them. Note: to replicate, please insert your path to the files------------------------------
X_tr <- read.table(file = "/home/leon/New path/Data_science/UCI HAR Dataset/train/X_train.txt",dec = ".",colClasses = "numeric")
X_train_activity <- read.table(file = "/home/leon/New path/Data_science/UCI HAR Dataset/train/y_train.txt",colClasses = "numeric")
X_train_subject <- read.table(file = "/home/leon/New path/Data_science/UCI HAR Dataset/train/subject_train.txt",colClasses = "numeric")
X_train <- cbind(X_train_activity,X_train_subject,X_tr)

X_tst <- read.table(file = "/home/leon/New path/Data_science/UCI HAR Dataset/test/X_test.txt",dec = ".",colClasses = "numeric")
X_test_activity <- read.table(file = "/home/leon/New path/Data_science/UCI HAR Dataset/test/y_test.txt",colClasses = "numeric")
X_test_subject <- read.table(file = "/home/leon/New path/Data_science/UCI HAR Dataset/test/subject_test.txt",colClasses = "numeric")
X_test <- cbind(X_test_activity,X_test_subject,X_tst)
X_DataSet <- rbind(X_train,X_test)
#------------------------------------------------------------------------

#----Attaching column names from "features.txt". Note: to replicate, please insert your path to the file -----------------------------
New_names_table <- read.table(file = "/home/leon/New path/Data_science/UCI HAR Dataset/features.txt")
New_names <- as.vector(New_names_table$V2)
#---Renaming column names in X_DataSet into the names from New_names-------------
colnames(X_DataSet) =c("Activity","Subject",New_names)
#--------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------

X_DataSet <- X_DataSet[ !duplicated(names(X_DataSet)) ] #Eliminate duplicates

#----Forming new data set with means and standard deviations variables only------------
Chosen_names = c("Activity","Subject",names(X_DataSet[grepl("mean|std",names(X_DataSet))]))
X_set = select(X_DataSet,one_of(Chosen_names))
#-------------------------------------------------------------------------------

#---Calculating means of each column in a data frame grouped by Activity and Subject and converting into data frame------
S = split(X_set,list(X_set$Activity,X_set$Subject))
X_set_new = lapply(S,function(v) {colMeans(v[,3:length(Chosen_names)])})
X_new = t(as.data.frame(X_set_new))
#------------------------------------------------------------------------------------------

#---Adding "Activity" and "subject" to form final data frame---
Activity_level = c("walking","walking_upstairs","walking_downstairs","sitting","standing","laying")
num_rep = nrow(X_new)/length(Activity_level)
Activity = rep(Activity_level,num_rep)
Subject = rep(1:30, each = 6)
X_final = cbind(Activity,Subject,X_new)
#--------------------------------------------------------------------------------------------