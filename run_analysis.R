##This script starts with assumption that Sumsung data is available in the working directory
##in an unzipped "UCI HAR Dataset" directory

##To run the script "data.table", "reshape" and "dplyr" packages should be installed

##The output data.frame called "DF_final" corresponds to the steps ## 1-4 of the assignment
##The output data.frame called "DF_new" corresponds to the step ## 5 of the assignment


library(data.table)
library(dplyr)
library(reshape)

##reading files with the measurements 
DF_test_x<-read.table("./UCI HAR Dataset/test/X_test.txt")
DF_train_x<-read.table("./UCI HAR Dataset/train/X_train.txt")

##merging test and train data 
DF_x<-rbind(DF_test_x,DF_train_x)

##labling data columns
DF_features<-read.table("./UCI HAR Dataset/features.txt")
colnames(DF_x)<-as.character(DF_features$V2)

## adding information about the subject and activity
DF_test_subject<-read.table("./UCI HAR Dataset/test/subject_test.txt")
DF_train_subject<-read.table("./UCI HAR Dataset/train/subject_train.txt")
DF_subject<-rbind(DF_test_subject,DF_train_subject)
colnames(DF_subject)<-c("Subject")
DF_test_y<-read.table("./UCI HAR Dataset/test/y_test.txt")
DF_train_y<-read.table("./UCI HAR Dataset/train/y_train.txt")
DF_y<-rbind(DF_test_y,DF_train_y)
colnames(DF_y)<-c("Activity")
DF_intermediate<-cbind(DF_subject,DF_y,DF_x)

##extracting only the measurements on the mean and standard deviation for each measurement
DF_final<-DF_intermediate[ , grepl("Subject", colnames(DF_intermediate))|grepl("Activity", colnames(DF_intermediate))|grepl("mean()", colnames(DF_intermediate),fixed=TRUE)|grepl("std()", colnames(DF_intermediate),fixed=TRUE)]

##changing descriptive activity names to name the activities in the data set
DF_activities<-read.table("./UCI HAR Dataset/activity_labels.txt")

for (i in 1:nrow(DF_activities)) {
 indexes<-(DF_final$Activity == as.integer(DF_activities[[i,1]]))
 DF_final$Activity[indexes]<-as.character(DF_activities[[i,2]])
}
   

##adjusting variable names
colnames(DF_final)<-gsub("Acc","Accelerometer",colnames(DF_final),fixed=TRUE)
colnames(DF_final)<-gsub("Gyro","Gyroscope",colnames(DF_final),fixed=TRUE)
colnames(DF_final)<-gsub("BodyBody","Body",colnames(DF_final),fixed=TRUE)

for (i in 1:ncol(DF_final)) {
    if (substr(colnames(DF_final)[i],1,1)=="t") {colnames(DF_final)[i]<-sub("t","Time",colnames(DF_final)[i])}
    if (substr(colnames(DF_final)[i],1,1)=="f") {colnames(DF_final)[i]<-sub("f","Frequency",colnames(DF_final)[i])}
    }

##creating an independent tidy data set with the average of each variable for each activity and each subject.
DF_final$sub_act<-paste(as.character(DF_final$Subject),as.character(DF_final$Activity))
DF_new<-sapply(split(DF_final,DF_final$sub_act),function(x) colMeans(x[,3:68]))
DF_new<-as.data.frame(t(DF_new))
DF_new$temp<-vector("character",length=180)
DF_new$temp<-c(rownames(DF_new))
DF_new<-cbind(colsplit(DF_new$temp, "[ ]", names=c("Subject", "Activity")),DF_new[,1:66])

##writing down in the file 
write.table(DF_new,"./UCI HAR Dataset/output_data.txt",row.names=FALSE)




