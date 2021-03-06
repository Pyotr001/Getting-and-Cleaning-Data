# You should create one R script called run_analysis.R that does the following. 

# Merges the training and the test sets to create one data set.
data <- rbind((read.table("UCI HAR Dataset/test/X_test.txt")), 
              (read.table("UCI HAR Dataset/train/X_train.txt")))
        #1st - test, 2nd - train

        # load and merge subject 
subject <- rbind(read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject"),
                 read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject"))


        # load  and merge activity
activity <- rbind(read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity"),
                   read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity"))


# Appropriately labels the data set with descriptive variable names. 
dataNames <- read.table("UCI HAR Dataset/features.txt")
names(data) <- make.names(dataNames[[2]], unique = TRUE)



# Extracts only the measurements on the mean and standard deviation for 
        # each measurement.
meanCol <- grep("mean\\(\\)", dataNames[[2]])
stdCol <- grep("std\\(\\)", dataNames[[2]])
data <- data[c( meanCol, stdCol)] # 

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

library(reshape2)
datamelt <- melt(data, id.vars = c("subject", "activity"))
tidyData <- dcast(datamelt, formula=variable + subject ~ activity, mean)
write.table(tidyData, file = "data.txt", row.names = F)


# data <- read.table("data.txt", header = T)

