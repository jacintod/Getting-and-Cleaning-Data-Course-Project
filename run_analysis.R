## This project is based on the Davide Anguita, Alessandro Ghio, Luca Oneto, 
## Xavier Parra and Jorge L. Reyes-Ortiz Themos Patrikios publication 
## "Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine".
## International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

## This script merges data from a number of .txt files and produces 
## a tidy data set which may be used for further analysis.
## Print the working directory to show where the script is running from
print(getwd())

##check for required packages
if (!("reshape2" %in% rownames(installed.packages())) ) {
        print("Please install required package \"reshape2\" before proceeding")
} else { 
        #Load the respectve libraries needed for the execution in the script
        library(reshape2)
        
        # By Default the script will download and extract the files to the Data Directory 
        if(!file.exists("./Data")){dir.create("./Data")}
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl,destfile="./Data/Dataset.zip")
        
        # Unzip dataSet to WorkingDirectory()/Data directory
        unzip(zipfile="./Data/Dataset.zip",exdir="./Data")
        
        # 1. Firstly we need to read the labels and activity features of the data set
        #    Load activity labels + features
        activityLabels <- read.table("./Data/UCI HAR Dataset/activity_labels.txt")
        activityLabels[,2] <- as.character(activityLabels[,2])
        features <- read.table("./Data/UCI HAR Dataset/features.txt")
        features[,2] <- as.character(features[,2])
        
        # 2. Next we only extract the Mean and Standard Deviation column names
        #    Extract only the data on mean and standard deviation
        featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
        featuresWanted.names <- features[featuresWanted,2]
        featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
        featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
        featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)
        
        # 3. We now have to read the respective datasets
        #    Load the datasets
        train <- read.table("./Data/UCI HAR Dataset/train/X_train.txt")[featuresWanted]
        trainActivities <- read.table("./Data/UCI HAR Dataset/train/Y_train.txt")
        trainSubjects <- read.table("./Data/UCI HAR Dataset/train/subject_train.txt")
        train <- cbind(trainSubjects, trainActivities, train)
        
        test <- read.table("./Data/UCI HAR Dataset/test/X_test.txt")[featuresWanted]
        testActivities <- read.table("./Data/UCI HAR Dataset/test/Y_test.txt")
        testSubjects <- read.table("./Data/UCI HAR Dataset/test/subject_test.txt")
        test <- cbind(testSubjects, testActivities, test)
        
        # merge datasets and add labels
        allData <- rbind(train, test)
        colnames(allData) <- c("subject", "activity", featuresWanted.names)
        
        # turn activities & subjects into factors
        allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
        allData$subject <- as.factor(allData$subject)
        
        allData.melted <- melt(allData, id = c("subject", "activity"))
        allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)
        
        write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
}
