## Getting and Cleaning Data: Tidy data and summarization

The original dataset can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The **feature_info.txt** file included in that dataset provides an excellent
overview of the contained measurements.

For this project we transformed those measurements in the following ways:

1. Merge the datasets into one

  This means taking the activity labels, subject ids, and observations from
  both the training and test sets and combining them into one uber data frame.

1. Tidy the column headers

  Names should contain only lowercase characters, so the existing feature
  labels were transformed using the `CleanName` function.

1. Relabel activities

  Activity ids were remapped to friendly activity names.

1. Subset the observations to just mean and standard deviation measurements

  The original dataset contained many more observations than we needed, so just
  those with names containing "mean" or "std" were carried forward to the tidy
  dataset.

#### Summarization

At this point the tidy dataset has been created and we are ready for
summarization by subject and activity, taking the mean of the measurements for
each.

1. Melt the data into a data frame that has a row for each subject, activity,
and measurement.

1. Regroup the data using dcast to group by rows containing subject and
activity, columns containing measurements, and values containing the average
(mean) of those groups.

