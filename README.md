# GettingCleaningProject
The script run_analysis does the following:
#### 1. Merges the training and the test sets to create one data set.
##### 1.1. Read de data sets in a data frame

    dataTrain <- read.table("UCI HAR Dataset/train/X_train.txt")  
    dataTest <- read.table("UCI HAR Dataset/test/X_test.txt")  
    features <- read.table("UCI HAR Dataset/features.txt")  
  
##### 1.2 Rename the columns with features data set names  
    titlesWithMean<-grep("\\b[Mm]ean()\\b", names(dataMerge), value=TRUE)  
    titlesWithStd<-grep("\\b[Ss]td()\\b", names(dataMerge), value=TRUE)  
    titlesTotal <- c(titlesWithMean,titlesWithStd)
    dataMerge<-dataMerge[titlesTotal]
#### 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
