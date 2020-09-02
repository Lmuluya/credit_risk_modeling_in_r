## Components of expected loss (EL)
# Probability of default (PD) probability that the borrower will fail to pay the outstanding obligation
# Exposure at default (EAD) Expected value of te loan at the time of default the amount of loan that is to be repaid
# Loss given default (LGD) Amount of loss if there is a default


########## Downloading the dataset from the web.
library(curl)
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://assets.datacamp.com/course/credit-risk-modeling-in-r/loan_data_ch1.rds"
download.file(fileUrl, destfile = "./data/loan_data.rds", method = "curl")
loan_data <- readRDS("./data/loan_data.rds")

## Review of the data set
head(loan_data, 10) # Selecting the top ten records of the dataset
str(loan_data) ## Estabilishig the structure of the dataset


