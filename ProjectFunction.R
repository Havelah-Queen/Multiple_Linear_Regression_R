
mlr <- function(dataset, outcome, predictors) {
  # Check if variables are correct type
  if(!is.data.frame(dataset)) {
    stop(paste(dataset," must be a data frame."))
  }
  if (!is.character(outcome) || length(outcome) == 0) {
    stop("Outcome(s) must be a character or a vector of characters.")
  }
  
  if (!is.character(predictors) || length(predictors) == 0) {
    stop("Predictors must be a character or a vector of characters.")
  }
  
  # Check if the outcome and predictors are valid
  
  if(!all(outcome %in% names(dataset))) {
    missing_outcomes <- outcome[!outcome %in% names(dataset)]
    stop(paste("Outcome variable(s)", paste(missing_outcomes, collapse = ", "), "not found in the dataset."))
  }
  
  if(!all(predictors %in% names(dataset))) {
    missing_predictors <- predictors[!predictors %in% names(dataset)]
    stop(paste("Predictor variable(s)", paste(missing_predictors, collapse = ", "), "not found in the dataset."))
  }
  if(any(outcome %in% predictors)) {
    stop("The outcome variable cannot be used as a predictor.")
  }
  
  #Handle multiple outcome variables
  for(out in outcome){
    
    # Check for missing data
    missing_outcome <- any(is.na(dataset[[out]]))
    missing_predictors <- rowSums(is.na(dataset[predictors])) > 0
    
    
    if(missing_outcome || any(missing_predictors)) {
      warning("Missing data in the outcome or predictor variables. Rows with NA will be excluded.")
      dataset <- dataset[!is.na(dataset[[out]]) & !missing_predictors, ]
    }
    
    
      # Matrices
      y <- as.matrix(dataset[[out]])
      
      x <- as.matrix(data.frame(1, dataset[predictors]))
      
      # Output A beta_hat = (x'x)^(-1) x'y
      beta_hat <- solve(t(x) %*% x) %*% t(x) %*% y
      y_hat <- x %*% beta_hat
      residuals <- (y - y_hat)
      
      # Standard errors (SE = sqrt(s^2 * diag((x'x)^(-1))))
      # Step 1: Calculate sample variance of residuals (s^2=RSS/n-p-1 )
      # RSS=y'y-b'X'y
      RSS<-t(y)%*%y-t(beta_hat)%*%t(x)%*%y #residual sum of squares
      n <- nrow(x)   #number of observations
      p <- ncol(x)-1 #number of predictors
      
      s2<-as.numeric(RSS/(n-p-1)) #sample variance
      
      # Step 2: Variance-Covariance of Betas Matrix
      ainv<-solve(t(x)%*%x) 
      var_b <-s2*ainv #var-covar of betas matrix
      
      # Output B Std Errors
      std_error <- sqrt(diag(var_b))
      
      
      # Output C R-squared
      SYY<-t(y)%*%y-length(y)*mean(y)**2 #total sum of squares
      R2 <- 1 - (RSS /SYY) #multiple R squared
      
      # Additional Functionality:
      
      # Adjusted R
      adj_R2<-(((n-1)*R2)-p)/(n-p-1)
      
      
      # Two-tailed t-test (beta/SE(beta))
      t_value <-beta_hat / std_error
      p_value <- 2 * pt(-abs(t_value), df = n - p-1)
      
      # F-test 
      SSreg<-t(beta_hat) %*% t(x)%*%y-length(y)*mean(y)**2 #sum of squares of regression
      F_stat <- (SSreg / (p) / (RSS / (n-p-1)))
      p_value_Fstat <- 1-pf(F_stat, df1=p, df2=n-p-1)
      p_value_Fstat_display <- ifelse(p_value_Fstat < 2.2e-16, "< 2.2e-16",ifelse(p_value_Fstat < 0.0001, formatC(p_value_Fstat, format = "e", digits = 2), formatC(p_value_Fstat, format = "f", digits = 6)))
      
      # Output results
      cat("Response:", out, "\n")
      results_table <- data.frame(
        beta_estimate = round(beta_hat, 5),
        std_error = round(std_error, 5),
        t_value = round(t_value, 3),
        p_value = ifelse(p_value < 2.2e-16, "< 2.2e-16",ifelse(p_value < 0.0001, formatC(p_value, format = "e", digits = 2), formatC(p_value, format = "f", digits = 6)))
      )
      row.names(results_table) <- c("Intercept", predictors)
      
      
      print(results_table)
      cat("R-Squared:", round(R2, 4), "\n")
      cat("Adjusted R-Squared:", round(adj_R2, 4), "\n")
      cat("F-statistic:", round(F_stat, 3)," on ", p," and", n-p-1, " DF",", p-value:", p_value_Fstat_display, "\n\n")
  }
}

