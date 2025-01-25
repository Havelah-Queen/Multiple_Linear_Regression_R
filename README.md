# Multiple Linear Regression Project-R
Author: Havelah Queen, hqueen@bu.edu 
## Project Overview
Developed a linear regression function in RStudio that accommodates multiple outcome variables and   predictor sets while ensuring the validity of input data types and variable names. Implemented checks for missing data, excluding affected rows from analysis. Output included β coefficients, standard errors, R2, adjusted R2, as well as relevant statistics for t-tests and F-tests.
## Instructions
Please create a function that will run multiple linear regression from first principles using ordinary least squares and linear algebra. This means that you will need to code the formulas for linear regression estimation from scratch. The minimum number of parameters of your function are:
1) Input dataset
2) Outcome variable
3) Multiple predictors (the number of predictors should be allowed to vary from application to application)

The minimum output should include the following:  

1) Parameter estimates for all predictors  
2) Standard errors for all predictors  
3) R-squared goodness of fit measure  

# MLR Documentation
## Description
mlr is a void function used to perform linear regression with one or more predictors using ordinary least squares and algebra.
## Arguments
dataset: A data frame containing variables in the model.
outcome: A character or vector of characters that names the chosen response variables from the dataset.
predictors: A character or vector of characters with names of predictors.
## Examples
### One outcome variable
mlr() output: 

![OneOutcome](https://github.com/user-attachments/assets/82e8d915-7749-4cc9-bde6-5e4ecfcdf3e3)






lm() output:
 
![OneOutLM](https://github.com/user-attachments/assets/a76b4ccc-f3aa-4484-be00-cb00c9e9d816)

### Multiple outcome variables
mlr() output:
 
![MultOutMLR](https://github.com/user-attachments/assets/f722a3f6-0757-4150-b65c-1afecde5c876)



lm() output:

![MultOutLM](https://github.com/user-attachments/assets/98cf337c-6f8d-4816-b38f-241c8987fd2d)
![MultOutLM2](https://github.com/user-attachments/assets/9e4bc185-180f-445c-a6ea-4e7c78fe2fd9)

 


## Errors and Warnings  
### NAs in Dataset
mlr() output:
Gives formal warning and proceeds with method.
 ![NA_MLR](https://github.com/user-attachments/assets/6da91fd2-ad51-4b0a-9ee7-728008fd32c6)

lm() output:
Does not give a formal warning, but does notify of deletions due to missingness.
 ![NA_LM](https://github.com/user-attachments/assets/8b1f6361-3aa7-4f99-87cb-b2106094edc1)





### Dataset Input not a Data Frame
mlr() output:

 ![TypeMLR](https://github.com/user-attachments/assets/fb92ad7d-4dcf-4fb2-9869-fc1e6c732c09)

lm() output:

 ![TypeLM](https://github.com/user-attachments/assets/58930d01-14d7-4426-b8f9-4dd47e858b05)


### Outcome Variable Not in Dataset
mlr() output:

 ![NotFound_MLR](https://github.com/user-attachments/assets/f44c3cd0-1708-45fd-9908-f20bd5423edd)

lm() output:

 ![NotFound_LM](https://github.com/user-attachments/assets/6f6e0f98-953f-4748-94bd-0af0dfce3b13)


### Predictor(s) Not in Dataset
mlr() output:

 ![NotFoundPred_MLR](https://github.com/user-attachments/assets/49cc7358-1aba-404c-9e4d-fa9551401922)

lm() output:

![NotFoundPred_LM](https://github.com/user-attachments/assets/cc6d6652-74b2-4f3f-b271-e352a85e3386)

