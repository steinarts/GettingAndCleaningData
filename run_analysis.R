xtest <- read.table(file="UCI HAR Dataset\\test\\X_test.txt")
##loading the traing set
xtrain <- read.table(file="UCI HAR Dataset\\train\\X_train.txt")
##merge them together
xfull<-rbind(xtest,xtrain)
##get a list of col names
xfeatures <- read.table(file="UCI HAR Dataset\\features.txt")
##creating a list of all col names with a mean or std in them
xmeanstdcols <-grep("std|mean",xfeatures[,2])
##creating a new list (data.frame) with the 79 cols that has mean or std in the header
xfullnew <-xfull[xmeanstdcols]

##activities
##loading the test set activities
xtestactivities <- read.table(file="UCI HAR Dataset\\test\\y_test.txt")
##loading the traing set activities
xtrainactivities <- read.table(file="UCI HAR Dataset\\train\\y_train.txt")
##merge them together
xfullactivities<-rbind(xtestactivities,xtrainactivities)

##replace all numbers with activitics name
xlables <- read.table(file="UCI HAR Dataset\\activity_labels.txt")

xfullactivities$V1[xfullactivities$V1 == xlables[1,1]] <-as.character(xlables[1,2])
xfullactivities$V1[xfullactivities$V1 == xlables[2,1]] <-as.character(xlables[2,2])
xfullactivities$V1[xfullactivities$V1 == xlables[3,1]] <-as.character(xlables[3,2])
xfullactivities$V1[xfullactivities$V1 == xlables[4,1]] <-as.character(xlables[4,2])
xfullactivities$V1[xfullactivities$V1 == xlables[5,1]] <-as.character(xlables[5,2])
xfullactivities$V1[xfullactivities$V1 == xlables[6,1]] <-as.character(xlables[6,2])

##add the activities as a col
xfullnew["activities"] <- xfullactivities

## name of the cols
xrownames <- xfeatures[grep("std|mean",xfeatures[,2]),2]
##rename prefix
xrownames <-gsub("tB","timeB",xrownames)
xrownames <-gsub("fB","frequenceB",xrownames)
xrownames <-gsub("tG","timeG",xrownames)
##convert to lower case
xrownames <-tolower(xrownames)
##remove ()
xrownames <-gsub("mean\\()","mean",xrownames)
xrownames <-gsub("std\\()","std",xrownames)
xrownames <-gsub("meanfreq\\()","meanfreq",xrownames)
xrownames <-gsub("std\\()","std",xrownames)
xrownames <-gsub("meanfreq\\()","meanfreq",xrownames)
##rename abbrivation
xrownames <-gsub("mag","magnitude",xrownames)
xrownames <-gsub("acc","acceleration",xrownames)
xrownames <-gsub("-x","xaxis",xrownames)
xrownames <-gsub("-y","yaxis",xrownames)
xrownames <-gsub("-z","zaxis",xrownames)
xrownames <-gsub("-","",xrownames)

## add colnames
names(xfullnew) <- c(xrownames,"activities")

##5.add the subjects to one data.frame
xtestsubjects <- read.table(file="UCI HAR Dataset\\test\\subject_test.txt")
xtrainsubjects <- read.table(file="UCI HAR Dataset\\train\\subject_train.txt")
xsubjects<-rbind(xtestsubjects,xtrainsubjects)
##and add it to the xfullnew
xfullnew["subjects"] <- xsubjects

##new dataset with the avg of each var. for each activity for each subject
B <-melt(xfullnew,id=c("subjects","activities"))
Bdcast <- dcast(B, subjects + activities ~ variable, fun.aggregate=mean)

##export the the final as final.txt to the working dir
write.table(Bdcast, file = "Final.txt",row.names = F)