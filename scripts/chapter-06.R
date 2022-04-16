
# Set up ------------------------------------------------------------------

library(tidyverse)
library(tidymodels)

tidymodels_prefer()

ames_train <- read_csv('results/ames_train_05.csv')

# Section 6.1 -------------------------------------------------------------

linear_reg() %>% set_engine('lm')

linear_reg() %>% set_engine('glmnet')

linear_reg() %>% set_engine('stan')

linear_reg() %>% set_engine('lm') %>% translate()

linear_reg(penalty = 1) %>% set_engine('glmnet') %>% translate()

linear_reg() %>% set_engine('stan') %>% translate()

lm_model <- 
  linear_reg() %>%
  set_engine('lm')

lm_form_fit <- 
  lm_model %>%
  fit(Sale_Price ~ Longitude + Latitude, data = ames_train)

lm_xy_fit <- 
  lm_model %>%
  fit_xy(
    x = ames_train %>%
      select(Longitude, Latitude),
    y = ames_train %>%
      select(Sale_Price)
  )

lm_form_fit

lm_xy_fit

# Section 6.2 -------------------------------------------------------------

lm_form_fit %>%
  extract_fit_engine()

lm_form_res <- 
  lm_form_fit %>%
  extract_fit_engine() %>%
  summary()

lm_form_fit %>%
  tidy()

ames_test_small <- 
  ames_test %>%
  slice(1:5)

lm_form_fit %>%
  predict(new_data = ames_test_small)

# Section 6.3 -------------------------------------------------------------

ames_test_small %>%
  select(Sale_Price) %>%
  bind_cols(predict(lm_form_fit,
                    ames_test_small)) %>%
  bind_cols(predict(lm_form_fit,
                    ames_test_small,
                    type = "pred_int"))

tree_model <-
  decision_tree(min_n = 2) %>%
  set_engine("rpart") %>%
  set_mode("regression")

tree_fit <- 
  tree_model %>%
  fit(Sale_Price ~ Longitude + Latitude,
      data = ames_train)

ames_test_small %>%
  select(Sale_Price) %>%
  bind_cols(predict(tree_fit,
                    ames_test_small))













