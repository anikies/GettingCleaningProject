  library(dplyr)      
  library(reshape2)
### You should create one R script called run_analysis.R that does the following. 
##### 1. Merges the training and the test sets to create one data set.  
###### 1.1 Read de data sets (train and test)
    dataTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
    dataTest <- read.table("UCI HAR Dataset/test/X_test.txt")
    
    features <- read.table("UCI HAR Dataset/features.txt")
  
    tidyset.1 <- rbind(dataTrain, dataTest)
    
##### 2. Extracts only the measurements on the mean and standard deviation for each measurement.  
###### 2.1 Read de data sets (acivities and subjects)  
    colnames(tidyset.1) <- features[,2]
    colnames(dataTrain) <- features[,2]
    colnames(dataTest) <- features[,2]
    
    trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt")
    trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
    testActivities <- read.table("UCI HAR Dataset/test/y_test.txt")
    testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

###### 2.2 select the fields with the string "mean()" or "std()" 
    titlesWithMean<-grep("\\b[Mm]ean()\\b", names(tidyset.1 ), value=TRUE)
    titlesWithStd<-grep("\\b[Ss]td()\\b", names(tidyset.1 ), value=TRUE)

###### 2.3 Put it together in a vector
    titlesFilter <- c(titlesWithMean,titlesWithStd)
    
###### 2.4 Complete a data frame with all the data from the previous data set    
    tidyset.1 <- tidyset.1[titlesFilter]

###### 2.5 Also complete two auxiliar data frames with all the data from the previous data set
    dataTrainFilter<-dataTrain[titlesFilter]
    dataTestFilter<-dataTest[titlesFilter]
 
###### 2.6 Adding all the data from the previous activities and subjects data set
    dataTrainFilter$activity <- trainActivities[,]
    dataTrainFilter$subject <- trainSubjects[,]
    dataTestFilter$activity <- testActivities[,]
    dataTestFilter$subject <- testSubjects[,]
    
###### 2.7 Merge the data in a vector 
    dataFilterActivity<-c(dataTrainFilter$activity,dataTestFilter$activity)
    dataFilterSubject<-c(dataTrainFilter$subject,dataTestFilter$subject)

###### 2.8 Insert the previous data in the data frame "dataMerg    
    tidyset.1$activity<-dataFilterActivity
    tidyset.1$subject<-dataFilterSubject

#### 3. Uses descriptive activity names to name the activities in the data set  
    tidyset.1$activity[tidyset.1$activity=="1"] <- "WALKING"
    tidyset.1$activity[tidyset.1$activity=="2"] <- "WALKING_UPSTAIRS"
    tidyset.1$activity[tidyset.1$activity=="3"] <- "WALKING_DOWNSTAIRS"
    tidyset.1$activity[tidyset.1$activity=="4"] <- "SITTING"
    tidyset.1$activity[tidyset.1$activity=="5"] <- "STANDING"
    tidyset.1$activity[tidyset.1$activity=="6"] <- "LAYING"

#### 4. Appropriately labels the data set with descriptive variable names.  
    names(tidyset.1)<-sub("Acc","Accelerator",names(tidyset.1))  
    names(tidyset.1)<-sub("Gyro","Gyroscope",names(tidyset.1))
    names(tidyset.1)<-sub("Mag","Magnitude",names(tidyset.1))
    names(tidyset.1)<-sub("\\(\\)","",names(tidyset.1))  

##### Output the dataset
    tidyset.1
    
#### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.    
###### 5.1 Select the id variables (activity and subject) and the measurements variables (rest)   
    melted <- melt(dataSet.1 ,id.vars=c("activity", "subject"))
    tidyset<-dcast(melted,activity+subject~variable,mean)
 
    write.table(tidyset,file="tidyset.txt",row.name=FALSE) 
