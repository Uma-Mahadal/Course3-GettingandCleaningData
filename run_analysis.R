######################
## Coursera - RProgramming - Course 3 - Getting and Cleaning Data Course Project
## Uma S
## runAnalysis.r - This script will perform the following 5 parts on the UCI HAR Dataset zip file
## Part 1 - Merge the training and test sets to create one data set.
## Part 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
## Part 3 - Uses descriptive activity names to name the activities in the data set
## Part 4 - Appropriately labels the data set with descriptive variable names
## Part 5 - From the result above, creates a second, independent tidy data set with the average of each variable
## for each activity and each subject

#####################
## Set the working directory to where the UCI HAR dataset zip file is placed in the system
setwd("F:/Coursera/RProgramming-Course3-Getting and Cleaning Data/UCI HAR Dataset");

## Read and import the data from the files
featuresData = read.table('./features.txt', header = FALSE);
activityData = read.table('./activity_labels.txt', header = FALSE);
subjectTraining = read.table('./train/subject_train.txt', header = FALSE);
xTraining = read.table('./train/x_train.txt', header=FALSE);
yTraining = read.table('./train/y_train.txt', header=FALSE);

# Assigning column names for the above imported data
colnames(activityData) = c('activityId', 'activityType');
colnames(subjectTraining) = "subjectId";
colnames(xTraining) = featuresData[,2];
colnames(yTraining) = "activityId";

# merging yTraining, subjectTraining and xTraining
trainingData = cbind(yTraining,subjectTraining,xTraining);

#Read / Import the test data
subjectTestData = read.table('./test/subject_test.txt', header=FALSE);
xTestData = read.table('./test/x_test.txt',header=FALSE);
yTestData = read.table('./test/y_test.txt',header=FALSE);

#Assigning column names to the test data imported above
colnames(subjectTestData) = "subjectId";
colnames(xTestData) = featuresData[,2];
colnames(yTestData) = "activityId";

#Create the final test set
testData = cbind(yTestData, subjectTestData, xTestData);

#Combine training data and test data for creating the final data set
finalData = rbind(trainingData,testData);

colNames = colnames(finalData);

### Part 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
# create a logicalVector that contains values for the ID, mean, and stddev col and FALSE for others

logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));

# Subset finalData table based on the logicalVector to keep only desired columns
finalData = finalData[logicalVector==TRUE];

# Part 3 - Uses descriptive activity names to name the activities in the data set
# Merge the finalData set with the acitivityType table to include descriptive activity names
finalData = merge(finalData,activityData,by='activityId',all.x=TRUE);

# Updating the colNames to include the new column names after merge
colNames  = colnames(finalData); 

# Part 4 - Appropriately labels the data set with descriptive variable names

for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

# Reassigning the new descriptive column names to the finalData set
colnames(finalData) = colNames;

## Part 5 - From the result above, creates a second, independent tidy data set with the average of each variable
## for each activity and each subject

# Create a new table, finalDataWOActivityType without the activityType column
finalDataWOActivityType  = finalData[,names(finalData) != 'activityType'];

# Summarizing the finalDataNoActivityType table to include just the mean of each variable for each activity and each subject
tidyData    = aggregate(finalDataWOActivityType[,names(finalDataWOActivityType) != c('activityId','subjectId')],by=list(activityId=finalDataWOActivityType$activityId,subjectId = finalDataWOActivityType$subjectId),mean);

# Merging the tidyData with activityType to include descriptive acitvity names
tidyData    = merge(tidyData,activityData,by='activityId',all.x=TRUE);

# Export the tidyData set 
#write.table(tidyData, './tidyData.txt',row.names=TRUE,sep='\t');
write.table(tidyData, './tidyData.txt',row.names=FALSE);



