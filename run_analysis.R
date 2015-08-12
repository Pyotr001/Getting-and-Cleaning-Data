# You should create one R script called run_analysis.R that does the following. 

# Merges the training and the test sets to create one data set.
data <- rbind((read.table("UCI HAR Dataset/test/X_test.txt")), 
              (read.table("UCI HAR Dataset/train/X_train.txt")))

# Appropriately labels the data set with descriptive variable names. 

dataNames <- read.table("UCI HAR Dataset/features.txt")
names(data) <- make.names(dataNames[[2]], unique = TRUE)

# Extracts only the measurements on the mean and standard deviation for each measurement.
meanCol <- grep("mean\\(\\)", dataNames[[2]])
stdCol <- grep("std\\(\\)", dataNames[[2]])
Tidydata <- data[c(meanCol, stdCol)]

# Uses descriptive activity names to name the activities in the data set

subject <- rbind(read.table("UCI HAR Dataset/test/subject_test.txt"),
                 read.table("UCI HAR Dataset/train/subject_train.txt"))
names(subject) <- "subject"

activity <-  rbind(read.table("UCI HAR Dataset/test/subject_test.txt"),
                   read.table("UCI HAR Dataset/train/subject_train.txt"))
names(activity) <- "activity"

data <- cbind(subject, activity, data)
# From the data set in step 4, creates a second, independent tidy data set with 
        # the average of each variable for each activity and each subject.

