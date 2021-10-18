# Load packages

pacman::p_load(pacman, dplyr, GGally, ggplot2, ggthemes, ggvis,
               httr, lubridate, plotly, rip, rmarkdown, shiny, 
               stringr, tidyr)

library(datasets) 

# Load data

head(mtcars)
cars <- mtcars[, c(1:4, 6:7, 9:11)] # Select variables
head(cars)


# Compute PCA

# For entire data frame

pc <- prcomp(cars,
             center = TRUE,    # Mean = 0
             scale = TRUE)     # Std.dev = 1

# To specify variables

pc <- prcomp(~ mpg + cyl + disp + hp + wt + qsec + am + gear + carb,
             data = mtcars,
             center = TRUE,
             scale = TRUE)

# Examine results

summary(pc)
plot(pc)

# See how cases load on PCs

predict(pc) %>% round(2)

# Biplot of first two components

biplot(pc)
