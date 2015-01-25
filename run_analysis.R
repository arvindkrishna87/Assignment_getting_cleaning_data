#Adding library needed to use the 'melt' function
library(reshape2)

#Reading feature names and activity labels
features<-read.table("./UCI HAR Dataset/features.txt")[,2]
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")

#Reading train data sets
x_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")

#Naming columns of x train data set
names(x_train)=features

#Extracting measurements on the mean and standard deviation for each measurement for x train data set
extract_features<-grepl("mean|std",features)
x_train<-x_train[,extract_features]

#Assigning row id to y train data set so that when the row order gets changed on merging activity lablels, it can be restored by sorting by row id
y_train$id<-1:nrow(y_train)
y_train<-merge(y_train,activity_labels,by="V1")
y_train<-y_train[order(y_train$id),]

#Dropping row id
y_train<-subset(y_train,select=-c(id))

#Naming column names of the y train data set
names(y_train)=c("Activity_id","Activity_label")
names(subject_train)<-"Subject"

#Merging the subject id, activity labels and measurements (on mean and std deviation)
train_data<-cbind(subject_train,y_train,x_train)

#Reading test data sets
x_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")

#Naming columns of x test data set
names(x_test)=features

#Extracting measurements on the mean and standard deviation for each measurement for x test data set
x_test=x_test[,extract_features]

#Assigning row id to y train data set so that when the row order gets changed on merging activity lablels, it can be restored by sorting by row id
y_test$id<-1:nrow(y_test)
y_test=merge(y_test,activity_labels,by.x="V1",by.y="V1")
y_test<-y_test[order(y_test$id),]

#Dropping row id
y_test<-subset(y_test,select=-c(id))

#Naming column names of the y train data set
names(y_test)=c("Activity_id","Activity_label")
names(subject_test)="Subject"

#Merging the subject id, activity labels and measurements (on mean and std deviation)
test_data<-cbind(subject_test,y_test,x_test)

#Combining train and test data sets
data<-rbind(train_data,test_data)

#Melting data and dcasting it to calculate the mean of measurements for each activity and subject
id_labels<-c("Subject","Activity_id","Activity_label")
data_labels<-setdiff(colnames(data),id_labels)
melt_data<-melt(data,id=id_labels,measure.vars=data_labels)  
tidy_data=dcast(melt_data,Subject+Activity_label~variable,mean)

#Exporting tidy data
write.table(tidy_data,file="./tidy_data.txt",row.name=FALSE)
