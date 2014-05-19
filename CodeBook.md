codebook
========

description of variables
------------------------

trainData.X (data.frame): Training set

trainData.Y (data.frame): Training labels

testData.X (data.frame): Test set

testData.Y (data.frame): Test labels

trainData.subject/testData.subject (data.frame): Subject who performed the activity [1 - 30]

completeData.X (data.frame): Merge of training and test sets

completeData.Y (data.frame): Merge of training and test labels

completeData.subject (data.frame): Subject who performed the activity [1 - 30] (train and test sets together)

features (data.frame): The features obtained by calculating variables from the time and frequency domain

posMean (Logical): Logical vector with TRUE values for mean measurements in features

posStd (Logical): Logical vector with TRUE values for standard deviation measurements in features

pos (Logical): Logical vector with TRUE values for mean and standard deviation measurements in features

selData (data.frame): Subset of "completeData.X" selecting taking only the mean and std measurements indicated by "pos"

m (integer): Number of features (columns) in "selData". Corresponds to the number of mean and std measurements

activityNames (data.frame): Contains the id and name of each activity

splitData (list): List of data frames, "selData" is splitted by activity and by subject

RES (data.frame): Contains the mean of each variable foer every element in "splitData", also contains the activity name and subject id
