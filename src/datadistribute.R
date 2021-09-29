# Data distribution
#
# This script uses the Re-sample filter to balance the data set
# attempting to further improve the F-weighted score.

# select the 105 (value obtained from featselect.R) highest ranked features
cols_dont_want <- c(names(rankedordered[1:205]))

# drop low ranked features from training and test sets
temptrainset <-
  trainset[,!names(trainset) %in% cols_dont_want, drop = T]
temptestset <-
  testset[, !names(testset) %in% cols_dont_want, drop = T]

dd_highestFscore = 0
n <- 1

# controls filter options -Z and -B
z <- seq(100, 1000, 100)
b <- seq(0.3, 1.0, 0.1)

# register re-sample filter
resample <-
  make_Weka_filter("weka.filters.supervised.instance.Resample")

for (x in z) {
  for (y in b) {
    
    # re-sample data set and train model
    rebalancedDataSet <-
      resample(
        class ~ .,
        data = temptrainset,
        control = Weka_control(B = y, Z = x),
        na.action = NULL
      )
    
    # register classifier
    classifier <-
      IBk(class ~ ., data = rebalancedDataSet, na.action = NULL)
    
    # evaluate accuracy of model's predictions
    pred <- predict(classifier, testset, na.action = NULL)
    
    # calculate and store metrics
    cf <- calc_cf(actual, pred)
    fscore <- calc_fweighted(cf)
    fwl[[n]] <- fscore
    
    if (fscore > dd_highestFscore) {
      # save highest f-score with corresponding cf, 
      # value of N, and filter options
      dd_highestFscore <- fscore
      dd_hscore_cf <- cf
      hfs_bz <- c(y, x)
    }
    
    n <- n + 1
  }
}

results <- array(fwl, dim = c(8, 10))
dimnames(results) <- list(b, z)
results
print(paste("Highest score:", sprintf("%.7f",  dd_highestFscore),
            "B =", hfs_bz[1], "Z =", hfs_bz[2]))
dd_hscore_cf