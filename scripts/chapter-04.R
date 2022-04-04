
# Load libraries and data -------------------------------------------------

library(modeldata)

data(ames)

dim(ames)

# Section 4.1 -------------------------------------------------------------

library(tidymodels)
tidymodels_prefer()

ggplot(ames,
       aes(x = Sale_Price)
) +
  geom_histogram(bins = 50, colour = "white")


















