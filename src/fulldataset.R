# Full Data Set Model
# 
# This script creates a classifier using all attributes in the data set.

# drop class from train and test sets
temptrainset <- trainset[, 1:311]
temptestset <- testset[, 1:310]
  
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

print(paste("F-weighted score =", fscore, "N=310"))
print(array(cf, dim = c(2, 2))) # print cf