## Getting and Cleaning Data peer assessment

This repo contains the files for Data-Nerd's Getting and Cleaning Data peer assessment.

The assignment description can be found at https://class.coursera.org/getdata-002/human_grading

The goal is to take an existing dataset of accelerometer readings and perform
transformations that creates a tidy dataset for further analysis.

The original dataset can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Files

**run_analysis.R** - This file contains all of the code for this assignment.

The code is broken into functions for readability and later profiling. Helper
function are near the top of the file and functions that reference them are
lower.

### Prerequisites

The following packages must be installed before using the run_analysis.R script:

* data.table
* reshape2

### Usage

1. Change to the directory that contains the run_analysis.R script and the
UCI HAR raw data files.

1. Load the run_analysis.R file

        source("run_analysis.R")

1. Load and transform the data to create a tidy dataset (see CodeBook.md for
a complete description of the variables and transformations):

        dataset <- CreateTidyDataset()
    
1. Summarize the tidy dataset with the average of each variable for each
activity and each subject:

        summary <- CreateSummaryOfTidyDataset(dataset)

1. Write the summary dataset to tidy.csv.txt:

        write.table(summary, "tidy.csv.txt", sep=",", row.names=FALSE)
