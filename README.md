
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

________________________________________________________________
This script starts with assumption that Sumsung data is available in the working directory in an unzipped "UCI HAR Dataset" directory.

The script "run_analysis.R" uploads files from "UCI HAR Dataset" directory with the time and frequency domain variables from the accelerometer and from the gyroscope for each of the six activities performed by each subject.
There are two subdirectories ("test" and "train") in "UCI HAR Dataset" directory. Each subdirectory contains information from test data set and train data set respectively.  


1. The script uploads files "X_test.txt" and "X_train.txt" with domain variables (561 variables in each data set) from the correspondent subdirectories.

2. Two data sets are merged (the new data set contains 561 variables and 10 299 observations)

3. The script uploads file "features.txt" which contains names of the variables from the above data set

4. The script uploads files "Y_test.txt" and "Y_train.txt" with the information about the performed of activities (code of activities) from the correspondent subdirectories. Two sets are merged into one vector (so, we get a vector of length=10 299) and add the vector as a column to the data set with domain variables.

5. The script uploads files "subject_test.txt" and "subject_train.txt" with the information about the subject that performed activities from the correspondent subdirectories. Two sets are merged into one vector (so, we get a vector of length=10 299) and add the vector as a column to the data set with domain variables.

Thus, we have a data set with 10 299 observations: each row represents measurements for each person for each of the 6 activities.

6. The script exclude all variables exept mean and standard deviation for each measurement. Thus, we get 66  measurements and 10 299 observation.

7. The script adjust variable names to readable version (for instance, t-> Time, f-> Frequency, Acc->Accelerometer, Gyro->Gyroscope) to have an understanding what kind of measuarements are performed. The full description of variables please see in CodeBook.md.

8. The new data set is performed with the information about average of each variable for each activity and each subject. Thus, we get data set of 180 observations (30 persons * 6 activities) and 66 measurements (68 columns in data frame including subject and activity). The data set is downloaded into the file "output_data.txt" into the "UCI HAR Dataset" directory. 



