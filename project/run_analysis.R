###############################################################################################################################################################################################################################################################
###              Course Project: Getting and Cleaning Data
###############################################################################################################################################################################################################################################################

### Step 0. Preparation ################################################################################################################################################################################################

## dir.create("/Users/VC/Dropbox/Learning/DataScience/GettingData/project/")
## set working directory

setwd("/Users/VC/Dropbox/Learning/DataScience/GettingData/project")

## download raw data

library(httr) 
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file <- "projectdata.zip"
if(!file.exists(file)){download.file(url, file, method="curl")}

## unzip the downloaded file

rawfolder <- "UCI HAR Dataset"     #rawdata folder
tidyfolder <- "tidydata"           #tidy data folder
if(!file.exists(rawfolder)){unzip(file, list = FALSE, overwrite = TRUE)} 
if(!file.exists(tidyfolder)){dir.create(tidyfolder)} 

setwd("/Users/VC/Dropbox/Learning/DataScience/GettingData/project/UCI HAR Dataset")

## Step 1. Read-in and create training data and label variables

features     <- read.table("./features.txt",header=FALSE)
activity_labels <- read.table("./activity_labels.txt",header=FALSE)
subject_train<- read.table("./train/subject_train.txt",header=FALSE)
x_train       <- read.table("./train/x_train.txt",header=FALSE)
y_train       <- read.table("./train/y_train.txt",header=FALSE)

colnames(activity_labels) <- c("activity_id","activity_type")
colnames(subject_train)  <- c("subject_id")
colnames(x_train)        <-  features[,2]
colnames(y_train)        <- "activity_id"

training_data <- cbind(y_train,subject_train,x_train)

## Step 2. Read-in and create testing data and label variables

subject_test<- read.table("./test/subject_test.txt",header=FALSE)
x_test       <- read.table("./test/x_test.txt",header=FALSE)
y_test       <- read.table("./test/y_test.txt",header=FALSE)

colnames(subject_test)  <- c("subject_id")
colnames(x_test)        <-  features[,2]
colnames(y_test)        <- "activity_id"

testing_data <- cbind(y_test,subject_test,x_test)

## Step 3.  Merge Testing and Training data

data<- rbind(training_data, testing_data)
names<- colnames(data)

##  Step 4. Use descriptive activity names to name the activities in the data set

data$activity_id <- factor(data$activity_id, levels=activity_labels$activity_id, labels=activity_labels$activity_type)

print(activity_labels)

## Step 5.  Extract only the measurements on the mean and standard deviation 
## for each measurement.  Saves that that as a file "means_and_stds.csv.

index<- (
         grepl("activity..",names) 
         | grepl("subject..",names) 
         | (grepl("-mean..",names) 
         & !grepl("mean()..-",names) 
         & !grepl("-meanFreq..",names) )
         | (grepl("-std..",names) 
         & !grepl("-std()..-",names))
         )

means_and_stds <- data[, index]

##  Step 6. Clean up the variable names a bit

var_names<- colnames(means_and_stds)

for (i in 1:length(var_names)) 
{
  var_names[i] = gsub("-std",".StdDev",var_names[i])
  var_names[i] = gsub("-mean",".Mean",var_names[i])
  var_names[i] = gsub("[Bb]ody[Bb]ody","Body",var_names[i])
  var_names[i] = gsub("[Mm]ag","Magnitude",var_names[i])
  var_names[i] = gsub("\\()","",var_names[i])
  var_names[i] = gsub("^(t)","Time.", var_names[i])
  var_names[i] = gsub("^(f)","Freq.", var_names[i])
}

print(var_names)
colnames(means_and_stds)<- var_names
write.table(means_and_stds, "../tidydata/means_and_stds.txt", row.names=FALSE)

## Step 6. Creates a second, independent tidy data set called "tidy_data" with the average of each variable for each activity and each subject
## and save as tidy_data.csv

library(plyr)
tidy_data<- ddply(means_and_stds, .(subject_id, activity_id), .fun=function(x){ colMeans(x[,-c(1:2)]) })
colnames(tidy_data)[-c(1:2)] <- paste("Average.", colnames(tidy_data)[-c(1:2)], sep="")
print(colnames(tidy_data))
write.table(tidy_data, "../tidydata/tidy_data.txt", row.names=FALSE, sep = " ")
