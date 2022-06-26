#project for Getting and Cleaning Data Course Jhon Hopkin Univeristy


#1 -- Merge training and test set -- #

  #loading train data
feature_tr <- read.table("./data/train/X_train.txt")
subject_tr <- read.table("./data/train/subject_train.txt")
label_tr   <- read.table("./data/train/y_train.txt")

  #merging train features and labels

feature_tr$id <- 1:7352
subject_tr$id <- 1:7352
label_tr$id   <- 1:7352

train <- join(feature_tr, subject_tr, by = "id")
train <- join(train, label_tr, by = "id")
colnames(train)

train$id <- NULL
colnames(train)
                      #----- train set complete -----#


  #loading test data
feature_test <- read.table("./data/test/X_test.txt")
subject_test <- read.table("./data/test/subject_test.txt")
label_test   <- read.table("./data/test/y_test.txt")

  #merging test features and labels
feature_test$id <- 1:2947
subject_test$id <- 1:2947
label_test$id   <- 1:2947

test <- join(feature_test, subject_test, by = "id")
test <- join(test, label_test, by = "id")
colnames(test)

test$id <- NULL
colnames(test)
                      #----- test set complete -----#


  # merging train and test set
complete_data <- rbind(train, test)

#loading and changing colnames 
names_features <- read.table("./data/features.txt")
names_subject  <- "subject"
names_label    <- "activity"
names_col <- names_features[, 2]
names_col[562] <- names_subject
names_col[563] <- names_label

colnames(complete_data) <- names_col
colnames(complete_data)


#1------- Merge training and test set complete -------#



#2 -- Exctracting measurament (mean & std) -- #

  #finding columns names with mean and std inside
measurament_mean_std_indexes <- grep(".*(mean|std).*", colnames(complete_data), value = TRUE)
  
  #exctracting goal columns
mean_std_data <- complete_data[, (colnames(complete_data) %in% measurament_mean_std_indexes)]
head(mean_std_data)

mean_std_data$subject  <- complete_data$subject
mean_std_data$activity <- complete_data$activity


#2------ Exctracting measurament (mean & std) complete ------#



#3 -- Renames activity variables with character -- #

  #loading activity names
activity_names <- read.table("./data/activity_labels.txt")
activity_names <- activity_names[,2]
  
  #writing a function that return the correct name for a specific activity
subActivity <- function(value, list_of_names) {
    if(value == "1"){
      result <- 1L
    }
    if(value == "2"){
      result <- 2L
    }
    if(value == "3"){
      result <- 3L
    }
    if(value == "4"){
      result <- 4L
    }
    if(value == "5"){
      result <- 5L
    }
    if(value == "6"){
      result <- 6L
    }
    return(list_of_names[result])
}

  #appling substitutuion to activity
mean_std_data$activity <- as.character(as.numeric(mean_std_data$activity))
mean_std_data$activity <- sapply(mean_std_data$activity, subActivity,  list_of_names = activity_names)


#3--- Renames activity variables with character complete ---#


#4 -- labeling dataset with descriptive var names -- #


colnames(mean_std_data)

  #function for renaming
descriptiveRenaming <- function(col_name){
    col_name  <- sub("^t", "time", col_name)
    col_name  <- sub("^f", "frequency", col_name)
    col_name  <- sub("\\(", "", col_name)
    col_name  <- sub("\\)", "", col_name)
    col_name  <- gsub("\\-", "", col_name)
    col_name  <- sub("mean", "Mean", col_name)
    col_name  <- sub("std", "Std", col_name)
    col_name  <- sub("Acc", "Acceleration", col_name)
    col_name  <- sub("Gyro", "Gyroscope", col_name)
    col_name  <- sub("Mag", "Magnitude", col_name)
    return(col_name)    
}

  #apply function to columns names
colnames(mean_std_data) <- sapply(colnames(mean_std_data) , descriptiveRenaming)
colnames(mean_std_data)


#4--- labeling dataset with descriptive var names complete ---#

#5 -- melting data set for Step 5-- #

    #selecting just mean features
mean_data <- mean_std_data[,grep("Mean|subject|activity",colnames(mean_std_data))]

    #defining measurament columns
measuramentcol <- colnames(select(mean_data, -(subject:activity)))

    #defining id column
idcol <- c("subject", "activity")

    #melting
tidydataset <- melt(mean_data, id.vars = idcol, measure.vars = measuramentcol)

    #dcast
tidydataset <- dcast(tidydataset, subject+activity~variable, mean)
head(tidydataset,20)


#5----------- melting data set for Step 5 complete -----------#


#------- Saving file -------#
write.csv(tidydataset,file = "tidy_data.csv")