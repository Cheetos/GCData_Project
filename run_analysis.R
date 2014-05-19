############################################################################
# Step 1. Load train and test sets and merge them in a single data set
# stored in the variable completeData
############################################################################

trainData.X <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE)
trainData.Y <- read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE)
trainData.subject <- read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE)

testData.X <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)
testData.Y <- read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE)
testData.subject <- read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)

completeData.X <- rbind(trainData.X, testData.X)
completeData.Y <- rbind(trainData.Y, testData.Y)
completeData.subject <- rbind(trainData.subject, testData.subject)

############################################################################
# Step 2. Extract only the measurements of the mean and standard deviation
# for each measurement and store it in "selData"
############################################################################

features <- read.table("UCI HAR Dataset/features.txt", header=FALSE)

posMean <- grepl("mean()",features[,2])
posStd <- grepl("std()",features[,2])
pos <- posMean | posStd

selData <- completeData.X[,features[pos,1]]
m <- ncol(selData)

############################################################################
# Step 3. Replace the activity id for its corresponding activity label
############################################################################

activityNames <- read.table("UCI HAR Dataset/activity_labels.txt", header=FALSE)
completeData.Y <- as.character(activityNames[completeData.Y[,1],2])
selData <- cbind(selData,completeData.Y,completeData.subject)
colnames(selData)[m+1] <- "activity"
colnames(selData)[m+2] <- "subject"

############################################################################
# Step 4, 5. Split the data by activity and subject and calculate the mean
# of each variable for every group, there is a total of 180 groups
# (6 activities) x (30 subjects).
#
# The data is stored in "RES" and column names are updated.
############################################################################

splitData <- split(selData,list(selData$activity, selData$subject))

meanVector <- lapply(splitData[[1]][1:m],mean)
RES <- data.frame(meanVector,activity=splitData[[1]][[m+1]][1], subject=splitData[[1]][[m+2]][1])

for(i in 2:length(s))
{
    meanVector <- lapply(splitData[[i]][1:m],mean)
    newRow <- data.frame(meanVector,activity=splitData[[i]][[m+1]][1], subject=splitData[[i]][[m+2]][1])
    RES <-rbind(RES,newRow)
}

colnames(RES)[1:m] <- paste(colnames(RES)[1:m],rep("mean",m))

write.table(RES,file="myData.txt",col.names=FALSE, row.names=FALSE)

