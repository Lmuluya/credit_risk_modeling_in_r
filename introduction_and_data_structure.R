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

## Loading the gmodels package in order to use the CrossTable funcion.
library(gmodels)
CrossTable(loan_data$home_ownership)

## CrossTable gives more information than table. It shows the proportions as well.
table(loan_data$home_ownership)

## Relating home_ownership with loan_status
CrossTable(x = loan_data$home_ownership, y = loan_data$loan_status, prop.r = TRUE,
           prop.c = FALSE, prop.t = FALSE, prop.chisq = FALSE)

#Cross table on loan status
# Call CrossTable() on loan_status
CrossTable(loan_data$loan_status)

# Call CrossTable() on grade and loan_status
CrossTable(loan_data$grade, loan_data$loan_status, prop.r = TRUE,
           prop.c = FALSE, prop.t = FALSE, prop.chisq = FALSE)

## Data visualisations
## Using histograms
## Call the function histogram

hist(loan_data$int_rate, main ="Histogram of interest rate",xlab = "Interest Rate")


## Looking at the histogram of of annual income
hist(loan_data$annual_inc, xlab = "Annual Income", main = "Histogram of Annual income")
# Does not visually okay

# Another view
hist_income <- hist(loan_data$annual_inc,
                    xlab = "Annual Income",
                    main = "Histogram of Annual Income")
hist_income$breaks


