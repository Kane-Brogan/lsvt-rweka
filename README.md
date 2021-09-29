# lsvt-rweka
Data mining project to analyse patient's response to speech therapy

## Project Setup
You must have R or RStudio installed on your PC to run R scripts.

1. Edit dataprep.R to specify project file path in "setwd"
2. Run dataprep.R

## Full Data Set Results
| Classifier      | F-weighted Score |
| --------------- | :--------------: |
| IBk             | 0.7836           |
| J48             | 0.7500           |
| Naïve Bayes     | 0.7451           |
| OneR            | 0.6500           |

## Feature Selection Results
| Classifer       | Highest F-weighted Score | # of Features (N) |
| --------------- | :----------------------: | :---------------: |
| **IBk**         | 0.9261017                | 105     	         |
| **J48**         | 0.85                     | 5                 |
| **Naïve Bayes** | 0.8592593                | 45                |
| **OneR**        | 0.7138047                | 10                |


## Data Distribution Results
| Classifier               | Highest F-weighted Score | biasToUniformClass (B) | Sample size % (Z) |
| ------------------------ | :----------------------: | :--------------------: | :---------------: |
| **IBk**                  | 0.9261017                | 0.3                    | 500          	   |
| **J48**                  | 0.8728914                | 0.4                    | 300          	   |
| **Naïve Bayes**          | 0.7918367                | 0.3                    | 100          	   |
| **OneR**                 | 0.9027409                | 0.4                    | 500       	   |