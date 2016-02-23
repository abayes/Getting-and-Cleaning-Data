## Getting and Cleaning Data Course Project
The run_analysis.R script will download the messy data and turn it into a tidy data set. The tidy dataset will be saved as "final.txt"
* First the environment will be set up. A folder will be created for the downloaded data, and the necessary packages will be loaded
* The data will be downloaded [if necessary] in the form of a zip file
* The files will be unzipped [if necessary]
* The data will be loaded and tidied
* The relevant data will be extracted
* The dataset will be saved to a file in the working directory: final.txt

Information about final.txt:
* final.txt has 180 observations 
* An observation is defined as each activity for each subject (30 subjects, 6 activities each)
* Measurements from 66 of the original features were used to create the final variables in the tidy data set
* final.txt can be read into R with: data <- read.table("final.txt")
