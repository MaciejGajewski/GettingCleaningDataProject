library("dplyr")
library("reshape2")

# Read all files into data frames & dplyr tables
activities <- tbl_df(read.table("activity_labels.txt",as.is = T))
features <- tbl_df(read.table("features.txt",as.is = T))

subject_test <- tbl_df(read.table("test/subject_test.txt",as.is = T))
x_test <- tbl_df(read.table("test/X_test.txt",as.is = T))
y_test <- tbl_df(read.table("test/y_test.txt",as.is = T))

subject_train <- tbl_df(read.table("train/subject_train.txt",as.is = T))
x_train <- tbl_df(read.table("train/X_train.txt",as.is = T))
y_train <- tbl_df(read.table("train/y_train.txt",as.is = T))


# Merges the training and the test sets to create one data set.
subject <- rbind(subject_test, subject_train)
x <- rbind(x_test, x_train)
y <- rbind(y_test, y_train)


# Appropriately labels the data set with descriptive variable names.

f1 <- gsub("\\.","_", make.names(features$V2))
f2 <- gsub("(_)*_$","",f1)
f3 <- gsub("___","_",f2)
f4 <- gsub("^t","time",f3)
featureNames <- gsub("^f","freq",f4)


names(x) <- featureNames

names(y) <- "activityId"

names(subject) <- "subjectId"

names(activities) <- c("activityId", "activity")

# Extracts only the measurements on the mean and standard deviation 
# for each measurement
meanStdNames <- featureNames[grep("mean|std", featNames)]
x1 <- x[,meanStdNames]


# Uses descriptive activity names to name the activities in the data set
subjectActivity <- tbl_df(cbind(subject, y))
subjectActivity1 <- tbl_df(merge(subjectActivity,activities,by="activityId"))

x2 <- tbl_df(cbind(subjectActivity1,x1,by="activityId"))
x3 <- select(x2,-c(activityId, by))


# From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

# 1st summarization method
meansTmp <- x3 %>% group_by(subjectId, activity) %>% summarise_each(funs(mean))

# 2st summarization method
x4 <- tbl_df(melt(x3,id.vars=c("subjectId","activity"), 
                  variable.name = "feature", value.name = "value"))

groupedData <- group_by(x4, subjectId, activity, feature)

#means <-tbl_df(aggregate(. ~ subjectId + activity, data = groupedData, mean))
means <- summarise(groupedData, mean(value))
names(means)[4] <- "featureAverage"

# 3rd alternative 
means2 <-tbl_df(dcast(means,subjectId + activity ~ feature))

write.table(means, file="means.txt", row.names=FALSE)

