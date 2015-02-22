# datasciencecoursera testing
---
title: "ReadMe"
author: "Trupti Palande"
date: "Sunday, February 22, 2015"
output: word_document
---
This file describes how run_analysis.R script works.

1. First, unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and rename the folder with "dataset".
2. Make sure the folder "data" and the run_analysis.R script are both in the current working directory.
3. After running "run_analysis.R" file in RStudio, you will find two output files are generated in the current working directory :-
merged_data.txt: it contains a data frame called cleanedData with 10299 obs and 68 variables.
data_with_means.txt: it contains a data frame called result with 180 obs and 68 variables.
4. Use data <- read.table("data_with_means.txt") command in RStudio to read the file. Since we are required to get the average of each variable for each activity and each subject, and there are 6 activities in total and 30 subjects in total, we have 180 rows with all combinations for each of the 66 features. 

