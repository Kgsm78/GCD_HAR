---
title: "Description of run_analysis.R"
author: "KGSM78"
date: "Friday, March 20, 2015"
output: html_document
m,,,

This script operates successfully on Windows 7 64bit, RStudio Version 0.98.1079, R-3.1.2, 32 bit. 

Before this script can run succesfully, selected files from the zip file must be downloaded to the working directory.  See below for the file list.  

*Step 1*:  Load files    Lines 2-14
The following files are needed:


File name   |  Contents
------------- | -------------
x_test.txt  | 561 Summary calculations for observations of "test" group
x_train.txt   | 561 Summary calculations for observations of "train" group
y_test.txt   | activity codes associated with observations of "test" group
y_train.txt   | activity codes associated with observations of "train" group
subject_test.txt   | subject ids associated with observations of "test" group
subject_train.txt  | subject ids associated with observations of "train" group
features.txt   | descriptors for 561 calculations
activity_labels.txt | activity codes and text activity descriptors


*Step 2*:  Combine test and train group files  Lines 20-23
For each set (x,y and subject), combine the information coming from the "test" group with the "train" group. 
for example:
```
x<-rbind(xtrain,xtest) 
```
         
*Step 3*:  Select calculations which measure mean and standard deviation  Lines 25-39
There are 561 calculations (columns) summarizing activity measurements.   Select those with mean standard deviation as part of the name.  For example:
```
editx1<-x[,grepl("mean",colnames(x))]
```

*Step 4*:   Bring the subject IDs and activity code and activity desriptor into the data   Lines 42-52

Use cbind(); for example:
```
all<-cbind(subj,y,allx)
```
At the end of this step, we have a dataset which brings the HAR  data (which already reflected calculations) into one data frame (10299 observations of 89 calculated amounts).

*Step 5*:  Calculate the means by subject_id and activity and create a tidy dataset    Lines 56-68

Use the rshape2 function melt() to identify dimenstions and measurements.   Use acast() to calculate the means of the 89 calculated amounts, grouping by subjectid and activity:
```
averages<-acast(data4Melt,subject_id~activity~variable,mean)  
```
This produces an array.   Change the array into a dataframe using as.data.frame.table():
```
data6<-as.data.frame.table(averages)
```
then add column headers:
```
colnames(data6)<-c("subject_id","activity","Measure/Calc", "mean for subject/activity")
```


