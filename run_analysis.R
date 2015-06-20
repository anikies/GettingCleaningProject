  library(dplyr)      
  library(reshape2)
  
    dataTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
    dataTest <- read.table("UCI HAR Dataset/test/X_test.txt")
    
    features <- read.table("UCI HAR Dataset/features.txt")
  
    dataSet.1 <- rbind(dataTrain, dataTest)
  
    colnames(dataSet.1) <- features[,2]
    colnames(dataTrain) <- features[,2]
    colnames(dataTest) <- features[,2]
    
    trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt")
    trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
    testActivities <- read.table("UCI HAR Dataset/test/y_test.txt")
    testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

    titlesWithMean<-grep("\\b[Mm]ean()\\b", names(dataSet.1 ), value=TRUE)
    titlesWithStd<-grep("\\b[Ss]td()\\b", names(dataSet.1 ), value=TRUE)

    titlesTotal <- c(titlesWithMean,titlesWithStd)
    
    dataSet.1 <- dataSet.1[titlesTotal]
  
    dataTrainFilter<-dataTrain[titlesTotal]
    dataTestFilter<-dataTest[titlesTotal]
 
    dataTrainFilter$activity <- trainActivities[,]
    dataTrainFilter$subject <- trainSubjects[,]
    dataTestFilter$activity <- testActivities[,]
    dataTestFilter$subject <- testSubjects[,]
 
    dataFilterActivity<-c(dataTrainFilter$activity,dataTestFilter$activity)
    dataFilterSubject<-c(dataTrainFilter$subject,dataTestFilter$subject)
    
    dataSet.1$activity<-dataFilterActivity
    dataSet.1$subject<-dataFilterSubject
 
    dataSet.1$activity[dataSet.1$activity=="1"] <- "WALKING"
    dataSet.1$activity[dataSet.1$activity=="2"] <- "WALKING_UPSTAIRS"
    dataSet.1$activity[dataSet.1$activity=="3"] <- "WALKING_DOWNSTAIRS"
    dataSet.1$activity[dataSet.1$activity=="4"] <- "SITTING"
    dataSet.1$activity[dataSet.1$activity=="5"] <- "STANDING"
    dataSet.1$activity[dataSet.1$activity=="6"] <- "LAYING"
  
    names(dataSet.1)<-sub("Acc","Accelerator",names(dataSet.1))  
    names(dataSet.1)<-sub("Gyro","Gyroscope",names(dataSet.1))
    names(dataSet.1)<-sub("Mag","Magnitude",names(dataSet.1))
    names(dataSet.1)<-sub("\\(\\)","",names(dataSet.1))  
  
    dataSet.1
    
    melted <- melt(dataSet.1 ,id.vars=c("activity", "subject"))
    dataSet.5<-dcast(melted,activity+subject~variable,mean)
 
    write.table(dataSet.5,file="DataGroupAvg.txt",row.name=FALSE) 
