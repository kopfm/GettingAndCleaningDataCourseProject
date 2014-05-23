## check if Samsung Data exists
f(file.exists("./UCI HAR Dataset")){
        #plyr library is needed for ddply
        library(plyr)
        
        ##read the feature names
        features <- read.table("UCI HAR Dataset/features.txt",header=FALSE)$V2
        ##make features human readable
        features <- gsub(pattern="-", replacement=".",x=features)
        features <- gsub(pattern=",", replacement=".",x=features)
        features <- gsub(pattern="(", replacement="",x=features, fixed=TRUE)
        features <- gsub(pattern=")", replacement="",x=features, fixed=TRUE)
        
        ##read the subject IDs
        subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                                   col.names=c("Subject"))
        subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                                  col.names=c("Subject"))
        
        ##read the activities
        yTrainActivity <- read.table("UCI HAR Dataset/train/y_train.txt", 
                                     col.names=c("Activity"))
        yTestActivity <- read.table("UCI HAR Dataset/test/y_test.txt",
                                    col.names=c("Activity"))
        
        ##read the activity labels
        activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", 
                                     col.names=c("Activity","ActivityLabel"))
        
        ##join activity labels with activities
        trainLabels <- merge(yTrainActivity, activityLabels, by="Activity")
        testLabels <- merge(yTestActivity, activityLabels,  by="Activity")
        
        ##read x_train.txt and combine it with trainLabels
        xTrainData <- cbind(read.table("UCI HAR Dataset/train/X_train.txt",
                                       col.names=features,
                                       header=FALSE),
                            trainLabels, subjectTrain)
        
        ##read x_test.txt and combine it with testLabels
        xTestData  <- cbind(read.table("UCI HAR Dataset/test/X_test.txt",
                                       col.names=features,
                                       header=FALSE),
                            testLabels, subjectTest)
        
        ##combine the datasets
        xDataCombined <- rbind(xTrainData, xTestData)
        ##select std, mean, Subject and ActivityLabel columns 
        xDataCombinedExtracted <- xDataCombined[, grepl(
                "mean|.std|Subject|ActivityLabel",colnames(xDataCombined))]
        
        ##calculate the average of each variable for each activity and each subject
        tidyData <- ddply(xDataCombinedExtracted,
                          .(Subject, ActivityLabel), numcolwise(mean))
        
        ##write the tidy dataset
        write.table(tidyData, "tidyData.txt", sep="\t", row.names=FALSE)
} else {
        print("Samsung Data is Missing!")
}