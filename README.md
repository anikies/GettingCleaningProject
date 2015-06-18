# GettingCleaningProject
###The script run_analysis does the following:
#### 1. Merges the training and the test sets to create on tye data set.
##### 1.1. Read de data sets in a data frame
#### 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#### 3. Uses descriptive activity names to name the activities in the data set
##### 3.1. Read de data set activities in a data frame
##### 3.2 Add columns with activities data set names to dataMerge data frame  
##### 3.3. Rename activity names
#### 4. Appropriately labels the data set with descriptive variable names.                                       
#### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
##### 5.1. Read de data set subjects in a data frame for each activity and each subject. 
#### 5.2 Add column with subjects data set names to dataMerge data frame         


    dataTrain <- read.table("UCI HAR Dataset/train/X_train.txt")  
    dataTest <- read.table("UCI HAR Dataset/test/X_test.txt")  
    
    features <- read.table("UCI HAR Dataset/features.txt") 
    
    trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt")
    trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
    
    testActivities <- read.table("UCI HAR Dataset/test/y_test.txt")
    testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
    
    colnames(dataTrain) <- features[,2]
    colnames(dataTest) <- features[,2]

    titlesWithMean<-grep("\\b[Mm]ean()\\b", names(dataMerge), value=TRUE)  
    titlesWithStd<-grep("\\b[Ss]td()\\b", names(dataMerge), value=TRUE)  
    titlesTotal <- c(titlesWithMean,titlesWithStd)


    dataTrainFilter<-dataTrain[titlesTotal]
    dataTestFilter<-dataTest[titlesTotal]

    dataTrainFilter$activity <- trainActivities[,]
    dataTrainFilter$subject <- trainSubjects[,]
    dataTestFilter$activity <- testActivities[,]
    dataTestFilter$subject <- testSubjects[,]

    dataMerge <- rbind(dataTrainFilter, dataTestFilter)

    dataMerge$activity[dataMerge$activity=="1"] <- "WALKING"  
    dataMerge$activity[dataMerge$activity=="2"] <- "WALKING_UPSTAIRS"
    dataMerge$activity[dataMerge$activity=="3"] <- "WALKING_DOWNSTAIRS"
    dataMerge$activity[dataMerge$activity=="4"] <- "SITTING"
    dataMerge$activity[dataMerge$activity=="5"] <- "STANDING"
    dataMerge$activity[dataMerge$activity=="6"] <- "LAYING"
  

    names(dataMerge)<-sub("Acc","Accelerator",names(dataMerge))  
    names(dataMerge)<-sub("Gyro","Gyroscope",names(dataMerge))
    names(dataMerge)<-sub("Mag","Magnitude",names(dataMerge))
    names(dataMerge)<-sub("\\(\\)","",names(dataMerge))  

    testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
    trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")  
    

    melted <- melt(dataMerge, id.vars=c("activity", "subject"))
    dataGroupAvg<-dcast(melted,activity+subject~variable,mean)
    write.table(dataGroupAvg,file="Datatotal.txt",row.name=FALSE)
    
