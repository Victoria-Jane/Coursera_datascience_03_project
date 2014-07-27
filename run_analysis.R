
library(data.table)
library(plyr)

dir_file<-"getdata-projectfiles-UCI HAR Dataset.zip"
list<-unzip(dir_file,list = TRUE) #get the list of files in the zip

#get the headers
activity_labels<-fread(unzip(dir_file,files=list[1,1]))
features<-fread(unzip(dir_file,files=list[2,1]))

# look for the variables with mean or std, and set a new variable to numeric
# for the rest of variables, set the new variable to null
# this is to be able later to filter out those variables in the read.table FM
#fist group - mean+std 
features_1<-features[grep("(mean|std)",V2)]
features_1<-features_1[!grep("meanFreq",V2)]
features_1$V3<-c("numeric")
#second group - the rest 
features_2<-features[!features_1$V1]
features_2$V3<-c("NULL")

 #most likely there's a better way to do this... but...
features_mix<-rbind(features_1,features_2)
features<-join(features,features_mix,by =c("V1","V2"))

# I'm not sure if the requirement prefers to get all the file, merge and then filter
# or get the file filtered already and then merge it... second is quicker.

subject<-rbind(fread(unzip(dir_file,files=list[16,1])),
               fread(unzip(dir_file,files=list[30,1])))
X<-rbind(read.table(unzip(dir_file,files=list[17,1]),col.names = features$V2, colClasses= features$V3),
         read.table(unzip(dir_file,files=list[31,1]),col.names = features$V2, colClasses= features$V3))
Y<-rbind(fread(unzip(dir_file,files=list[18,1])),
           fread(unzip(dir_file,files=list[32,1])))

#relate the activity codes with the labels
Y<-join(Y, activity_labels)

#join the activities(text) with the data
First_DT<-cbind(subject,Y$V2,X)
#and change the name.
setnames(First_DT,"V2","Activity")
setnames(First_DT,"V1","Subject")

# write.table(First_DT,file="First_DT.txt",row.names = FALSE )

#for the second dataset, first aggregate it....
#then we will have two extra columns at the beginning, that will sustitute the previous
#subject and activity. I remove them, and rename those new two subject and activity

second_DT<-data.table(aggregate(First_DT,by = list(First_DT$Subject,First_DT$Activity),FUN = mean, na.rm=FALSE,simplify = TRUE))
second_DT <- subset(second_DT, select = - c(Subject,Activity) )

setnames(second_DT,"Group.2","Activity")
setnames(second_DT,"Group.1","Subject")

# Generate the exit
write.table(second_DT,file="second_DT.txt",row.names = FALSE )
