
# Load previous chapter carry-on code -------------------------------------

source("scripts/chapter-06-out.R")

# Section 7.2 -------------------------------------------------------------

lm_wflow <- 
  workflow() %>%
  add_model(lm_model)

lm_wflow <- 
  lm_wflow %>%
  add_formula(Sale_Price ~ Longitude + Latitude)

lm_fit <- fit(lm_wflow, ames_train)

lm_predict <- 
  predict(lm_fit, ames_test %>% slice(1:3))

# Section 7.3 -------------------------------------------------------------

lm_wflow <- 
  lm_wflow %>%
  remove_formula() %>%
  add_variables(outcomes = Sale_Price,
                predictors = c(Longitude, Latitude))

lm_wflow %>%
  fit(ames_train)

# Section 7.5 - Workflow Set ----------------------------------------------

location <- list(
  longitude = Sale_Price ~ Longitude,
  latitude = Sale_Price ~ Latitude,
  coords = Sale_Price ~ Longitude + Latitude,
  neighborhood = Sale_Price ~ Neighborhood
)

library(workflowsets)

location_models <- 
  workflow_set(
    preproc = location,
    models = list(lm = lm_model)
  )

location_models <- 
  location_models %>%
  mutate(fit = map(info, ~ fit(.x$workflow[[1]], ames_train)))

# Section 7.6 - Test set evaluation ---------------------------------------

final_lm_res <- last_fit(lm_wflow, ames_split)

fitted_lm_wflow <- extract_workflow(final_lm_res)

collect_metrics(final_lm_res)

collect_predictions(final_lm_res)















