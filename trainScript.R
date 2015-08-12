dataXtest <- read.csv("UCI HAR Dataset/test/X_test.txt", sep = "")
datafwf <- read.fwf("UCI HAR Dataset/test/X_test.txt") 
datatable<- read.table("UCI HAR Dataset/test/X_test.txt") 
#csv предназначено для запятых в разделителях, а CSV2 для запятых в числах,
# где раздетель двоеточие

dataY <- read.csv("UCI HAR Dataset/test/Y_test.txt")

#Работет правильно:
dataXtable <- read.table("UCI HAR Dataset/test/X_test.txt")
dataXtrain <- read.table("UCI HAR Dataset/train/X_train.txt")

# попробую идти по порядку, затем поменяю логику.
# соединение таблиц.
data <- rbind(dataXtest, dataXtrain)

grep("mean", dataNames[[2]])
dataNames[2]
testVector <- c("a", "ab", "c")
grep("a", testVector)
grepl("a", testVector)

meanCol <- grep("mean\\(\\)", dataNames[[2]])
stdCol <- grep("std\\(\\)", dataNames[[2]])
Tidydata <- data[c(meanCol, stdCol)]

# для переименовывания
names(data) <- dataNames[[2]]
names(data) <- make.names(dataNames[[2]], unique = TRUE)
make.names(names, unique = FALSE, allow_ = TRUE)
dataNames <- cbind(dataNames, make.names(dataNames[[2]], unique = TRUE))

# дабавить перменные 
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject <- c(subjectTest, subjectTrain)

activityTest <-  read.table("UCI HAR Dataset/test/y_test.txt")
activityTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
names(activityTest) <- "activity"



# цепляю имена к фактору
activity <- factor(activity[[1]], levels = activityLabels[[1]], labels = activityLabels[[2]])
