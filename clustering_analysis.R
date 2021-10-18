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

sub1 <- subset(dfr, Subject==1)
dim(sub1) # 347 564
str(sub1)

# Factorize the activity lables
sub1$Activity <- transform(factor(sub1$Activity))

## What kind of data we have, see the first 12 columns
names(sub1[,1:12])

# Plot the first 2 columns by activities
install.packages("png")

png("./images/Rplot1_BodyAccelerationMeanXY_by_Activities.png")
par(mfrow=c(1, 2), mar = c(6, 4, 4, 1))
plot(sub1[, 1], col = sub1$Activity[,1], ylab = names(sub1)[1])
plot(sub1[, 2], col = sub1$Activity[,1], ylab = names(sub1)[2])
legend("bottomright",legend=unique(sub1$Activity[,1]),col=unique(sub1$Activity[,1]), pch = 1)
title(main= "Body Acceleration mean (X, Y) by Activities", line= -2, outer=TRUE)
par(mfrow=c(1,1))
dev.off()

#Clustering
#Create the distance matrix, mdist, of the first 3 columns of sub1

#for ploting distance
sub1 <- subset(dfr, Subject==1)
mdist1 <- dist(sub1[,1:3])

#Now create the clustering by distance, using the Euclidean distance
hclustering1 <- hclust(mdist1)
hclustering1$labels <- as.character(c(1:347))
#Plot clusters of activity colors
png("./images/Rplot2_Clustering_activity_colors.png")
myplclust(hclustering1, lab.col=unclass(sub1$Activity[,1]))
dev.off()

#Plot active and passive activity clusters 
mdist2 <- dist(sub1[,10:12])
hclustering2 <- hclust(mdist2)
hclustering2$labels <- as.character(c(1:347))

png("./images/Rplot3_Clustering_active_pasive_activities.png")
myplclust(hclustering2, lab.col=unclass(sub1$Activity[,1]))
dev.off()

svd1 <- svd(scale(sub1[,-c(562,564)]))

#LEFT singular vectors of sub1, U matrix
dim(svd1$u) # 347 347

#We see that the u matrix is a 347 by 347 matrix. 

png("./images/Rplot4_SVD_U.png")
par(mfrow=c(1, 2), mar = c(6, 4, 4, 1))
plot(svd1$u[, 1], col = sub1$Activity[,1], ylab = names(svd1$u)[1])
plot(svd1$u[, 2], col = sub1$Activity[,1], ylab = names(svd1$u)[2])
legend("bottomright",legend=unique(sub1$Activity),col=unique(sub1$Activity[,1]), pch = 1)
title(main= "SVD - The 2 LEFT singular vectors of U-Matrix", line= -2, outer=TRUE)
par(mfrow=c(1,1))
dev.off()

png("./images/Rplot5_SVD_V.png")
plot(svd1$v[, 2], col = rgb(0, 0, 1, .4), ylab = names(svd1$v)[2], main= "SVD - The second Right singular vector of V-Matrix")
dev.off()

maxCon <- which.max(svd1$v[,2])

mdist3 <- dist(sub1[,c(10:12,maxCon)])

hclustering3 <- hclust(mdist3)
hclustering3$labels <- as.character(c(1:347))

png("./images/Rplot6_Hierarchical_Clustering_Max.png")
myplclust(hclustering3, lab.col=unclass(sub1$Activity[,1]))
dev.off()

names(sub1[maxCon]) # "fBodyAcc.meanFreq...Z"

kClust <- kmeans(sub1[,-c(562,564)], centers=6)
  
table(kClust$cluster, sub1$Activity[,1])
  
kClust2 <- kmeans(sub1[,-c(562,564)], centers=6, nstart = 100)

table(kClust2$cluster, sub1$Activity[,1])

dim(kClust2$centers) # 6 562
  
laying <- which(kClust2$size==29)

png("./images/Rplot7_K-Means_laying.png")
plot(kClust2$centers[laying,1:12][1,1:12], pch=19, ylab="Laying Cluster", main = "K-Means Laying Cluster")
dev.off()

names(sub1[,1:3]) # "tBodyAcc.mean...X" "tBodyAcc.mean...Y" "tBodyAcc.mean...Z
  
walkdown <- which(kClust2$size==49)
  
png("./images/Rplot8_K-Means_walkdown.png")
plot(kClust2$centers[walkdown,1:12], pch=19, ylab="Walkdown Cluster", main = "K-Means Walkdown Cluster")
dev.off()