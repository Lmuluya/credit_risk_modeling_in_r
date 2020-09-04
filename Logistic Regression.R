str(training_set)

## Fitting a logistic model in r
log_model <- glm(loan_status ~ age,
                 family = "binomial", data = training_set)
log_model

## Buiding a generalised linear model with variable ir_cat as a predictor
log_model_cat <- glm(formula = loan_status ~ ir_cat, family = "binomial",
                     data = training_set)

# printing the parameter estimates
log_model_cat

# Look at the different categories in ir_cat using table()
table(loan_data$ir_cat)

# Build the logistic regression model
log_model_multi <- glm(loan_status ~ age + ir_cat + grade + loan_amnt +
                         annual_inc , family = "binomial", data = training_set)

# Obtain significance levels using summary()
summary(log_model_multi)

# Build the logistic regression model

log_model_small<-glm(formula=loan_status~age+home_ownership,family="binomial",data=training_set)

test_case<-as.data.frame(test_set[1,])

predict(log_model_small,newdata=test_case,type="response")


# Build the logistic regression model on

log_model_age_ir<-glm(formula=loan_status~age+ir_cat,family="binomial",data=training_set)

test_case<-as.data.frame(test_set[,])

predictions_all_age_ir<-predict(log_model_age_ir,newdata=test_case,type="response")

# Look at the range of the object 
range(predictions_all_age_ir)

# Build the logistic regression model
log_model_full <- glm(loan_status ~ ., family = "binomial", data = training_set)

# Make PD-predictions for all test set elements using the the full logistic regression model
predictions_all_full <- predict(log_model_full, newdata = test_set, type = "response")

# Look at the predictions range
range(predictions_all_full)

# The code for the logistic regression model and the predictions is given below
log_model_full <- glm(loan_status ~ ., family = "binomial", data = training_set)
predictions_all_full <- predict(log_model_full, newdata = test_set, type = "response")

# Make a binary predictions-vector using a cut-off of 15%
pred_cutoff_15 <- ifelse(predictions_all_full > 0.15, 1, 0)

# Construct a confusion matrix
table(test_set$loan_status, pred_cutoff_15)
