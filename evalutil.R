# Binary classification Evaluation Utility 

# This script includes functions used to calculate evaluation 
# metrics for Binary Classification models, such as confusion 
# matrix and F-weighted score.

calc_cf <- function(actual, predicted) {
  lengthdiff <- length(actual) - length(predicted)
  
  if (lengthdiff == 0) {
    cf <- array(0,
                dim = c(2, 2))
    
    for (cls in seq(1, length(actual))) {
      if (actual[cls] == 1) {
        if (predicted[cls] == 1) {
          cf[1, 1] <- cf[1, 1] + 1
        }
        else
        {
          cf[1, 2] <- cf[1, 2] + 1
        }
      }
      else if (actual[cls] == 2) {
        if (predicted[cls] == 2) {
          cf[2, 2] <- cf[2, 2] + 1
        }
        else
        {
          cf[2, 1] <- cf[2, 1] + 1
        }
      }
    }
    
    return(cf)
  }
  
  else {
    print(paste("Error: input parameters must be of identical length."))
  }
  
}

calc_fweighted <- function(cf) {
  n_cls1 <- cf[1, 1] + cf[1, 2]
  n_cls2 <- cf[2, 1] + cf[2, 2]
  prec_1 <- (cf[1, 1] / (cf[1, 1] + cf[2, 1]))
  prec_2 <- (cf[2, 2] / (cf[2, 2] + cf[1, 2]))
  recall_1 <- (cf[1, 1] / (cf[1, 1] + cf[1, 2]))
  recall_2 <- (cf[2, 2] / (cf[2, 2] + cf[2, 1]))
  f1_1 <- (2 * prec_1 * recall_1) / (prec_1 + recall_1)
  f1_2 <- (2 * prec_2 * recall_2) / (prec_2 + recall_2)
  fweighted <- (f1_1 * n_cls1 + f1_2 * n_cls2) / (n_cls1 + n_cls2)
  return(fweighted)
}
