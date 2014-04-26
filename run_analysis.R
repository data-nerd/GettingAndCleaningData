# Create a tidy dataset from UCI's Human Activity Recognition Using Smartphones Data Set 
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# This script assumes that the dataset has been extracted to the current
# directory.

# Clean a name so that it contains only lowercase characters
CleanName <- function(name) {
    tolower(gsub("[^[:alnum:]]", "", name))
}

# Load the activity labels and clean them, returning a vector of activities
LoadActivityLabels <- function() {
    activityLabels <- fread("activity_labels.txt")
    setnames(activityLabels, c("activityid", "activity"))

    # Clean the labels so they're all lowercase letters, no spaces etc.
    activityLabels$activity <- sapply(activityLabels$activity, CleanName)

    activityLabels
}

# Load the feature labels and clean them, returning a vector of feature names
LoadFeatureLabels <- function() {
    featureLabels <- fread("features.txt")
    setnames(featureLabels, c("featureid", "feature"))

    # Clean the labels so they're all lowercase letters, no spaces etc.
    featureLabels$feature <- sapply(featureLabels$feature, CleanName)

    featureLabels
}

LoadDataset <- function(directory, activityLabels, featureLabels) {
    # Set this variable to limit the number of rows loaded. This speeds up
    # load times for faster iteration. Set to -1 to load all rows.
    debugRowLimit <- -1

    # Who the observations are about
    subjects <- fread(paste0(directory, "/subject_", directory, ".txt"),
        nrows = debugRowLimit)
    setnames(subjects, "subject")

    # What activties they were doing
    activities <- fread(paste0(directory, "/y_", directory, ".txt"),
        nrows = debugRowLimit)
    setnames(activities, "activityid")
    
    # Observations
    observations <- read.table(paste0(directory, "/X_", directory, ".txt"),
        header = FALSE, nrows = debugRowLimit)
    setnames(observations, unlist(featureLabels$feature))

    # Select out the mean and standard deviation measurements
    meanAndStd <- observations[, grep("(mean|std)", names(observations), value=TRUE)]

    # Combine the activities, activity labels, subjects, and observations
    # into one data frame
    merged <- cbind(
        subjects,
        activityLabels[activities$activityid]$activity,
        meanAndStd)

    # Update the Activity column name which was lost in the merge
    setnames(merged, 2, "activity")

    # Return the resulting merged dataset
    merged
}

# Main function that loads the datasets, cleans them up, and selects a subset
# of the observations.
CreateTidyDataset <- function() {
    # Load the required libraries. The packages must already be installed.
    require(data.table)

    # Load the labels that are used in both the training and test datasets
    activityLabels <- LoadActivityLabels()
    featureLabels <- LoadFeatureLabels()

    # Load the test and training sets
    train <- LoadDataset("train", activityLabels, featureLabels)
    test <- LoadDataset("test", activityLabels, featureLabels)

    # Combine the datasets into one
    tidy <- rbind(train, test)

    # Return the results
    tidy
}

# Summarize the given dataset with the average of each variable for each
# activity and each subject.
CreateSummaryOfTidyDataset <- function(dataset) {
    # Load the required libraries. The packages must already be installed.
    require(data.table)
    require(reshape2)

    # Melt the dataset into rows by subject and activity for each observation
    melted <- melt(dataset, id.vars=c("subject", "activity"))
    
    # Create a summary table
    summary <- dcast(melted, subject + activity ~ variable, mean)
}
