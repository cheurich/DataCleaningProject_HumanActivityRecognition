##########################################
# GETTING AND CLEANING DATA COURSE PROJECT
#
# This is the "run_analysis.R" script
##########################################
# Required tasks
##########################################
## Create one R script called run_analysis.R that does the following. 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##########################################

## Install and call the needed libraries
install.packages("data.table")
install.packages("dplyr")
install.packages("tidyverse")
install.packages("stringr") 
library(data.table)
library(dplyr)
library(tidyverse)
library(stringr)

## Downloads the .zip data and saves it into a folder named "dataset", than unzip it
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, dest="dataset.zip", mode="wb") 
unzip ("dataset.zip", exdir = "./dataset")

## Reads the names of the features 
features <- read.table("./dataset/UCI HAR Dataset/features.txt")

## Reads the X train and test datasets from the train and test folders inside the "dataset" folder
X_train <- data.table::fread("./dataset/UCI HAR Dataset/train/X_train.txt")
subject_train <- data.table::fread("./dataset/UCI HAR Dataset/train/subject_train.txt")
X_test <- data.table::fread("./dataset/UCI HAR Dataset/test/X_test.txt")
subject_test <- data.table::fread("./dataset/UCI HAR Dataset/test/subject_test.txt")
#dim(X_train) # 7352  561
#dim(subject_train) # 7352    1
#dim(X_test) # 2947  561
#dim(subject_test) # 2947    1

## Req. 1. Merges the X training and the X test sets to create one data set.
Xdf <- rbind(X_train, X_test) 
#dim(Xdf) # 10299   561

## Sets the featurenames as the column names 
setnames(Xdf, names(Xdf), features$V2)

## Req. 2. Extracts only the measurements on the mean and standard deviation for each measurement into 2 data tables
Xdf_m <- select(Xdf, contains("mean"))
Xdf_sd <- select(Xdf, contains("std"))
#dim(Xdf_m) # 10299    53
#dim(Xdf_sd) # 10299    33

## Binds the columns of the two data tables together
Xdf_msd <- cbind(Xdf_m, Xdf_sd) 
#dim(Xdf_msd) # 10299    86

## Adds an ID column in the merged table 
Xdf_msd <- mutate(Xdf_msd, ID=row_number())

## Merges the rows from the subject train and test data tables together
X_subj <- rbind(subject_train, subject_test)

## Binds the columns of the two data tables together
XDT <- cbind(Xdf_msd, X_subj)
names(XDT)[names(XDT) == "V1"] <- "Subject"

## Merges the Y training and the Y test sets to create one data set.
Y_train <- data.table::fread("./dataset/UCI HAR Dataset/train/y_train.txt")
Y_test <- data.table::fread("./dataset/UCI HAR Dataset/test/y_test.txt")
#dim(Y_train) # 7352    1
#dim(Y_test) # 2947    1

## Merges the rows from the Y train and test data tables together
YDT <- rbind(Y_train, Y_test) 
#dim(YDT) # 10299   1

## Adds an ID column in the YDT table 
YDT <- mutate(YDT, ID=row_number())

## Merges the X and the Y datasets to create one data set, by merging on "ID".
df <- merge(XDT, YDT, by = 'ID', no.dups=TRUE)
#dim(df) # 10299    89

## 3. Uses descriptive activity names to name the activities in the data set
names(df)[names(df) == "V1"] <- "Labels"
df$Activity[df$Labels==1] <- "WALKING"
df$Activity[df$Labels==2] <- "WALKING_UPSTAIRS"
df$Activity[df$Labels==3] <- "WALKING_DOWNSTAIRS"
df$Activity[df$Labels==4] <- "SITTING"
df$Activity[df$Labels==5] <- "STANDING"
df$Activity[df$Labels==6] <- "LAYING"

## 4. Appropriately labels the data set with descriptive variable names. 
names(df) <- gsub("BodyBody", "Body", names(df))
names(df) <- gsub("-", "", names(df))
names(df) <- gsub("mean", "Mean", names(df))
names(df) <- gsub("std", "Std", names(df))

## 5. From the data set in step 4, creates a second, independent tidy data set
## with the average of each variable for each activity and each subject.
tidydf <- group_by(df, Subject, Activity)
tidydf <- summarise_all(tidydf, "mean")
#dim(tidydf) # 180  89

## Removes column ID
tidydf <- tidydf[-grep('ID', colnames(tidydf))]  

## Writes the tidy data table into a .txt file
write.table(tidydf, file="tidydata.txt")
