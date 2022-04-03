library(tidyverse)

data(crickets, package = "modeldata")

# Plot `crickets` data

crickets %>%
  ggplot(aes(temp, rate,
             colour = species,
             pch = species,
             lty = species)) +
  geom_point() +
  geom_smooth(method = lm,
              se = FALSE,
              alpha = 0.5) +
  scale_color_brewer(palette = 'Paired') +
  labs(x = "Temperature (C)",
       y = "Chirp Rate (per minute)")

# Model with interaction term

interaction_fit <- lm(rate ~ (temp + species)^2,
                      data = crickets)

interaction_fit

par(mfrow = c(2, 2))

plot(interaction_fit, which = 1)

plot(interaction_fit, which = 2)

plot(interaction_fit, which = 3)

plot(interaction_fit, which = 4)

# Model without interaction term

main_effect_fit <- lm(rate ~ temp + species,
                      data = crickets)

anova(main_effect_fit,
      interaction_fit)

summary(main_effect_fit)

# Prediction

new_values <- data.frame(species = "O. exclamationis", temp = 15:20)

predict(main_effect_fit, new_values)

# Secion 3.3 --------------------------------------------------------------

corr_res <- map(mtcars %>% 
                  select(-mpg),
                cor.test,
                y = mtcars$mpg)

corr_res[[1]]

library(broom)

tidy(corr_res[[1]])

corr_res %>%
  map_dfr(tidy,
          .id = "predictor") %>%
  ggplot(aes(x = fct_reorder(predictor, estimate))) +
  geom_point(aes(y = estimate)) + 
  geom_errorbar(aes(ymin = conf.low, ymax = conf.high), width = .1) +
  labs(x = NULL,
       y = "Correlation with mpg")

# Section 3.4 -------------------------------------------------------------

split_by_species <- 
  crickets %>%
  group_nest(species)

split_by_species

model_by_species <- 
  split_by_species %>%
  mutate(model = map(data,
                     ~ lm(rate ~ temp, data = .x)
                     )
  )

model_by_species %>%
  mutate(coef = map(model,
                    tidy)
  ) %>%
  select(species,
         coef) %>%
  unnest(cols = c(coef))

# Section 3.5 -------------------------------------------------------------

library(tidymodels)














