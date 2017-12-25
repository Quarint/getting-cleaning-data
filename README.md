# getting-cleaning-data

Final assignment for the "Getting and Cleaning Data" Coursera course by the Johns Hopkins University.

** In order for the script to work, you must :**
- Download the raw data from the following url : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
- Unzip the data into a directory named ```UCI HAR Dataset``` that will be placed **in the same directory** as the ```run_analysis.R``` script. If you chose another name for the directory, you will need to edit line ```17``` of the ```run_analysis.R``` script with the name of your directory.
- The script require both ```plyr``` and ```dplyr``` packages in order to function. It will try to install the required packages if needed.

You may now run the ```run_analysis.R``` script. It will output a CSV file containing a tidy data set, ```tidy_data.csv```.

More information on the analysis can be found in the ```CodeBook.md``` file.