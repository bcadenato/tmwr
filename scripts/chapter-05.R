
# Libraries ---------------------------------------------------------------

library(tidymodels)
library(tidyverse)

# Load data ---------------------------------------------------------------

ames <- read_csv('results/ames_04.csv')

set.seed(501)

# Section 01 --------------------------------------------------------------

ames_split <- ames %>%
  initial_split(prop = 0.8)

ames_train <- ames_split %>% training()
ames_test <- ames_split %>% testing()

# Stratified sampling

set.seed(502)

ames_split <- ames %>%
  initial_split(prop = 0.8,
                strata = Sale_Price)

ames_train <- ames_split %>% training()
ames_test <- ames_split %>% testing()

dim(ames_train)

# Save output -------------------------------------------------------------

ames_train %>%
  write_csv('results/ames_train_05.csv')

ames_test %>%
  write_csv('results/ames_test_05.csv')

















