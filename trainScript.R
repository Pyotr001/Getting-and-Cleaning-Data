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


# Tidy Data and the Assignment
        # https://class.coursera.org/getdata-031/forum/thread?thread_id=113
narrow <- mtcars[, c("cyl", "gear", "vs", "mpg")]
narrow

library(reshape2)
wide1 <- tidied <- dcast(narrow, cyl + gear ~ vs, max)
wide1

wide2 <- tidied <- dcast(narrow, cyl + vs ~ gear, max)
wide2

notverywide <- aggregate(mpg ~ gear + vs + cyl, data = narrow, max)
notverywide

untidy <- with(narrow, tapply(mpg, list(cyl, vs, gear), max))
untidy

# расплющиваем данные
library(reshape2)
datamelt <- melt(data, id.vars = c("subject", "activity"))

# Подсчитываем средние
castdata <- dcast(datamelt,   formula = subject ~ activity, mean) 
        # Среднее по всем переменным вмесе для контроля


# разделяем данные
splitdatamelt <- split(datamelt, datamelt$variable)

# Список фреймов. Каждый фрейм - переменная
dcastapplydata <- lapply(splitdatamelt, dcast,   formula = subject ~ activity, mean)


# матрицы и массивы
ar1 <- array(data = c(1:16), dim = c(4,4))
ar2 <- array(data = c(1:16), dim = c(4,4))
colnames(ar1) <- c("A","B","D","E")
colnames(ar2) <- c("C","A","E","B")
# get the common names between the matrices
same <- intersect(colnames(ar1), colnames(ar2))
# join them together
rbind(ar1[,same], ar2[,same])


library(abind)
adata <- abind(dcastapplydata, rev.along=0)

library(abind)
adata <- abind(dcastapplydata, rev.along=0)adata[,4,]

adata[,"WALKING",]
adata[,"WALKING",fBodyAccJerk.std...Z]
adata[,"WALKING","fBodyAccJerk.std...Z"]



# первая версия

tidyMatrix <- acast(datamelt, formula=variable ~ subject ~ activity, mean)
# более прямой способ создания многомерной матрицы

# Список фреймов. Каждый элемент списка фрейм с данными по одной из переменных
dcastapplydata <- lapply(splitdatamelt, dcast, formula = subject ~ activity, mean)




library(abind) # библиотека для соединения многомерных масивов
adata <- abind(dcastapplydata, rev.along=0) 

rownames(adata) <- 1:30
# добавил имена, так как dimnames[1] выдавал [NULL], через dimnames нельзя поменять
# поменять имена, если значение NULL - пишет, что длина не совпадает
# но сработало и dimnames(adata)[[1]] <- 1:30 (двойные кавычки)
# в одинарных кавычках выдает список c одним элементом NULL

adata <- adata[,-1,] # нужно удалить одни слой, так как он заполнен значениями
# из названийй испытуемых
save(adata, file="adata.RData") # 
load("adata.RData")


# From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.

# расплющиваем данные
library(reshape2)
datamelt <- melt(data, id.vars = c("subject", "activity"))
#Создаём расплавленную форму. Все переменные, которые не id предполагаются
# как данные



# разделяем данные
splitdatamelt <- split(datamelt, datamelt$variable)
# получаем список фреймов

tidyData <- dcast(datamelt, formula=variable + subject ~ activity, mean)

write.table(tidyData, file = "data.txt", row.names = F)


# data <- read.table("data.txt", header = T)




