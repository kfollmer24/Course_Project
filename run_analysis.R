## COURSE PROJECT FOR GETTING AND CLEANING DATA
setwd("C:/Users/kfollmer/Documents/R/Data Science Course/Getting and Cleaning Data/UCI HAR Dataset")

# Read data relevant to all data
varNames <- read.table("features.txt", header = FALSE, sep ="")
varNames <- varNames[,2]
actNames <- read.table("activity_labels.txt", header=FALSE, sep="")  

# Read train data
setwd("./train")
X_train <- read.table("X_train.txt", header = FALSE, sep ="")
Y_train <- read.table("Y_train.txt", header = FALSE, sep ="")
subject_train <- read.table("subject_train.txt", header = FALSE, sep ="")

# add colnames
colnames(X_train) <- varNames

# combine train data
XY_train <- cbind(type="train",subject_train,Y_train,X_train)

# Read test data
setwd("../test")
X_test <- read.table("X_test.txt", header = FALSE, sep ="")
Y_test <- read.table("Y_test.txt", header = FALSE, sep ="")

# add colnames
colnames(X_test) <- varNames

subject_test <- read.table("subject_test.txt", header = FALSE, sep ="")
XY_test <- cbind(type="test",subject_test,Y_test,X_test)

######################################################
# STEP 1  merge test and training data                                           #
######################################################
master <- rbind(XY_train, XY_test)
names(master)[2] <- "subject"
names(master)[3] <- "activity"


######################################################
# STEP 2 -- Extracts only the measurements on the    #
# mean and standard deviation for each measurement   #                                        #
######################################################
library(dplyr)
masterDF <- tbl_df(master)
master2 <- masterDF[,-1]  #take out first column
subset <- masterDF[4:564]
rm(master) # to avoid confusion
meanSD <- rbind(sapply(subset,mean),sapply(subset, sd))

######################################################
# STEP 3 -- Add descriptive labels back              #
######################################################

names(actNames)[1] <- "activity"

# activity column needs to be same type in both data
master2$activity <- as.numeric(master2$activity)

## use a left join as a 'vlookup'
labeled <- left_join(master2,actNames)

## replace activity name in column 2
labeled[,2] <- labeled[,564]
final <- labeled[,1:563]

######################################################
# STEP 4 -- See lines 15-16, 26-27                   #
######################################################

########################################################
# STEP 5 -- From the data set in step 4, creates a     #   
# second, independent tidy data set with the average of#
# each variable for each activity and each subject.    #
########################################################

mean <- aggregate(final[3:563], by = list(Subject = final$subject, Activity = final$activity), FUN=mean, na.rm=TRUE)
write.table(mean, file = "Course_Project_Step5.txt", row.names = FALSE)
