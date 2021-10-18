##########################################
# Human Activity Recognition
##########################################
## Clustering Analysis
##########################################

## Install and call the needed libraries
install.packages("fields")
install.packages("jpeg")
install.packages("datasets")
library(fields)
library(jpeg)
library(datasets)

## The goal is to conduct exploratory data analysis on this data

## Use first the "getting_cleaning_data.R" file to read and clean the data and
## create the "df" dataframe

head(dfr)
dim(dfr) # 10299   564
# There are 10299 measurements/observations (train and test data set together) 
# There are 564 features/columns in the data set
# In addition to the 561 features of the measurements, there are added 3 extra columns
dim(dfr[,562:564])
names(dfr[,562:564]) # "Subject" "Activity_Labels" "Activity"

# How many measurements pro subject (for all the 30 subjects) there are?
table(dfr$Subject)
sum(table(dfr$Subject)) # 10299

# How many measurements pro activity (for all the 6 activities) there are?
table(dfr$Activity)
sum(table(dfr$Activity))

unique(dfr$Activity) # "standing" "sitting"  "laying"   "walk" "walkdown" "walkup" 
# There are 6 activities, 3 passive (laying, standing and sitting) and 
# 3 active which involve walking. Each row is labeled with the
# correct activity (from the 6 possible) and associated with the
# column measurements (from the accelerometer and gyroscope).

# dataframe all subjects
sub_all <- dfr
dim(sub_all) # 10299   564
str(sub_all)

# dataframe subject 1
sub1 <- subset(dfr, Subject==1)
dim(sub1) # 347 564
str(sub1)

# Factorize the activity lables
sub1$Activity <- transform(factor(sub1$Activity))
sub_all$Activity <- transform(factor(sub_all$Activity))

## What kind of data we have, see the first 12 columns
names(sub1[,1:12])

# Plot the first 2 columns by activities
install.packages("png")

png("./images/1Rplot1_BodyAccelerationMeanXY_by_Activities.png")
par(mfrow=c(1, 2), mar = c(6, 4, 4, 1))
plot(sub1[, 1], col = sub1$Activity[,1], ylab = names(sub1)[1])
plot(sub1[, 2], col = sub1$Activity[,1], ylab = names(sub1)[2])
legend("bottomright",legend=unique(sub1$Activity[,1]),col=unique(sub1$Activity[,1]), pch = 1)
title(main= "Body Acceleration mean (X, Y) by Activities (Subject 1)", line= -2, outer=TRUE)
par(mfrow=c(1,1))
dev.off()

png("./images/allRplot1_BodyAccelerationMeanXY_by_Activities.png")
par(mfrow=c(1, 2), mar = c(6, 4, 4, 1))
plot(sub_all[, 1], col = sub_all$Activity[,1], ylab = names(sub_all)[1])
plot(sub_all[, 2], col = sub_all$Activity[,1], ylab = names(sub_all)[2])
legend("bottomright",legend=unique(sub_all$Activity[,1]),col=unique(sub_all$Activity[,1]), pch = 1)
title(main= "Body Acceleration mean (X, Y) by Activities (all Subjects)", line= -2, outer=TRUE)
par(mfrow=c(1,1))
dev.off()

#Clustering
#Create the distance matrix, mdist, of the first 3 columns of sub1

#distance1 subject 1 
sub1 <- subset(dfr, Subject==1)
sub1$Activity <- transform(factor(sub1$Activity))
distanceMatrix1_subject1 <- dist(sub1[,1:3])

#Now create the clustering by distance, using the Euclidean distance
hclustering1 <- hclust(distanceMatrix1_subject1)
hclustering1$labels <- as.character(c(1:347))
#Plot clusters of activity colors
png("./images/2Rplot2_Clustering_activity_colors.png")
myplclust(hclustering1, lab.col=unclass(sub1$Activity[,1]))
dev.off()

#distance1 all subjects
sub_all <- dfr
sub_all$Activity <- transform(factor(sub_all$Activity))
distanceMatrix1_all <- dist(sub_all[,1:3])
hclustering_1 <- hclust(distanceMatrix1_all)
hclustering_1$labels <- as.character(c(1:347))
#Plot clusters of activity colors
png("./images/allRplot2_Clustering_activity_colors.png")
myplclust(hclustering_1, lab.col=unclass(sub_all$Activity[,1]))
dev.off()

#Plot active and passive activity clusters 
#distance2 subject1
distanceMatrix2_subject1 <- dist(sub1[,10:12])
hclustering2 <- hclust(distanceMatrix2_subject1)
hclustering2$labels <- as.character(c(1:347))
png("./images/3Rplot3_Clustering_active_pasive_activities.png")
myplclust(hclustering2, lab.col=unclass(sub1$Activity[,1]))
dev.off()

#distance2 all subjects
distanceMatrix2_all <- dist(sub_all[,10:12])
hclustering_2 <- hclust(distanceMatrix2_all)
hclustering_2$labels <- as.character(c(1:347))
png("./images/allRplot3_Clustering_active_pasive_activities.png")
myplclust(hclustering_2, lab.col=unclass(sub_all$Activity[,1]))
dev.off()

#SVD
#svd subject 1
svd1 <- svd(scale(sub1[,-c(562,564)]))

#LEFT singular vectors of subject 1, U matrix
dim(svd1$u) # 347 347
#We see that the u matrix is a 347 by 347 matrix. 
png("./images/4Rplot4_SVD_U.png")
par(mfrow=c(1, 2), mar = c(6, 4, 4, 1))
plot(svd1$u[, 1], col = sub1$Activity[,1], ylab = names(svd1$u)[1])
plot(svd1$u[, 2], col = sub1$Activity[,1], ylab = names(svd1$u)[2])
legend("bottomright",legend=unique(sub1$Activity),col=unique(sub1$Activity[,1]), pch = 1)
title(main= "SVD - The 2 LEFT singular vectors of U-Matrix (Subject 1)", line= -2, outer=TRUE)
par(mfrow=c(1,1))
dev.off()

#LEFT singular vectors of subject 1, U matrix
svd_all <- svd(scale(sub_all[,-c(562,564)]))
#LEFT singular vectors of all subjects, U matrix
png("./images/allRplot4_SVD_U.png")
par(mfrow=c(1, 2), mar = c(6, 4, 4, 1))
plot(svd_all$u[, 1], col = sub_all$Activity[,1], ylab = names(svd_all$u)[1])
plot(svd_all$u[, 2], col = sub_all$Activity[,1], ylab = names(svd_all$u)[2])
legend("bottomright",legend=unique(sub_all$Activity),col=unique(sub_all$Activity[,1]), pch = 1)
title(main= "SVD - The 2 LEFT singular vectors of U-Matrix (all Subjects)", line= -2, outer=TRUE)
par(mfrow=c(1,1))
dev.off()

# RIGHT singular vectors of subject 1, V matrix
png("./images/5Rplot5_SVD_V.png")
plot(svd1$v[, 2], col = rgb(0, 0, 1, .4), ylab = names(svd1$v)[2], main= "SVD - The second Right singular vector of V-Matrix (Subject 1)")
dev.off()
# RIGHT singular vectors of all subjects, V matrix
png("./images/allRplot5_SVD_V.png")
plot(svd_all$v[, 2], col = rgb(0, 0, 1, .4), ylab = names(svd_all$v)[2], main= "SVD - The second Right singular vector of V-Matrix (all Subjects)")
dev.off()

maxCon_subject1 <- which.max(svd1$v[,2])
maxCon_all <- which.max(svd_all$v[,2])

#distance3 of subject 1
distanceMatrix3_subject1 <- dist(sub1[,c(10:12,maxCon_subject1)])
hclustering3 <- hclust(distanceMatrix3_subject1)
hclustering3$labels <- as.character(c(1:347))
png("./images/6Rplot6_Hierarchical_Clustering_Max.png")
myplclust(hclustering3, lab.col=unclass(sub1$Activity[,1]))
dev.off()

names(sub1[maxCon_subject1]) # "fBodyAcc.meanFreq...Z"

#distance3 of all subjects
distanceMatrix3_all <- dist(sub_all[,c(10:12,maxCon_all)])
hclustering_3 <- hclust(distanceMatrix3_all)
hclustering_3$labels <- as.character(c(1:347))
png("./images/allRplot6_Hierarchical_Clustering_Max.png")
myplclust(hclustering_3, lab.col=unclass(sub_all$Activity[,1]))
dev.off()

names(sub_all[maxCon_all]) # "fBodyAcc.meanFreq...Z"

# k means subject 1
kClust1 <- kmeans(sub1[,-c(562,564)], centers=6)
table(kClust1$cluster, sub1$Activity[,1])
kClust2 <- kmeans(sub1[,-c(562,564)], centers=6, nstart = 100)
table(kClust2$cluster, sub1$Activity[,1])
dim(kClust2$centers) # 6 562

# k means all subjects
kClust_1 <- kmeans(sub_all[,-c(562,564)], centers=6)
table(kClust_1$cluster, sub_all$Activity[,1])
kClust_2 <- kmeans(sub_all[,-c(562,564)], centers=6, nstart = 100)
table(kClust_2$cluster, sub_all$Activity[,1])
dim(kClust_2$centers) # 6 562

#Laying Cluster subject 1table(kClust_2$cluster, sub_all$Activity[,1])
laying <- which(kClust2$size==29)
png("./images/7Rplot7_K-Means_laying.png")
plot(kClust2$centers[1,1:12], pch=19, ylab="Laying Cluster", main = "K-Means Laying Cluster (Subject 1)")
dev.off()

#Laying Cluster all subjects
laying_all <- which(kClust_2$size==1079)
png("./images/allRplot7_K-Means_laying.png")
plot(kClust_2$centers[1,1:12], pch=19, ylab="Laying Cluster", main = "K-Means Laying Cluster (all Subjects)")
dev.off()

names(sub1[,1:3]) # "tBodyAcc.mean...X" "tBodyAcc.mean...Y" "tBodyAcc.mean...Z
  
#Walkdown Cluster subject 1
walkdown <- which(kClust2$size==49)
  
png("./images/8Rplot8_K-Means_walkdown.png")
plot(kClust2$centers[walkdown,1:12], pch=19, ylab="Walkdown Cluster", main = "K-Means Walkdown Cluster (Subject 1)")
dev.off()

#Walkdown Cluster all subjects
walkdown_all <- which(kClust_2$size==668)

png("./images/allRplot8_K-Means_walkdown.png")
plot(kClust_2$centers[5,1:12], pch=19, ylab="Walkdown Cluster", main = "K-Means Walkdown Cluster (all Subjects)")
dev.off()
