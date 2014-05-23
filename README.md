GCData_Project
==============

run_analysis.R
--------------

In the first part of the code, we retrieve the necessary information from the train and test sets, and we proceed to bind both sets.

```
trainData.X <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE)
trainData.Y <- read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE)
trainData.subject <- read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE)

testData.X <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)
testData.Y <- read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE)
testData.subject <- read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)

completeData.X <- rbind(trainData.X, testData.X)
completeData.Y <- rbind(trainData.Y, testData.Y)
completeData.subject <- rbind(trainData.subject, testData.subject)
```

In the second part of the code, we extract only those columuns related to the mean and stadard deviation measurements, this according to the feature.txt file.

```
features <- read.table("UCI HAR Dataset/features.txt", header=FALSE)

posMean <- grepl("mean()",features[,2])
posStd <- grepl("std()",features[,2])
pos <- posMean | posStd

selData <- completeData.X[,features[pos,1]]
m <- ncol(selData)
```

In the third step we retrieve the activity names from the activity_labels.txt and assign each activity name to the activity ID in the data. Also we add two more columns to our data set, one for the activity and another for the subject.

```
activityNames <- read.table("UCI HAR Dataset/activity_labels.txt", header=FALSE)
completeData.Y <- as.character(activityNames[completeData.Y[,1],2])
selData <- cbind(selData,completeData.Y,completeData.subject)
colnames(selData)[m+1] <- "activity"
colnames(selData)[m+2] <- "subject"
```

Finally we split our data by activity and subject, getting 180 groups. For each group we must obtain the mean of each one of the variables and store those values in a new data.frame called RES. Also we rename the variable columns of the resulting data set and proceed to save our data set as myData.txt

```
splitData <- split(selData,list(selData$activity, selData$subject))

meanVector <- lapply(splitData[[1]][1:m],mean)
RES <- data.frame(meanVector,activity=splitData[[1]][[m+1]][1], subject=splitData[[1]][[m+2]][1])

for(i in 2:length(splitData))
{
    meanVector <- lapply(splitData[[i]][1:m],mean)
    newRow <- data.frame(meanVector,activity=splitData[[i]][[m+1]][1], subject=splitData[[i]][[m+2]][1])
    RES <-rbind(RES,newRow)
}

colnames(RES)[1:m] <- paste(colnames(RES)[1:m],rep("mean",m))

write.table(RES,file="myData.txt",col.names=TRUE, row.names=FALSE)
```