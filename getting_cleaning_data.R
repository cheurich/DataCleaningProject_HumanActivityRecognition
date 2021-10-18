##########################################
# Human Activity Recognition
##########################################
## Getting and cleaning data 
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

## Reads the X train and test datasets from the train and test folders inside the "dataset" folder
X_train <- data.table::fread("./dataset/UCI HAR Dataset/train/X_train.txt")
subject_train <- data.table::fread("./dataset/UCI HAR Dataset/train/subject_train.txt")
X_test <- data.table::fread("./dataset/UCI HAR Dataset/test/X_test.txt")
subject_test <- data.table::fread("./dataset/UCI HAR Dataset/test/subject_test.txt")
#dim(X_train) # 7352  561
#dim(subject_train) # 7352    1
#dim(X_test) # 2947  561
#dim(subject_test) # 2947    1

##  Merges the X training and the X test sets to create one (X-features) data set.
Xdf <- rbind(X_train, X_test) 
#dim(Xdf) # 10299   561

## Reads the names of the features 
features <- read.table("./dataset/UCI HAR Dataset/features.txt")

## Duplicated variables: bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
duplicated(features$V2)

## Appropriately labels the duplicated column names 
# "fBodyAcc-bandsEnergy()" from [303:344] are duplicated
features$V2[303:316] <- paste(features$V2[303:316],"00", sep="-")
features$V2[317:330] <- paste(features$V2[317:330],"01", sep="-")
features$V2[331:344] <- paste(features$V2[331:344],"02", sep="-")
# "fBodyAccJerk-bandsEnergy()" from [382:423] are duplicated
features$V2[382:395] <- paste(features$V2[382:395],"00", sep="-")
features$V2[396:409] <- paste(features$V2[396:409],"01", sep="-")
features$V2[410:423] <- paste(features$V2[410:423],"02", sep="-")
# "fBodyGyro-bandsEnergy()" from [461:502] are duplicated
features$V2[461:474] <- paste(features$V2[461:474],"00", sep="-")
features$V2[475:488] <- paste(features$V2[475:488],"01", sep="-")
features$V2[489:502] <- paste(features$V2[489:502],"02", sep="-")
#duplicated(features$V2) # all FALSE = no duplicated anymore
#duplicated(names(df))

## Sets the featurenames as the column names 
setnames(Xdf, names(Xdf), features$V2)
head(Xdf)

## Creates the column "ID": Adds an ID column in the merged table 
Xdf <- mutate(Xdf, ID=row_number())
head(Xdf)

## Merges the rows from the subject train and test data tables together
X_subj <- rbind(subject_train, subject_test)

## Creates the column "Subject": Binds the columns of the two data tables together
XDT <- cbind(Xdf, X_subj)
names(XDT)[names(XDT) == "V1"] <- "Subject"
head(XDT)

# Read the labeled train and test data sets
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
dfr <- merge(XDT, YDT, by = 'ID', no.dups=TRUE)
#dim(dfr) # 10299    565

## Creates the column "Activity_Labels": 
names(dfr)[names(dfr) == "V1"] <- "Activity_Labels"

## Creates the column "Activity":
dfr <- mutate(dfr, Activity=Activity_Labels)
## Uses descriptive activity names to name the activities in the data set
#laying  sitting standing     walk walkdown   walkup
dfr$Activity[dfr$Activity==1] <- "walk"
dfr$Activity[dfr$Activity==2] <- "walkup"
dfr$Activity[dfr$Activity==3] <- "walkdown"
dfr$Activity[dfr$Activity==4] <- "sitting"
dfr$Activity[dfr$Activity==5] <- "standing"
dfr$Activity[dfr$Activity==6] <- "laying"

## Removes column ID
dfr <- dfr[,2:565]

head(dfr)
dim(dfr) # 10299   564
dfr <- as.data.frame(dfr)

#####################################
## Tidy Data
#####################################

## Extracts only the measurements on the mean and standard deviation for each measurement into 2 data tables
df_m <- select(dfr, contains("mean"))
df_sd <- select(dfr, contains("std"))
#dim(df_m) # 10299    53
#dim(df_sd) # 10299    33

## Binds the columns of the two data tables together
df_msd <- cbind(df_m, df_sd) 
#dim(df_msd) # 10299    86

## Adds the columns Subject, Activity_Labels and Activity
df_msd <- cbind(df_msd, dfr[,563:564])

## Appropriately labels the data set with descriptive variable names. 
names(df_msd) <- gsub("BodyBody", "Body", names(df_msd))
names(df_msd) <- gsub("-", "", names(df_msd))
names(df_msd) <- gsub("mean", "Mean", names(df_msd))
names(df_msd) <- gsub("std", "Std", names(df_msd))

## From the data set in step 4, creates a second, independent tidy data set
## with the average of each variable for each activity and each subject.
tidydf <- group_by(df_msd, dfr$Subject, dfr$Activity)
tidydf <- summarise_all(tidydf, "mean")
#dim(tidydf) # 180  89

## Writes the tidy data table into a .txt file
write.table(tidydf, file="tidydata.txt")
