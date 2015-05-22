run_analysis<-function(){
  #read files from directory
  #melt dataset to just means and sds
  #use descriptor columns
  #extract just averages with descriptors
  
  X_test<-read.table(paste(getwd(),"/UCI HAR Dataset/test/X_test.txt",sep=""))
  subject_test<-read.table(paste(getwd(),"/UCI HAR Dataset/test/subject_test.txt",sep=""))
  y_test<-read.table(paste(getwd(),"/UCI HAR Dataset/test/y_test.txt",sep=""))
  
  activity_labels<-read.table(paste(getwd(),"/UCI HAR Dataset/activity_labels.txt",sep="")) 
  features<-read.table(paste(getwd(),"/UCI HAR Dataset/features.txt",sep=""))

  X_train<-read.table(paste(getwd(),"/UCI HAR Dataset/train/X_train.txt",sep=""))
  subject_train<-read.table(paste(getwd(),"/UCI HAR Dataset/train/subject_train.txt",sep=""))
  y_train<-read.table(paste(getwd(),"/UCI HAR Dataset/train/y_train.txt",sep=""))
  
  

  
  #put data sets together
  test<-cbind(X_test,subject_test)
  activity_test<-merge(y_test,activity_labels,by.x="V1",by.y="V1",all=T)
  test<-cbind(test,activity_test)
  
  train<-cbind(X_train,subject_train)
  activity_train<-merge(y_train,activity_labels,by.x="V1",by.y="V1",all=T)
  train<-cbind(train,activity_train)
  
  #merge labeled train and test sets
  total<-rbind(test,train)
  colnames(total)<-features$V2

  
  smallDataSet<- cbind(rbind(subject_test,subject_train),rbind(activity_test,activity_train))
  cname<-character()

  #extract just mean and sd
  for (i in 1:ncol(total)){
    if (grepl("mean()",colnames(total)[i]) | grepl("std()",colnames(total)[i])){
      smallDataSet<-cbind(smallDataSet,total[,i])
      cname<-append(cname,(colnames(total)[i]))
      
 
      
  
      
    }

  }
  colnames(smallDataSet)<-c("Subject","Activity Code","Activity",cname)
 
  
  
  #second tidy data set with just average of each measure per activity, subject
  #create data frame
  smallMelt<-matrix(ncol=ncol(smallDataSet),nrow=0)
  
  #loop through subject, activity and data
  for (i in range(smallDataSet$Subject)[1]:range(smallDataSet$Subject)[2]){
  
    for (j in 1:length(levels(smallDataSet$Activity))){

      nextLine<-vector()
      nextLine<-c(i,j,levels(smallDataSet$Activity)[j])
      for (k in 4:ncol(smallDataSet)){

        nextLine<-append(nextLine,mean(smallDataSet[,k][smallDataSet$Subject==as.character(i) & smallDataSet$Activity==levels(smallDataSet$Activity)[j]],na.rm=T))
        
        
        
      }
      if(nextLine[4]!="NaN" & nextLine[4]!=0) smallMelt<-rbind(smallMelt,nextLine)    


    }

  }
  
  colnames(smallMelt)<-c("Subject","Activity Code","Activity",cname)
  write.table(smallMelt,file="ans.txt",row.names=F)
  
}