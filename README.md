#Getting and Cleaning Data Course Project
Course: getdata-014

##Introduction

The included R script is able to download a dataset collected by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, and Luca Oneto at Smartlab - Non Linear Complex Systems Laboratory at University degli Studi di Genova. 

The script recombines training and testing datasets, and creates a subset of data containing the Mean and Standard Deviation of all of the data collected. See the 'codebook.md' file for more information on retained data.

More information on the source dataset can be found at [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) or by reading the README.txt file included in the unzipped datafile.

##Usage

This script can be run by sourcing into R, then by calling: 
```
run_analysis()
```

If the data is not available, it will download and unpack the data, printing a resulting data collection to file called Processed_Data.txt in the data subdirectory. 

This data can be re-read to R by the following command:
```
read.table("./data/Processed_Data.txt", header = TRUE)
```

Note that column names have been processed to remove special characters and duplicates.

##Software Licence
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


##Dataset Licence

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.