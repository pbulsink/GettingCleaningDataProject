run_analysis = function(){
    if (!file.exists("data")) {
        dir.create("data")
        print("Made data Dir")
    }
    
    if (!file.exists("data/Dataset.zip")) {
        fileUrl<-("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
        download.file(fileUrl, destfile = "./data/Dataset.zip", method="curl")
        print("downloaded")
    }
    
    if (!file.exists("UCI HAR Dataset")){
        unzip("./data/Dataset.zip")
        print("unzipped")
    }
    
    print("starting analysis")
    startDir<-getwd()
    dateAnalyzed<-date()
    
    setwd("./UCI HAR Dataset/")
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

    colnames(trg_X)<-make.names(cnames$V2, unique=TRUE)
    colnames(tst_X)<-make.names(cnames$V2, unique=TRUE)
    colnames(trg_y)<-c("activity")
    colnames(tst_y)<-c("activity")
    colnames(tst_sub)<-c("subject")
    colnames(trg_sub)<-c("subject")
    print("Named Columns")
    allX<-rbind(tst_X, trg_X)
    allY<-rbind(tst_y, trg_y)
    allS<-rbind(tst_sub, trg_sub)
    print("rbound")
    combData<-cbind(allY, allS, allX)
    print("cbound")
    
    combData$activity<-as.factor(combData$activity)
    levels(combData$activity)<-factorsList[,2]
    print("factored")
    rm(cnames, allX, allY, allS, trg_X, trg_y, trg_sub, tst_X, tst_y, tst_sub, factorsList)
    print("clean")
    
    library(dplyr)
    
    thinData<-select(combData, activity, subject, contains(".mean."), contains(".std."))
    print("thinned")
    thinMelt <- melt(thinData, id=c("subject", "activity"))
    print("melted")
    thinCast<-dcast(thinMelt, subject + activity ~ variable, mean)
    print("cast")
    
    write.table(thinCast, "./data/dataOut.txt",row.names=FALSE)
    
    rm(thinData, thinMelt, thinCast, combData)
    print(paste("Data processed on ", dateAnalyzed, ".", sep=""))
    
}
