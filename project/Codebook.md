# Codebook
VC2015  
July 24, 2015  

##  Summary

This is a codebook explaining how the analysis was performed.

##   Date Source 

One of the most exciting areas in all of data science right now is wearable computing - see for example this article.  Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project was downloaded from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##  Steps of the analysis

1) download raw data
2) unzip the downloaded file
3) read-in and create training data and label variables
4) Read-in and create testing data and label variables
5)  Merge Testing and Training data
6) Use descriptive activity names to name the activities in the data set
7) Assign descriptive activity names to name the activities in the data set:

            1-WALKING,   2-WALKING_UPSTAIRS, 3-WALKING_DOWNSTAIRS, 4-SITTING, 5-STANDING, 6-LAYING.

8) Extract only the measurements on the mean and standard deviation  for each measurement.  Saves that that as a file "means_and_stds.csv.
9) clean up the variable names a bit, creating the following names:

      [1] "activity_id"                       "subject_id"                        "Time.BodyAccMagnitude.Mean"       
      [4] "Time.BodyAccMagnitude.StdDev"      "Time.GravityAccMagnitude.Mean"     "Time.GravityAccMagnitude.StdDev"  
      [7] "Time.BodyAccJerkMagnitude.Mean"    "Time.BodyAccJerkMagnitude.StdDev"  "Time.BodyGyroMagnitude.Mean"      
      [10] "Time.BodyGyroMagnitude.StdDev"     "Time.BodyGyroJerkMagnitude.Mean"   "Time.BodyGyroJerkMagnitude.StdDev"
      [13] "Freq.BodyAccMagnitude.Mean"        "Freq.BodyAccMagnitude.StdDev"      "Freq.BodyAccJerkMagnitude.Mean"   
      [16] "Freq.BodyAccJerkMagnitude.StdDev"  "Freq.BodyGyroMagnitude.Mean"       "Freq.BodyGyroMagnitude.StdDev"    
      [19] "Freq.BodyGyroJerkMagnitude.Mean"   "Freq.BodyGyroJerkMagnitude.StdDev".

10) Create a second, independent tidy data set called "tidy_data" with the average of each variable for each activity and each subject  and save as tidy_data.csv
