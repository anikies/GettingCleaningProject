###You should create one R script called run_analysis.R that does the following. 
##### 1. Merges the training and the test sets to create one data set.  
###### 1.1 Read de data sets (train and test)
    
    dataTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
    dataTest <- read.table("UCI HAR Dataset/test/X_test.txt")
        
    features <- read.table("UCI HAR Dataset/features.txt")
      
    dataMerge <- rbind(dataTrain, dataTest)

##### 2. Extracts only the measurements on the mean and standard deviation for each measurement.  
###### 2.1 Read de data sets (acivities and subjects)
    trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt")
    trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
    testActivities <- read.table("UCI HAR Dataset/test/y_test.txt")
    testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

###### 2.2 select the fields with the string "mean()" or "std()" 
    titlesWithMean<-grep("\\bmean()\\b", names(dataMerge), value=TRUE)
    titlesWithStd<-grep("\\bstd()\\b", names(dataMerge), value=TRUE)
    
###### 2.3 Put it together in a vector
    titlesFilter <- c(titlesWithMean,titlesWithStd)
    
###### 2.4 Complete a data frame with all the data from the previous data set
    dataMerge <- dataMerge[titlesFilter]
  
##### 2.5 Also complete two auxiliar data frames with all the data from the previous data set
  
    dataTrainFilter<-dataTrain[titlesFilter]
    dataTestFilter<-dataTest[titlesFilter]
 
##### 2.6 Adding all the data from the previous activities and subjects data set
     
    dataTrainFilter$activity <- trainActivities[,]
    dataTrainFilter$subject <- trainSubjects[,]
    dataTestFilter$activity <- testActivities[,]
    dataTestFilter$subject <- testSubjects[,]
  
##### 2.7 Merge the data in a vector
    
    dataFilterActivity<-c(dataTrainFilter$activity,dataTestFilter$activity)
    dataFilterSubject<-c(dataTrainFilter$subject,dataTestFilter$subject)    
    
##### 2.8 Insert the previous data in the data frame "dataMerge"
        dataMerge$activity<-dataFilterActivity
        dataMerge$subject<-dataFilterSubject


#### 3. Uses descriptive activity names to name the activities in the data set  
    
    dataMerge$activity[dataMerge$activity=="1"] <- "WALKING"  
    dataMerge$activity[dataMerge$activity=="2"] <- "WALKING_UPSTAIRS"
    dataMerge$activity[dataMerge$activity=="3"] <- "WALKING_DOWNSTAIRS"
    dataMerge$activity[dataMerge$activity=="4"] <- "SITTING"
    dataMerge$activity[dataMerge$activity=="5"] <- "STANDING"
    dataMerge$activity[dataMerge$activity=="6"] <- "LAYING"

#### 4. Appropriately labels the data set with descriptive variable names.   

    names(dataMerge)<-sub("Acc","Accelerator",names(dataMerge))  
    names(dataMerge)<-sub("Gyro","Gyroscope",names(dataMerge))
    names(dataMerge)<-sub("Mag","Magnitude",names(dataMerge))
    names(dataMerge)<-sub("\\(\\)","",names(dataMerge))  
    
    
#### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.    
##### 5.1 Select the id variables (activity and subject) and the measurements variables (rest) 
    melted <- melt(dataMerge, id.vars=c("activity", "subject"))
    
##### 5.2 Grouping the data by activity and subject and calculate the mean for both groups
    dataGroupAvg<-dcast(melted,activity+subject~variable,mean)
    
##### 5.3 Write de data into a file text named "DatatotalAvg.txt"
    write.table(dataGroupAvg,file="DatatotalAvg.txt",row.name=FALSE)
    
