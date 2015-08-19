# You should create one R script called run_analysis.R that does the following. 

# Merges the training and the test sets to create one data set.
data <- rbind((read.table("UCI HAR Dataset/test/X_test.txt")), 
              (read.table("UCI HAR Dataset/train/X_train.txt")))
        #1st - test, 2nd - train

        # load and merge subject 
subject <- rbind(read.table("UCI HAR Dataset/test/subject_test.txt"),
                 read.table("UCI HAR Dataset/train/subject_train.txt"))
names(subject) <- c("subject")

        # load  and merge activity
activity <- rbind(read.table("UCI HAR Dataset/test/y_test.txt"),
                   read.table("UCI HAR Dataset/train/y_train.txt"))
names(activity) <- c("activity")

# Appropriately labels the data set with descriptive variable names. 
dataNames <- read.table("UCI HAR Dataset/features.txt")
names(data) <- make.names(dataNames[[2]], unique = TRUE)



# Extracts only the measurements on the mean and standard deviation for 
        # each measurement.
meanCol <- grep("mean\\(\\)", dataNames[[2]])
stdCol <- grep("std\\(\\)", dataNames[[2]])
data <- data[c( meanCol, stdCol)] # выбираю колонки из фрейма

#  data merge
data <- cbind(subject, activity, data)

# Uses descriptive activity names to name the activities in the data set?
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", 
                             colClasses = c("integer", "character"))
data$activity <- factor(activity[[1]], levels = activityLabels[[1]], 
                   labels = activityLabels[[2]])
data$subject <- as.factor(data$subject)


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

# Список фреймов. Каждый элемент списка фрейм с данными по одной из переменных
dcastapplydata <- lapply(splitdatamelt, dcast, formula = subject ~ activity, mean)

library(abind) # библиотека для соединения многомерных масивов
adata <- abind(dcastapplydata, rev.along=0) 

rownames(adata) <- 1:30
# добавил имена, так как dimnames[1] выдавал [NULL], через dimnames нельзя поменять
        # поменять имена, если значение NULL - пишет, что длина не совпадает

adata <- adata[,-1,] # нужно удалить одни слой, так как он заполнен значениями
        # из названийй испытуемых