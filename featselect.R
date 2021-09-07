# Feature Selection
# 
# This script experiments with the number of features in the data sets 
# to identify the best subset of features to train a model with.

fs_highestFscore <- 0

# controls how many features are dropped each iteration
for (k in seq(5, 305, 5)) {
  # identify names of low ranked features
  cols_dont_want <- c(names(rankedordered[1:k]))
  
  # drop low ranked features from training and test sets
  temptrainset <-
    trainset[, !names(trainset) %in% cols_dont_want, drop = T]
  temptestset <-
    testset[, !names(testset) %in% cols_dont_want, drop = T]
  
  # declare and train classifier
  classifier <-
    IBk(class ~ ., data = temptrainset, na.action = NULL)
  
  # deploy the new version of the test data set to make predictions
  pred <- predict(classifier,
                  temptestset,
                  na.action = NULL,
                  seed = 1)
  
  # calculate confusion matrix and F-weighted score
  cf <- calc_cf(actual, pred)
  fscore <- calc_fweighted(cf)
  
  if (fscore > fs_highestFscore) {
    # save highest f score with corresponding cf and value of N
    fs_highestFscore <- fscore
    fs_hscorecf <- cf
    n <- 310 - k
  }
  
}

print(paste("Highest F-weighted score =", fs_highestFscore,
            " N =", n))

print(array(fs_hscorecf, dim = c(2, 2))) # print matrix