run_analysis = function(){
    starttime<-proc.time()
    if (!file.exists("data")) {  # Make subdir if needed
        dir.create("data")
        print("Made data Dir")
    }
    
    if (!file.exists("data/Dataset.zip")) {  # Download file if needed
        fileUrl<-("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
        download.file(fileUrl, destfile = "./data/Dataset.zip", method="curl")
        print("downloaded")
        unzip("./data/Dataset.zip")  #even if unzipped exists, redo with new downloaded file
        print("unzipped")
    }
    
    if (!file.exists("UCI HAR Dataset")){ # if download exists but no unzip, then unzip
        unzip("./data/Dataset.zip")
        print("unzipped")
    }
    
    print("starting analysis")
    startDir<-getwd() #know where we started from
    dateAnalyzed<-date() #capture the datetime of analysis starting
    
    setwd("./UCI HAR Dataset/")
    #Read in all the info needed
    trg_X<-read.table("./train/X_train.txt")
    trg_y<-read.table("./train/y_train.txt")
    trg_sub<-read.table("./train/subject_train.txt")
    print("read training files")
    tst_X<-read.table("./test/X_test.txt")
    tst_y<-read.table("./test/y_test.txt")
    tst_sub<-read.table("./test/subject_test.txt")
    print("read test files")
    cnames<-read.table("features.txt")
    factorsList <- read.table("./activity_labels.txt")
    setwd(startDir)
    print("read extraneous files")

    #Name our columns
    colnames(trg_X)<-make.names(cnames$V2, unique=TRUE)
    colnames(tst_X)<-make.names(cnames$V2, unique=TRUE)
    colnames(trg_y)<-c("activity")
    colnames(tst_y)<-c("activity")
    colnames(tst_sub)<-c("subject")
    colnames(trg_sub)<-c("subject")
    print("Named Columns")
    
    #combine all test and all training sets together by variable
    allX<-rbind(tst_X, trg_X)
    allY<-rbind(tst_y, trg_y)
    allS<-rbind(tst_sub, trg_sub)
    print("rbound")
    
    #Combine all vairables to one large df
    combData<-cbind(allY, allS, allX)
    print("cbound")
    
    #turn activities into factors with names
    combData$activity<-as.factor(combData$activity)
    levels(combData$activity)<-factorsList[,2]
    print("factored")
    
    #cleanup dir (free memory)
    rm(cnames, allX, allY, allS, trg_X, trg_y, trg_sub, tst_X, tst_y, tst_sub, factorsList)
    print("clean")
    
    #We'll use dplyr to wrangle data
    library(dplyr)

    #We don't need all the data, keep what's important
    thinData<-select(combData, activity, subject, contains(".mean."), contains(".std."))
    print("thinned")
    
    #Melt data to recast
    thinMelt <- melt(thinData, id=c("subject", "activity"))
    print("melted")
    thinCast<-dcast(thinMelt, subject + activity ~ variable, mean)
    print("cast")
    
    #Write data to file
    write.table(thinCast, "./data/Processed_Data.txt",row.names=FALSE)
    print("data written to file ./data/Processed_Data.txt")
    
    #Clean dir again
    rm(thinData, thinMelt, thinCast, combData)
    
    #let user know we're finished with timing statements.
    print(paste("Data processed on ", dateAnalyzed, " with time:", sep=""))
    print(proc.time()-starttime)
}
