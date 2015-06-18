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

##### 3.1 Rename the columns with activities and subjects data set names      
    activities<-rbind(trainActivities,testActivities) 
    dataMerge$activity <- activities
    
    subjects<-rbind(trainSubjects,testSubjects)
    dataMerge$subject <- subjects
