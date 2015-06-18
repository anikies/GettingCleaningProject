projectCoursera <- function(){
  # Crear variables de los dataframes trainData, testData y features
  # Recorrer el dataframe feature
  # Cambiar el nombre la primera columna de trainData y testData por el primer valor de features


  #if (nrow(dataTrain) == 0 && nrow(dataTest) == 0 &&  nrow(features) == 0) {
    dataTrain <- read.table("train/X_train.txt")
    dataTest <- read.table("test/X_test.txt")
    features <- read.table("features.txt")
  #}
 
    colnames(dataTrain) <- features[,2]
    colnames(dataTest) <- features[,2]
  
  #Se añaden los valores de actividades y participantes a dataTrain y dataTest

  #if (nrow(trainActivities) == 0)  {
    trainActivities <- read.table("train/y_train.txt")
    trainSubjects <- read.table("train/subject_train.txt")
    testActivities <- read.table("test/y_test.txt")
    testSubjects <- read.table("test/subject_test.txt")
  #}

  dataTrain$activity <- trainActivities
  dataTrain$subject <- trainSubjects
  dataTest$activity <- testActivities
  dataTest$subject <- testSubjects
  
    #Busco nombres de columna que tengan "mean()"
  titlesWithMean<-grep("\\b[Mm]ean()\\b", names(dataTest), value=TRUE)
  titlesWithStd<-grep("\\b[Ss]td()\\b", names(dataTest), value=TRUE)
  #print (titlesWithMean)  
  #print (titlesWithStd)
  titlesTotal <- c(titlesWithMean,titlesWithStd)
  dataTrain[titlesTotal]
}