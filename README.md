This project is based on the Davide Anguita, Alessandro Ghio, Luca Oneto, 
Xavier Parra and Jorge L. Reyes-Ortiz Themos Patrikios publication 
"Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine".
International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This is my project submission and below is some notes and comments on the dataset# Getting-and-Cleaning-Data-Course-Project
Coursera Data Science Specialization - Getting and Cleaning Data Course Project

# Introduction

# Information on the Data 
This is not meant to be detailed information on the data and dataset. For more detailed 
information, kindly refer to the codebook for more information.

# Purpose of the Project 
The R script - run_analysis.R is responsible for the doing the following:

- Download the dataset if it does not already exist in the working directory
- Load the activity and feature info from the extracted files 
- Loads both the training and test datasets, keeping only those columns which reflect a mean or standard deviation
- Loads the activity and subject data for each dataset, and merges those columns with the dataset
- Merges the two respective datasets into a single dataset
- Converts the activity and subject columns into factors or descriptive names 
- Creates a file from the tidy or clean dataset that consists of the average (mean) value of each variable for each subject and activity pair.
- The final result of the script is the file tidy.txt which comprises of the final tidy dataset.