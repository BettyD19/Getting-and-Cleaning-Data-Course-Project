# **CodeBook for Geting and cleaning dataCodeBook for Geting and cleaning data**

run_analysis.R script performs the required steps described in the course project. The setps performed are as follow

 ## **1. Get the dataset and download the file**

 Download the data  and unzip the file and then the file is saved in data folder.The run_analysis uses read.table to read each text file from the datasets.
 - This project will uses six datas from the datasets, this are y_test, y_train, subject test, subject train, x_test and x_train.
 - The activity_labels.txt contains the name of each activities, which each activity corrosponds with each number in y_test and y_train.
 - The features.txt contains the variable names, which each names corrosponds with each column of x_test and x_train.

 ##  **2. Merges the training and the test sets to create one data set**
    
 Merege the test and training files to create one datasets  using rbind and it is assigned with ActivityData, FeatureData and subjectData, after the test and training data is merged three of the data should be merged by column  using cbind.
 
 ## **3.Extracts only the measurements on the mean and standard deviation for each measurement**

Extract the measurements only with the one which has mean and sd standard deviation from FeatureData and match column name with data sets with FeatureData and assigened by **FeaturedExtracted**. 

 ## **4.Uses descriptive activity names to name the activity datasets**

 Match each number in ActivityData column with the activity name in activity_labels.txt assigned as **Activity_labels**

 ## **5.Appropriate labels the data set with descriptive variable names**

Rename the column of Activity_labels and subjectData with descriptive name with **subject** and **activity** respectivily.

- Merge all clean data FeaturedExtracted, subjectData and Activity_labels and assigned to **clean_combine**  

 ## **6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject**

 - The second  independent tidy data  created  with the avarage of each variable for each activity and each subject and assigned with clean_combine2 it has 180 obs. of  68 variables and exported to **tidy_data.txt**.

