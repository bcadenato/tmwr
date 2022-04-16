
# Carry-on code -----------------------------------------------------------

library(tidymodels)

data(ames)
ames <- mutate(ames, Sale_Price = log10(Sale_Price))

set.seed(123)

ames_split <- initial_split(ames, prop = 0.80, strata = Sale_Price)
ames_train <- training(ames_split)
ames_test <- testing(ames_split)

lm_model <- linear_reg() %>% set_engine("lm")
