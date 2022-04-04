
# Load libraries and data -------------------------------------------------

library(modeldata)

data(ames)

dim(ames)

# Section 4.1 -------------------------------------------------------------

library(tidymodels)
tidymodels_prefer()

g_01 <- ggplot(ames,
       aes(x = Sale_Price)
) +
  geom_histogram(bins = 50, colour = "white")

g_01

g_01 +
  scale_x_log10()

# The sale price is pre-logged in the data set

ames <- 
  ames %>%
  mutate(Sale_Price = log10(Sale_Price))

# Save results for future chapters

ames %>%
  readr::write_csv('results/ames_04.csv')

















