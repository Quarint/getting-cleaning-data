## Loading required packages

if (!require("plyr")) {
  install.packages("plyr")
}

if (!require("dplyr")) {
  install.packages("dplyr")
}

require(plyr)
require(dplyr)

## STEP 1 : Merging the training and the test sets to create one data set

# declare the directory name of your data
dirName <- "UCI HAR Dataset"
trainDir <- paste(dirName, "train", sep = "/")
testDir <- paste(dirName, "test", sep = "/")


# load features names
featuresPath <- paste(dirName, "features.txt", sep = "/")
features <- read.table(featuresPath, col.names = c("featureId", "featureName"))
featureNames <- as.character(features$featureName)
featureNames <- gsub("\\(\\)","",featureNames)
featureNames <- gsub("[-,\\(\\)]","_", featureNames)


# load train data
subjectTrainPath <- paste(trainDir, "subject_train.txt", sep = "/")
subjectTrain <- read.table(subjectTrainPath, col.names = "subject_id")
XTrainPath <- paste(trainDir, "X_train.txt", sep = "/")
XTrain <- read.table(XTrainPath, col.names = featureNames)
yTrainPath <- paste(trainDir, "y_train.txt", sep = "/")
yTrain <- read.table(yTrainPath, col.names = "activity")

# assemble train data
trainDf <- cbind(subjectTrain, yTrain, XTrain)

# load test data
subjectTestPath <- paste(testDir, "subject_test.txt", sep = "/")
subjectTest <- read.table(subjectTestPath, col.names = "subject_id")
XTestPath <- paste(testDir, "X_test.txt", sep = "/")
XTest <- read.table(XTestPath, col.names = featureNames)
yTestPath <- paste(testDir, "y_test.txt", sep = "/")
yTest <- read.table(yTestPath, col.names = "activity")

# assemble test data
testDf <- cbind(subjectTest, yTest, XTest)

## Merge train and test data
df <- rbind(trainDf, testDf)

## STEP 2 : Extract only the measurements on the mean and standard deviation for each measurement.
keepcols <- grep("_(mean|std)(_|$)", featureNames, value = TRUE)
keepcols <- c("subject_id", "activity", keepcols)
df <- select(df, keepcols)

## STEP 3  : Use  descriptive activity names to name the activities in the data set

# load activity names
activityPath <- paste(dirName, "activity_labels.txt", sep ="/")
activities <- read.table(activityPath, col.names = c("activityId", "activityName"))
activityNames <- tolower(as.character(activities$activityName))

# replacing activity number by activity name
df <- mutate(df, activity = activityNames[activity])

## STEP 4 : appropriately labels the data set with descriptive variable names

names <- names(df);
names <- gsub("BodyBody", "Body", names)
names <- gsub("^f", "freq", names)
names <- gsub("^t", "time", names)
names <- gsub("([a-z])([A-Z])", "\\1_\\2", names)
names <- tolower(names)
names(df) <- names

## STEP 5 : From the data set in step 4, creates a second, independent tidy data set
## with the average of each variable for each activity and each subject

tidy_df <- ddply(df, c("subject_id", "activity"), numcolwise(mean))

# write the tidy data frame to a file
write.csv(tidy_df, "tidy_data.csv", row.names = FALSE)
