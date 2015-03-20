##########load relevant test files########################
filelist<-c("subject_train.txt","subject_test.txt","activity_labels.txt","X_test.txt","X_train.txt","Y_test.txt","Y_train.txt")
my_data<-sapply(filelist,read.table)

my_columns1<-read.table("features.txt")  #read in column labels
my_columns<-as.vector(my_columns1)  #change to vector of column labels
##########break my_data into separate data frames################
ytrain<-data.frame(my_data$Y_train.txt)
ytest<-data.frame(my_data$Y_test.txt)
subjecttrain<-data.frame(my_data$subject_train.txt)
subjecttest<-data.frame(my_data$subject_test.txt)
activitylabels<-data.frame(my_data$activity_labels.txt)   #this is the translate table for activities  numeric code and text
xtest<-data.frame(my_data$X_test.txt)
xtrain<-data.frame(my_data$X_train.txt)
#############################################################################
rm(my_data)   #remove unnecessary dataframe

###################combine train and test for each set#######

y<-as.vector(rbind(ytrain,ytest))  #this is the vector of activities 

subj<-as.vector(rbind(subjecttrain,subjecttest)) #this is the vector of subject codes
x<-rbind(xtrain,xtest)    # this is all of the relevant measures

###############add column headers to data (dataframe x)###############
my_columns<-as.character(my_columns[,2]) #pick up text descriptor only
names(x)<-my_columns
####Note to peer reviewer:#############################################
#This script first selects the relevant columns based on column name.   
#Then, subject id, activity code and activity decription are added as columns.  


################select relevant columns from data (dataframe x)##################
#selectin all columns with "mean", "Mean","std" or "Std" as part of name
editx1<-x[,grepl("mean",colnames(x))]
editx2<-x[,grepl("Mean",colnames(x))]
editx3<-x[,grepl("std",colnames(x))]
editx4<-x[,grepl("Std",colnames(x))]
allx<-cbind(editx1,editx2,editx3,editx4)


############add columns for activity code and subject code to selected columns***********
all<-cbind(subj,y,allx)
headers<-c("subject_id", "activity_code",colnames(allx))
names(all)<-headers

##################add column name on activity translate table##########
headeract<-c("activity_code","activity")
names(activitylabels)<-headeract

####################join data with activity code translation table-- my_data_set is answer to item 4#########
my_data_set<-merge(activitylabels,all, by.x ="activity_code", by.y= "activity_code")

##########remove unnecessary data#####################
rm(editx1,editx2,editx3,editx4,all,allx, x, xtest, xtrain, y, ytest, ytrain,subjecttest, subjecttrain,subj)
############create array with averages###################

library(reshape2)
namevect<-names(my_data_set)   #set up column names as a vector
data4Melt<-melt(my_data_set,id.vars=namevect[1:3],measure.vars=namevect[4:89]) #identify first 3 as dimensions, remainder as measures


averages<-acast(data4Melt,subject_id~activity~variable,mean)  #calculate means by subject, across activity, for each measurement variable
#################apply tidy data principles--data6 is the answer to item 5#############################
data6<-as.data.frame.table(averages)   #change array to data frame

colnames(data6)<-c("subject_id","activity","Measure/Calc", "mean for subject/activity")
write.table(data6, "HAR_project.txt", sep=",")
detach("package:reshape2", unload=TRUE)
