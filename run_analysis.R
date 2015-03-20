#Set the working directory
setwd("C:/Users/6217473/Desktop/Coursera/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")

###############################################################################################
#STEP1: Merges the training and the test sets to create one data set

testX <- read.table("./test/X_test.txt")
testY <- read.table("./test/y_test.txt")

trainX <- read.table("./train/X_train.txt")
trainY <- read.table("./train/y_train.txt")

testSubject <- read.table("./test/subject_test.txt")
trainSubject <- read.table("./train/subject_train.txt")

dataX <- rbind(trainX, testX)
dataY <- rbind(trainY, testY)
subject <- rbind(trainSubject, testSubject)

###############################################################################################
#STEP2: Extracts only the measurements on the mean and standard deviation for each measurement. 
#install and load necessary package library

feature <- read.table("./features.txt")
install.packages("plyr")
library(plyr)

measurement <- grep("-(mean|std)\\(\\)", feature[, 2])

#Check the result 
feature[measurement,]
X <- dataX[,measurement]

###############################################################################################
#STEP3: Uses descriptive activity names to name the activities in the data set

activity <- read.table("./activity_labels.txt")
dataY[, 1] <- activity[dataY[, 1], 2]
names(dataY) <- "activity"

###############################################################################################
#STEP4: Appropriately labels the data set with descriptive variable names 

names(subject) <- "subject"
names(X) <- feature[measurement,2]

ADS <- cbind(X, dataY, subject)

###############################################################################################
#STEP5: From the data set in step 4, creates a second, 
#independent tidy data set with the average of each variable for each activity and each subject.

tidy_ads <- ddply(ADS, .(subject, activity), function(x) colMeans(x[,1:66]))
write.table(tidy_ads, "tidy_dataset.txt")

result <- read.table("tidy_dataset.txt")

