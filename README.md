---
title: "codebook HAR_project.txt"
author: "KGSM78"
date: "Saturday, March 21, 2015"
output: html_document
---

HAR_project.txt is a tidy data set which contains calculated group means derived from the Human Activity Recognition study data posted at  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#  

*Design and background*: This was an observational study of 30 subjects performing 6 activities, as recorded by the embedded accelerometer and gyroscope on Samsung smartphones.   See the site cited above for more details.  

*Raw data*:  As recorded in the readme file at the site: "The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain."  The vector of features calculated by Reyes-Ortiz et al. is the raw data for this project.  

The following files were identified as raw data: 


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

*Processed data*: 
The data in the files cited above were pulled into a single dataset, and a selection applied so as to retain only the 86 variables which pertained to mean and standard deviation.  

Then, the group mean for each of these variables was calculated.   The groupings were on combinations of subject and activity.  The resulting dataset contains 15,480 observations of 4 variables:

Varible name  | Type
------------- | -------------
subject_id  | Factor w/ 30 levels
activity  | Factor w/ 6 levels      (text description)
Measure/Calc  | Factor w/ 86 levels
mean for subject/activity | num

For more detail on the process, see https://github.com/Kgsm78/GCD_HAR/blob/master/description_for_run_analysis.md