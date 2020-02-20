# calling required package
library(plyr)
# library(dplyr)

# creating directory in the working directory 
if (!file.exists("./data")) {dir.create("./data")}

# assigning the Url of the data sets with fileUrl
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# download the zip data sets using download.file
download.file(fileUrl, destfile = "./data/Dataset.zip", method = "curl")

# unzip the data sets
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")

# Assigne the path of the file UCI HAR Dataset with path_ readFile
path_readFile <- file.path("./data/UCI HAR Dataset")

# Listing  the file found in "UCI HAR Dataset" inorder to identify the datas we are using in this project.
list.files(path = path_readFile, all.files = TRUE, recursive = TRUE)

# Reading the Test and Training from the datasets

# Reading the activity file "y_ test.txt" and "y_train.txt" from UCI HAR Dataset and assigned to y_test and Y_train respectivily.
y_test <- read.table(file.path(path_readFile, "test", "y_test.txt"), header = FALSE)
y_train <- read.table(file.path(path_readFile, "train", "y_train.txt" ), header = FALSE)


#  Reading the subject file "subject_test.txt" and "subject_train.txt" from UCI HAR Dataset and assigned to SubjectTest and SubjectTrain respectivily.
SubjectTest <- read.table(file.path(path_readFile, "test", "subject_test.txt"), header = FALSE)
SubjectTrain <- read.table(file.path(path_readFile, "train", "subject_train.txt"), header = FALSE)


# Reading the feature file "x_ test.txt" and "x_train.txt" from UCI HAR Dataset and assigned to x_test and x_train respectivily.
x_test <-  read.table(file.path(path_readFile, "test", "X_test.txt" ), header = FALSE)
x_train <- read.table(file.path(path_readFile, "train", "X_train.txt"), header = FALSE)


# Merging the training and the test sets to create one data set

# Meriging the activity data y_test and y_train by row using rbind and asiigned the bind data with ActivityData
ActivityData <- rbind(y_train, y_test)

#  Meriging the subject data SubjectTest and SubjectTrain by row using rbind and asiigned the bind data with SubjectData
SubjectData <- rbind(SubjectTrain, SubjectTest)

# Merging the feature data x_test and x_train by row using rbind and assigned the bind data with FeatureData
FeatureData <- rbind(x_train, x_test)

# Reading names of the activity from file "activity_labels.txt" from UCI HAR Datasets and assigned file with ActivityDataNames.
ActivityDataNames <- read.table(file.path(path_readFile, "activity_labels.txt"), header = FALSE)

# Match each number in ActivityData with the activity name found in ActivityDataNames
Activity_labels <- as.data.frame (factor(ActivityData$V1, levels = c(1:6), labels = ActivityDataNames$V2))

# Reading the names of feature from file "features.txt" from UCI HAR Datasets and assigned file with FeatureDataNames
FeatureDataNames <- read.table(file.path(path_readFile, "features.txt"), header = FALSE)

# Naming each variable in FeatureData with the correspond names which is found FeatureDataNames column 2
names(FeatureData) <- FeatureDataNames$V2

# Extract the measurements only with the one which has mean() and sd() standard deviation from file FeatureDataNames
# extracted <- grep("mean\\(\\)|std\\(\\)", FeatureDataNames$V2, value = TRUE)
extracted <- grep("mean\\(\\)|std\\(\\)", names(FeatureData), value = TRUE)

# Assigning extracted names with the correspond data in FeatureData and assigned it with FeatureExtracted  
FeatureExtracted <- FeatureData[, extracted]

# Renaming the column names of SubjectData and ActivityData with descriptive name
names(SubjectData) <- c("subject")
names(Activity_labels) <- c("activity")

# combine all the clean and extracted three data by column using cbind and assigned the bind data with clean_combine
Clean_Combine <- cbind(FeatureExtracted, SubjectData, Activity_labels)

# set the working directory 
setwd( "C:/Users/bethk/OneDrive/Documents/Coursera/Quiz File/Getting and Cleaning Data/Getting and cleaning data course project/Getting-and-Cleaning-Data-Course-Project")

# From the clean_ combined datasets tidy data set with average of each variable for each activity and subject
Clean_Combine2 <- aggregate(. ~ subject + activity, Clean_Combine, mean)
Clean_Combine2  <- Clean_Combine2[order(Clean_Combine2$subject, Clean_Combine2$activity),]
write.table(Clean_Combine2, file = "tidy_data.txt", row.names = FALSE)
