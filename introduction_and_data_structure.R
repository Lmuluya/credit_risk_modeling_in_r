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

# Using the breaks urgument
n_breaks <- sqrt(nrow(loan_data)) #n_breaks = 170.5638
hist_income_n <- hist(loan_data$annual_inc, breaks = n_breaks,
                      xlab = "Annual Income", main = "Histogram of Annual Income")
# Scatter plot of annual income

plot(loan_data$annual_inc, ylab = "Annual Income")

# Finding an aoutlier in the dataset
index_outlier_expert <- which(loan_data$annual_inc > 3000000)

# Removing the outlier from the data set
loan_data_expert <- loan_data[-index_outlier_expert]

hist(loan_data_expert$annual_inc,
     sqrt(nrow(loan_data_expert)),
     xlab = "Annual Income")

#Bivariate plot
plot(loan_data$emp_length, loan_data$annual_inc,
     xlab = "Employment Length", ylab = "Annual Income")

# Creating a  histogram of loan_amnt: hist_1
hist_1 <- hist(loan_data$loan_amnt)

# Print locations of the breaks in hist_1
hist_1$breaks

# Change number of breaks and add labels: hist_2
hist_2 <- hist(loan_data$loan_amnt, breaks = 200, xlab = "Loan amount",
               main = "Histogram of the loan amount")

# Plot the age variable
plot(loan_data$age, ylab = "Age")

# Save the outlier's index to index_highage
index_highage <- which(loan_data$age > 122)

# Create data set new_data with outlier deleted
new_data <- loan_data[-index_highage, ]

# Make bivariate scatterplot of age and annual income
plot(loan_data$age, loan_data$annual_inc, xlab = "Age", ylab = "Annual Income")

## Missing data from a dataset
# Looking at summary of a variable in a dataset
summary(loan_data$emp_length)
summary(loan_data$home_ownership)
summary(loan_data$int_rate)

# Get indices of missing interest rates: na_index
na_index <- which(is.na(loan_data$int_rate))

# Remove observations with missing interest rates: loan_data_delrow_na
loan_data_delrow_na <- loan_data[-na_index, ]

# Make copy of loan_data
loan_data_delcol_na <- loan_data

# Delete interest rate column from loan_data_delcol_na
loan_data_delcol_na$int_rate <- NULL

# Compute the median of int rate
median_ir <- median(loan_data$int_rate, na.rm = TRUE)

# Make copy of loan_data
loan_data_replace <- loan_data

# Replace missing interest rates with median
loan_data_replace$int_rate[na_index] <- median_ir

# Check if the NAs are gone
summary(loan_data_replace$int_rate)

# Make the necessary replacements in the coarse classification example below
loan_data$ir_cat <- rep(NA, length(loan_data$int_rate))

loan_data$ir_cat[which(loan_data$int_rate <= 8)] <- "0-8"
loan_data$ir_cat[which(loan_data$int_rate > 8 & loan_data$int_rate <= 11)] <- "8-11"
loan_data$ir_cat[which(loan_data$int_rate > 11 & loan_data$int_rate <= 13.5)] <- "11-13.5"
loan_data$ir_cat[which(loan_data$int_rate > 13.5)] <- "13.5+"
loan_data$ir_cat[which(is.na(loan_data$int_rate))] <- "Missing"

loan_data$ir_cat <- as.factor(loan_data$ir_cat)

# Look at your new variable using plot()
plot(loan_data$ir_cat)
