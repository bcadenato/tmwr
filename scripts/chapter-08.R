
# Load previous chapter carry on data -------------------------------------

source("scripts/chapter-07-out.R")

# Section 8.1 -------------------------------------------------------------

library(tidymodels)
tidymodels_prefer()

library(tidyverse)

simple_ames <- 
  recipe(Sale_Price ~ Neighborhood + Gr_Liv_Area + Year_Built + Bldg_Type,
         data = ames_train) %>%
  step_log(Gr_Liv_Area, base = 10) %>%
  step_dummy(all_nominal_predictors())

# Section 8.2 -------------------------------------------------------------

lm_wflow <- lm_wflow %>%
  remove_variables() %>%
  add_recipe(simple_ames)

lm_wflow

lm_fit <- fit(lm_wflow, ames_train)

predict(lm_fit, ames_test %>% slice(1:3))

lm_fit %>%
  extract_recipe(estimated = TRUE)

lm_fit %>%
  extract_fit_parsnip() %>%
  tidy()

# Section 8.6 -------------------------------------------------------------

ames_rec <- 
  recipe(Sale_Price ~ Neighborhood + Gr_Liv_Area + Year_Built + Bldg_Type + 
           Latitude + Longitude, data = ames_train) %>%
  step_log(Gr_Liv_Area, base = 10) %>% 
  step_other(Neighborhood, threshold = 0.01) %>% 
  step_dummy(all_nominal_predictors()) %>% 
  step_interact( ~ Gr_Liv_Area:starts_with("Bldg_Type_") ) %>% 
  step_ns(Latitude, Longitude, deg_free = 20)

tidy(ames_rec)

ames_rec <- 
  recipe(Sale_Price ~ Neighborhood + Gr_Liv_Area + Year_Built + Bldg_Type + 
           Latitude + Longitude, data = ames_train) %>%
  step_log(Gr_Liv_Area, base = 10) %>% 
  step_other(Neighborhood, threshold = 0.01, id = "my_id") %>% 
  step_dummy(all_nominal_predictors()) %>% 
  step_interact( ~ Gr_Liv_Area:starts_with("Bldg_Type_") ) %>% 
  step_ns(Latitude, Longitude, deg_free = 20)

lm_wflow <- 
  workflow() %>%
  add_model(lm_model) %>%
  add_recipe(ames_rec)

lm_fit <- fit(lm_wflow, ames_train)

estimated_recipe <- lm_fit %>%
  extract_recipe(estimated = TRUE)

tidy(estimated_recipe, id = "my_id")

tidy(estimated_recipe, number = 3)






