# Data preparation
# 
# Loads and prepares data files and identifies the best set 
# of features by using the Gain Ratio feature selection filter.

library(RWeka)

# specify project file path
setwd("C:/../../../lsvt-rweka")


source("evalutil.R")

# load data
trainset <-
  read.arff("data/lsvt-train.arff")
testset <-
  read.arff("data/lsvt-test.arff")

# set target attribute name to "class"
names(trainset)[311] <- "class"
names(testset)[311] <- "class"

# get class values from test set
actual <- testset[, 311]

# rank features by information gain score
ranked <-
  GainRatioAttributeEval(class ~ ., data = trainset, na.action = NULL)

# sorting in ascending order
rankedordered <- ranked[order(ranked)]