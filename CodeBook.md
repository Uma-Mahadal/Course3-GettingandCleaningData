CodeBook
---------------------------------------------------------------
This document describes the variables and transformations used by run_analysis.R and the definition of variables in Tidy.txt.

##Dataset Used

This data is obtained from Human Activity Recognition Using Smartphones Data Set. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the dataset used in the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##Input Data Set

The input data containts the following data files

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 


##Transformations

Following are the key transformations that were performed on the input dataset


- The subjects in training and test set data are merged to form 'subjectTestData'
- yTrain, SubjectTrain, and xTrain data are merged to form 'trainingData'
- The activities in training and test set data are merged to form 'activityData'.
- 'features', 'activity' and 'subject' are merged to form 'finalData'.
- 'finalDataWOActivityType' column in 'finalData' is updated with descriptive names of activities taken from 'activityData'. 'Activity' column is expressed as a factor variable.
- Acronyms in variable names in 'finalData', like 'Acc', 'Gyro', 'Mag', ^t, ^f, AccMag, JerkMag, GyroMag are replaced with descriptive labels such as 'Accelerometer', 'Gyroscpoe', 'Magnitude', 'Time' , 'Frequency', AccMagnitude, JerkMagnitude, GyroMagnitude
- 'tidyData' is created as a set with average for each activity and subject of 'finalData'. Entries in 'tidyData' are ordered based on activity and subject.
- Finally, the data in 'tidyData' is written into 'Tidy.txt' with row.names = FALSE as requested.

