The script run_analyis.R works as follows:

1) The data sets (measurements, activity labels and subject ids) are read in R
2) The columns of the measurement data, the activity labels data and the subject data sets are appropriately named
3) The names of the measurements corresponding to mean and standard deviation are extracted from both the test and train data sets
4) The columns corresponding to the names extracted in step 3 are extracted from the test and train data measurements
5) The test and train data sets contain 3 parts each - the measurements, the activity lables and the subject ids. All the 3 parts are the merged together to create complete test and train data sets respectively
6) The test and train data sets are appended to create a whole data set
7) Average measurement for each activity and subject is calculated from the whole data to create the tidy data set
