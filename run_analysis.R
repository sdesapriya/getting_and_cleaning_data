
# loading reshape2 library
library(reshape2)

#reading train files
x_train <- read.table("UCI_HAR_Dataset/train/x_train.txt", sep = "")
y_train <- read.table("UCI_HAR_Dataset/train/y_train.txt", sep = "")
subject_train <- read.table("UCI_HAR_Dataset/train/subject_train.txt", sep = "")

#reading test files
x_test <- read.table("UCI_HAR_Dataset/test/x_test.txt", sep = "")
y_test <- read.table("UCI_HAR_Dataset/test/y_test.txt", sep = "")
subject_test <- read.table("UCI_HAR_Dataset/test/subject_test.txt", sep = "")

#merge files
x_merge <- rbind(x_train, x_test)
y_merge <- rbind(y_train, y_test)
subject_merge <- rbind(subject_train, subject_test)

#read feature data file
features_data <- read.table("UCI_HAR_Dataset/features.txt", sep="")

#read activity labels file
activity_labels <- read.table("UCI_HAR_Dataset/activity_labels.txt", sep="")
activity_labels[,2] <- as.character(activity_labels[,2])

#read feature columns
feature_cols <- grep("-(mean|std).*", as.character(features_data[,2]))
selected_cols <- features_data[feature_cols, 2]
selected_cols <- gsub("-mean", "Mean", selected_cols)
selected_cols <- gsub("-std", "Std", selected_cols)
selected_colNames <- gsub("[-()]", "", selected_cols)

#extract data using feature columns
x_merge <- x_merge[feature_cols]
full_data <- cbind(subject_merge, y_merge, x_merge)
colnames(full_data) <- c("Subject", "Activity", selected_colNames)

full_data$Activity <- factor(full_data$Activity, levels = activity_labels[,1], labels = activity_labels[,2])
full_data$Subject <- as.factor(full_data$Subject)

#tidy the data set
melt_data <- melt(full_data, id = c("Subject", "Activity"))
tidy_data <- dcast(melt_data, Subject + Activity ~ variable, mean)

#write into a txt file
write.table(tidy_data, "./tidy_dataset.txt", row.names = FALSE, quote = FALSE)




