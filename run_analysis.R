## By JulioCor
## July 2014
## Coursera - Getting and Cleaning Data - Course Project

## In order to run first use setwd() to select directory where files are extracted from the ZIP file provided
## similar to this: > setwd("~/Documents/R/GetDat/UCI HAR Dataset")


##  ***  Read All Necesary Files  ***

    # All measurements for TEST set
        f_test_X <- read.table("test/X_test.txt") 
        # ncol(f_test_X)  
        # must have 561 columns
    
        # nrow(f_test_X)
        # [1] 2947
        
        
        # Activities for test set     
        f_test_Y <- read.table("test/Y_test.txt")
        
        # Subjects for test set
        f_test_subject <- read.table("test/subject_test.txt")

    # All measurements for TRAIN set
        f_train_X <- read.table("train/X_train.txt") 
        # ncol(f_train_X)  
        # must have 561 columns
        
        #nrow(f_train_X)
        #[1] 7352
        
        
        # Activities for train set     
        f_train_Y <- read.table("train/Y_train.txt")
        
        # Subjects for train set
        f_train_subject <- read.table("train/subject_train.txt")
        
    # Features (measurements names)        
        f_features <- read.table("features.txt")
        
    # Activity Labels
        f_activity_labels           <- read.table("activity_labels.txt")
        colnames(f_activity_labels) <- c("activity_id", "activity_dsc")
    
##  ***  Merge and Clean  ***
    # =========    
    # 1: Merges the training and the test sets to create one data set
    # =========    
        merge_set_allmeasures <- rbind(f_test_X, f_train_X)
            #nrow(merge_set_allmeasures)
            #[1] 10299
            
        merge_set_activities            <- rbind(f_test_Y, f_train_Y)
        colnames(merge_set_activities)  <- "activity_id"
        
        merge_set_subject               <- rbind(f_test_subject, f_train_subject)
        colnames(merge_set_subject)     <- "subject"
        
    
        
    # =========    
    # 2: Extracts only the measurements on the mean and standard deviation for each measurement
    # =========
        #names for all measurements
        colnames(merge_set_allmeasures) <- f_features$V2 
        
        #Measure list for  mean() and std()
        std_and_mean_list <- as.vector( subset(f_features, grepl("mean()", V2, fixed = TRUE) | grepl("std()", V2, fixed = TRUE)) )$V2
        
        merge_set_mean_std           <- merge_set_allmeasures[, std_and_mean_list]
        
        # =========    
        # 4: Appropriately labels the data set with descriptive variable names
        # =========
        colnames(merge_set_mean_std) <- std_and_mean_list
        
    # =========    
    # 3: Uses descriptive activity names to name the activities in the data set
    # =========   
        # Add description to activities set
        merge_set_activities_dsc    <- merge(merge_set_activities, f_activity_labels, by = "activity_id" )
        set_all_mean_std_activity   <- cbind(merge_set_activities_dsc, merge_set_subject, merge_set_mean_std)
        
    # =========    
    # 6: Activity Average Set
    # =========   
        set_activity_average <- aggregate(x = set_all_mean_std_activity, FUN = "mean", by = list(set_all_mean_std_activity$activity_dsc, set_all_mean_std_activity$subject ), data = std_and_mean_list)
        tidy_data_set        <- set_activity_average[,!(names(set_activity_average) %in% c("activity_id", "activity_dsc", "subject"))]
        names(tidy_data_set)[1] <- "activity"
        names(tidy_data_set)[2] <- "subject"
        
        write.table(tidy_data_set, file = "tidy_data_set.txt", row.names =FALSE )
        
        
