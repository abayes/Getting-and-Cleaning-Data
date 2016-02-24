## Getting and Cleaning Data Course Project
The run_analysis.R script turns messy Human Activity Recognition data into a tidy data set. The tidy dataset will be saved as "final.txt"
* The script assumes the data has already been downloaded and unzipped
    * codebook.md has the structure of how the data needs to be saved for run_analysis.R to work
* The data will be loaded and tidied
* The relevant data will be extracted
* The dataset will be saved to a file in the working directory: final.txt

Information about final.txt:
* final.txt has 180 observations 
* An observation is defined as each activity for each subject (30 subjects, 6 activities each)
* Measurements from 66 of the original features were used to create the final variables in the tidy data set
* final.txt can be read into R with: data <- read.table("final.txt", header = TRUE)
