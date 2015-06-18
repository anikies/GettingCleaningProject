# GettingCleaningProject
The script run_analysis does the following:
#### 1. Merges the training and the test sets to create on tye data set.
##### 1.1. Read de data sets in a data frame

    dataTrain <- read.table("UCI HAR Dataset/train/X_train.txt")  
    dataTest <- read.table("UCI HAR Dataset/test/X_test.txt")  
    features <- read.table("UCI HAR Dataset/features.txt") 
    dataMerge <- rbind(dataTrain, dataTest)  
    colnames(dataMerge) <- features[,2]
    
#### 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

    titlesWithMean<-grep("\\b[Mm]ean()\\b", names(dataMerge), value=TRUE)  
    titlesWithStd<-grep("\\b[Ss]td()\\b", names(dataMerge), value=TRUE)  
    titlesTotal <- c(titlesWithMean,titlesWithStd)
    dataMerge<-dataMerge[titlesTotal]
    
#### 3. Uses descriptive activity names to name the activities in the data set


##### 3.1. Read de data sets in a data frame
    trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt")
    trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
    testActivities <- read.table("UCI HAR Dataset/test/y_test.txt")
    testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

##### 3.2 Add columns with activities and subjects data set names to dataMerge data frame     
    activities<-rbind(trainActivities,testActivities) 
    dataMerge$activity <- activities
    
    subjects<-rbind(trainSubjects,testSubjects)
    dataMerge$subject <- subjects
    
##### 3.3. Rename activity names
    dataMerge$activity[dataMerge$activity=="1"] <- "WALKING"  
    dataMerge$activity[dataMerge$activity=="2"] <- "WALKING_UPSTAIRS"
    dataMerge$activity[dataMerge$activity=="3"] <- "WALKING_DOWNSTAIRS"
    dataMerge$activity[dataMerge$activity=="4"] <- "SITTING"
    dataMerge$activity[dataTotal$activity=="5"] <- "STANDING"
    dataMerge$activity[dataMerge$activity=="6"] <- "LAYING"
  
#### 4. Appropriately labels the data set with descriptive variable names.                                       
    names(dataMerge$activity)<-sub("Acc","Accelerator",names(dataMerge$activity))  
    names(dataMerge$activity)<-sub("Gyro","Gyroscope",names(dataMerge$activity))
    names(dataMerge$activity)<-sub("Mag","Magnitude",names(dataMerge$activity))
    names(dataMerge$activity)<-sub("\\(\\)","",names(dataMerge$activity))  
    
