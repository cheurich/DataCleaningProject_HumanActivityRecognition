# **GETTING AND CLEANING DATA COURSE PROJECT**

# **CodeBook**

## Project Goal

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis.

## Study design and raw data processing

### Collection of the raw data

The data  was collected from the accelerometers from the Samsung Galaxy S smartphone.
A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

### The original raw data 

The raw data can be downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Creating the tidy data file

### Guide to create the tidy data file

With the help of the *"run_analysis.R"* script you can create the tidy dataset.
To see the exact steps, please follow the comments and commands in the *"run_analysis.R"* script.

### Cleaning of the data

Some getting and cleaning data tasks realized in the *"run_analysis.R"* script are:

* Install and call the needed libraries
* Download the .zip data and save it into a folder named "dataset", than unzip it
* Read the X, Y and subjects train and test datasets from the train and test folders and merge them together to create one data set
* Read the names of the features and add them as column names
* Extract only the measurements on the mean and standard deviation for each measurement into 2 data tables, than merge them together
* Add the columns Subject (the number of the volunteer) and Activity (the descriptive activity names for the labels)
* Appropriately label the data set with descriptive variable names
* From the data set from above, create a second, independent tidy data set with the average of each variable for each activity and each subject. (Group by Subject and Activity and summarize all the variables by mean) 
* Writes the tidy dataset into the *"tidydata.txt"* file

## Variables

The dimension of the tidy dataset: *180 raws* and *89 columns*.

### **Columns/Features**

There are *89 columns/variables* in the tidy datatset.

The *columns [,3:88]* represent the selected mean and standard deviation variables from the raw dataset. They are numerical and the values represent the mean calculated for each activity and each subject.

Furthermore there are added another 3 columns: 
*"Subject"* - the volunteer number (in total a number of 30 volunteers).        
*"Activity"* - the activity on which the measurements were made ("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING").                       
*"Labels"* - the labels of the activity on which the measurements were made (1, 2, 3, 4, 5, 6).

### **Raws/Observations**

There are *180 Raws/Observations* in the tidy data. Grouping by each subject and activity, it gets just 6 observations per volunteer, or just one value per activity and volunteer/subject (30 subjects * 6 activities = 180 Raws).

## Variables list

|Nr.|Variable Name         |Type |Size   |Example Values                  |
|---|:---------------------|:---:|:-----:|:-------------------------------|
|1  |Subject               |int  |[1:180]|1 1 1 1 1 1 2 2 2 2 ...         |
|2  |Activity              |chr  |[1:180]|"LAYING" "SITTING" "STANDING" "WALKING" ...|
|3  |tBodyAccMean()X       |num  |[1:180]|0.222 0.261 0.279 0.277 0.289 ...|
|4  |tBodyAccMean()Y       |num  |[1:180]|-0.04051 -0.00131 -0.01614 -0.01738 -0.00992 ...|
|5  |tBodyAccMean()Z       |num  |[1:180]|-0.113 -0.105 -0.111 -0.111 -0.108 ...|
|6  |tGravityAccMean()X    |num  |[1:180]|-0.249 0.832 0.943 0.935 0.932 ...|
|7  |tGravityAccMean()Y    |num  |[1:180]|0.706 0.204 -0.273 -0.282 -0.267 ...|
|8  |tGravityAccMean()Z    |num  |[1:180]|0.4458 0.332 0.0135 -0.0681 -0.0621 ...|
|9  |tBodyAccJerkMean()X   |num  |[1:180]|0.0811 0.0775 0.0754 0.074 0.0542 ...|
|10 |tBodyAccJerkMean()Y   |num  |[1:180]|0.003838 -0.000619 0.007976 0.028272 0.02965 ...|
|11 |tBodyAccJerkMean()Z   |num  |[1:180]|0.01083 -0.00337 -0.00369 -0.00417 -0.01097 ...|
|12 |tBodyGyroMean()X      |num  |[1:180]|-0.0166 -0.0454 -0.024 -0.0418 -0.0351 ...|
|13 |tBodyGyroMean()Y      |num  |[1:180]|-0.0645 -0.0919 -0.0594 -0.0695 -0.0909 ...|
|14 |tBodyGyroMean()Z      |num  |[1:180]|0.1487 0.0629 0.0748 0.0849 0.0901 ...|
|15 |tBodyGyroJerkMean()X  |num  |[1:180]|-0.1073 -0.0937 -0.0996 -0.09 -0.074 ...|
|16 |tBodyGyroJerkMean()Y  |num  |[1:180]|-0.0415 -0.0402 -0.0441 -0.0398 -0.044 ....|
|17 |tBodyGyroJerkMean()Z  |num  |[1:180]|-0.0741 -0.0467 -0.049 -0.0461 -0.027 ...|
|18 |tBodyAccMagMean()     |num  |[1:180]|-0.8419 -0.9485 -0.9843 -0.137 0.0272 ...|
|19 |tGravityAccMagMean()  |num  |[1:180]|-0.8419 -0.9485 -0.9843 -0.137 0.0272 ..|
|20 |tBodyAccJerkMagMean() |num  |[1:180]|-0.9544 -0.9874 -0.9924 -0.1414 -0.0894 ...|
|21 |tBodyGyroMagMean()    |num  |[1:180]|-0.8748 -0.9309 -0.9765 -0.161 -0.0757 ...|
|22 |tBodyGyroJerkMagMean()|num  |[1:180]|-0.963 -0.992 -0.995 -0.299 -0.295 ...|
|23 |fBodyAccMean()X       |num  |[1:180]|-0.9391 -0.9796 -0.9952 -0.2028 0.0382 ...|
|24 |fBodyAccMean()Y       |num  |[1:180]|-0.86707 -0.94408 -0.97707 0.08971 0.00155 ...|
|25 |fBodyAccMean()Z       |num  |[1:180]|-0.883 -0.959 -0.985 -0.332 -0.226 ...|
|26 |fBodyAccMeanFreq()X   |num  |[1:180]|-0.1588 -0.0495 0.0865 -0.2075 -0.3074 ...|
|27 |fBodyAccMeanFreq()Y   |num  |[1:180]|0.0975 0.0759 0.1175 0.1131 0.0632 ...|
|28 |fBodyAccMeanFreq()Z   |num  |[1:180]|0.0894 0.2388 0.2449 0.0497 0.2943 ...|
|29 |fBodyAccJerkMean()X   |num  |[1:180]|-0.9571 -0.9866 -0.9946 -0.1705 -0.0277 ...|
|30 |fBodyAccJerkMean()Y   |num  |[1:180]|-0.9225 -0.9816 -0.9854 -0.0352 -0.1287 ...|
|31 |fBodyAccJerkMean()Z   |num  |[1:180]|-0.948 -0.986 -0.991 -0.469 -0.288 ...|
|32 |fBodyAccJerkMeanFreq()X|num  |[1:180]|0.132 0.257 0.314 -0.209 -0.253 ...|
|33 |fBodyAccJerkMeanFreq()Y|num  |[1:180]|0.0245 0.0475 0.0392 -0.3862 -0.3376 ...|
|34 |fBodyAccJerkMeanFreq()Z|num  |[1:180]|0.02439 0.09239 0.13858 -0.18553 0.00937 ...|
|35 |fBodyGyroMean()X      |num  |[1:180]|-0.85 -0.976 -0.986 -0.339 -0.352 ...|
|36 |fBodyGyroMean()Y      |num  |[1:180]|-0.9522 -0.9758 -0.989 -0.1031 -0.0557 ...|
|37 |fBodyGyroMean()Z      |num  |[1:180]|-0.9093 -0.9513 -0.9808 -0.2559 -0.0319 ...|
|38 |fBodyGyroMeanFreq()X  |num  |[1:180]|-0.00355 0.18915 -0.12029 0.01478 -0.10045 ...|
|39 |fBodyGyroMeanFreq()Y  |num  |[1:180]|-0.0915 0.0631 -0.0447 -0.0658 0.0826 ...|
|40 |fBodyGyroMeanFreq()Z  |num  |[1:180]|0.010458 -0.029784 0.100608 0.000773 -0.075676 ...|
|41 |fBodyAccMagMean()     |num  |[1:180]|-0.8618 -0.9478 -0.9854 -0.1286 0.0966 ...|
|42 |fBodyAccMagMeanFreq() |num  |[1:180]|0.0864 0.2367 0.2846 0.1906 0.1192 ...|
|43 |fBodyAccJerkMagMean() |num  |[1:180]|-0.9333 -0.9853 -0.9925 -0.0571 0.0262 ...|
|44 |fBodyAccJerkMagMeanFreq()|num  |[1:180]|0.2664 0.3519 0.4222 0.0938 0.0765 ...|
|45 |fBodyGyroMagMean()    |num  |[1:180]|-0.862 -0.958 -0.985 -0.199 -0.186 ....|
|46 |fBodyGyroMagMeanFreq()|num  |[1:180]|-0.139775 -0.000262 -0.028606 0.268844 0.349614 ...|
|47 |fBodyGyroJerkMagMean()|num  |[1:180]|-0.942 -0.99 -0.995 -0.319 -0.282 ...|
|48 |fBodyGyroJerkMagMeanFreq()|num  |[1:180]|0.176 0.185 0.334 0.191 0.19 ...|
|49 |angle(tBodyAccMean,gravity)|num  |[1:180]|0.021366 0.027442 -0.000222 0.060454 -0.002695 ...|
|50 |angle(tBodyAccJerkMean),gravityMean)|num  |[1:180]|0.00306 0.02971 0.02196 -0.00793 0.08993 ...|
|51 |angle(tBodyGyroMean,gravityMean)|num  |[1:180]|-0.00167 0.0677 -0.03379 0.01306 0.06334 ...|
|52 |angle(tBodyGyroJerkMean,gravityMean)|num  |[1:180]|0.0844 -0.0649 -0.0279 -0.0187 -0.04 ...|
|53 |angle(X,gravityMean)  |num  |[1:180]|0.427 -0.591 -0.743 -0.729 -0.744 ...|
|54 |angle(Y,gravityMean)  |num  |[1:180]|-0.5203 -0.0605 0.2702 0.277 0.2672 ...|
|55 |angle(Y,gravityMean)  |num  |[1:180]|-0.3524 -0.218 0.0123 0.0689 0.065 ...|
|56 |tBodyAccStd()X        |num  |[1:180]|-0.928 -0.977 -0.996 -0.284 0.03 ...|
|57 |tBodyAccStd()Y        |num  |[1:180]|-0.8368 -0.9226 -0.9732 0.1145 -0.0319 ...|
|58 |tBodyAccStd()Z        |num  |[1:180]|-0.826 -0.94 -0.98 -0.26 -0.23 ...|
|59 |tGravityAccStd()X     |num  |[1:180]|-0.897 -0.968 -0.994 -0.977 -0.951 ...|
|60 |tGravityAccStd()Y     |num  |[1:180]|-0.908 -0.936 -0.981 -0.971 -0.937 ...|
|61 |tGravityAccStd()Z     |num  |[1:180]|-0.852 -0.949 -0.976 -0.948 -0.896 ...|
|62 |tBodyAccJerkStd()X    |num  |[1:180]|-0.9585 -0.9864 -0.9946 -0.1136 -0.0123 ...|
|63 |tBodyAccJerkStd()Y    |num  |[1:180]|-0.924 -0.981 -0.986 0.067 -0.102 ...|
|64 |tBodyAccJerkStd()Z    |num  |[1:180]|-0.955 -0.988 -0.992 -0.503 -0.346 ...|
|65 |tBodyGyroStd()X       |num  |[1:180]|-0.874 -0.977 -0.987 -0.474 -0.458 ...|
|66 |tBodyGyroStd()Y       |num  |[1:180]|-0.9511 -0.9665 -0.9877 -0.0546 -0.1263 ...|
|67 |tBodyGyroStd()Z       |num  |[1:180]|-0.908 -0.941 -0.981 -0.344 -0.125 ...|
|68 |tBodyGyroJerkStd()X   |num  |[1:180]|-0.919 -0.992 -0.993 -0.207 -0.487 ...|
|69 |tBodyGyroJerkStd()X   |num  |[1:180]|-0.968 -0.99 -0.995 -0.304 -0.239 ...|
|70 |tBodyGyroJerkStd()X   |num  |[1:180]|-0.958 -0.988 -0.992 -0.404 -0.269 ...|
|71 |tBodyAccMagStd()      |num  |[1:180]|-0.7951 -0.9271 -0.9819 -0.2197 0.0199 ...|
|72 |tGravityAccMagStd()   |num  |[1:180]|-0.7951 -0.9271 -0.9819 -0.2197 0.0199 ...|
|73 |tBodyAccJerkMagStd()  |num  |[1:180]|-0.9282 -0.9841 -0.9931 -0.0745 -0.0258 ...|
|74 |tBodyGyroMagStd()     |num  |[1:180]|-0.819 -0.935 -0.979 -0.187 -0.226 ...|
|75 |tBodyGyroJerkMagStd() |num  |[1:180]|-0.936 -0.988 -0.995 -0.325 -0.307 ...|
|76 |fBodyAccStd()X        |num  |[1:180]|-0.9244 -0.9764 -0.996 -0.3191 0.0243 ...|
|77 |fBodyAccStd()Y        |num  |[1:180]|-0.834 -0.917 -0.972 0.056 -0.113 ...|
|78 |fBodyAccStd()Z        |num  |[1:180]|-0.813 -0.934 -0.978 -0.28 -0.298 ...|
|79 |fBodyAccJerkStd()X    |num  |[1:180]|-0.9642 -0.9875 -0.9951 -0.1336 -0.0863 ...|
|80 |fBodyAccJerkStd()Y    |num  |[1:180]|-0.932 -0.983 -0.987 0.107 -0.135 ...|
|81 |fBodyAccJerkStd()Z    |num  |[1:180]|-0.961 -0.988 -0.992 -0.535 -0.402 ...|
|82 |fBodyGyroStd()X       |num  |[1:180]|-0.882 -0.978 -0.987 -0.517 -0.495 ...|
|83 |fBodyGyroStd()X       |num  |[1:180]|-0.9512 -0.9623 -0.9871 -0.0335 -0.1814 ...|
|84 |fBodyGyroStd()X       |num  |[1:180]|-0.917 -0.944 -0.982 -0.437 -0.238 ...|
|85 |fBodyAccMagStd()      |num  |[1:180]|-0.798 -0.928 -0.982 -0.398 -0.187 ...|
|86 |fBodyAccJerkMagStd()  |num  |[1:180]|-0.922 -0.982 -0.993 -0.103 -0.104 ...|
|87 |fBodyGyroMagStd()     |num  |[1:180]|-0.824 -0.932 -0.978 -0.321 -0.398 ...|
|88 |fBodyGyroJerkMagStd() |num  |[1:180]|-0.933 -0.987 -0.995 -0.382 -0.392 ...|
|89 |Labels                |num  |[1:180]|6 4 5 1 3 2 6 4 5 1 ...|
