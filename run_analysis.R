##1. Merge Train and Test data into one datat set

##1.1 get data from train datatsets
trainData <- read.table("./dataset/train/X_train.txt")
dim(trainData) ##7352 obs. and 561 variables
trainLabel <- read.table("./dataset/train/y_train.txt") ##7352 obs and one variable
table(trainLabel)
trainSubject <- read.table("./dataset/train/subject_train.txt")  ##7352 obs and one variable

##1.2 get data from test datatsets
testData <- read.table("./dataset/test/X_test.txt")
dim(testData) # 2947 obs. and 561 variables
testLabel <- read.table("./dataset/test/y_test.txt") 
table(testLabel) 
testSubject <- read.table("./dataset/test/subject_test.txt")

##1.3 combine data from test datatsets and train dataset
joinData <- rbind(trainData, testData)
dim(joinData) # 10299 obs and 561 variables
joinLabel <- rbind(trainLabel, testLabel)
dim(joinLabel) # 10299 obs and 1 variable
joinSubject <- rbind(trainSubject, testSubject)
dim(joinSubject) # 10299 obs and 1 variable

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("./dataset/features.txt")
dim(features)  # 561obs and 2 variable
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanStdIndices) # 66 values

joinData <- joinData[, meanStdIndices]
dim(joinData) # 10299*66
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # remove "()"
names(joinData) <- gsub("mean", "Mean", names(joinData)) # capitalize M
names(joinData) <- gsub("std", "Std", names(joinData)) # capitalize S
names(joinData) <- gsub("-", "", names(joinData)) # remove "-" in column names 

#3. Uses descriptive activity names to name the activities in the data set
activity <- read.table("./dataset/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2])) ## 6 obs. and 2 variables

substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names. 
names(joinSubject) <- "subject"
cleanedData <- cbind(joinSubject, joinLabel, joinData)
dim(cleanedData) # 10299 obs. and 68 variables
write.table(cleanedData, "merged_data.txt") # write out the 1st dataset

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
subjectLen <- length(table(joinSubject)) # 30
activityLen <- dim(activity)[1] # 6
columnLen <- dim(cleanedData)[2]

result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLen) {
  for(j in 1:activityLen) {
    result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
    result[row, 2] <- activity[j, 2]
    bool1 <- i == cleanedData$subject
    bool2 <- activity[j, 2] == cleanedData$activity
    result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
    row <- row + 1
  }
}
head(result)
write.table(result, "data_with_means.txt",row.name=FALSE) # write out the tidy ataset
