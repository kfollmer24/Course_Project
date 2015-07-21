==================================================================
Human Activity Recognition Using Smartphones Dataset Summary and Aggregation
Version 1.0
==================================================================
KaraLea Follmer
https://github.com/kfollmer24
==================================================================

This program aggregates and summarizes the "Human Activity Recognition Using Smartphones Dataset: Version 1.0"  Created by Smartlab - Non Linear Complex Systems Laboratory.

The program completes the following steps:
======================================
- Read the necessary lookup tables
- Read the training and test data and place them together in one data set
- Add the variable names 
- Use dplyr package to take the mean and sd of every variable
- Match the activities to activities names based on the associated reference number
- Create a data set that takes the mean of every variable by subject and activity (30 subjects * 6 activities = 180 mean calculations)
- Output that final dataset


Packages Used:
======================================
dplyr

It outputs the following:
======================================
A data set that takes the mean of every variable by subject and activity (30 subjects * 6 activities = 180 mean calculations)