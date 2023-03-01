# Load necessary packages
library(tibble)
library(vars)

# Create example data
set.seed(123)
data <- tibble(
  Date = seq(as.Date("2000/1/1"), by = "quarter", length.out = 84),
  USA_IR = rnorm(84, 2, 1),
  UK_IR = rnorm(84, 1.5, 0.5),
  Japan_IR = rnorm(84, 0.5, 0.1),
  USA_Inflation = rnorm(84, 2, 0.5),
  UK_Inflation = rnorm(84, 2.5, 0.75),
  Japan_Inflation = rnorm(84, 1, 0.25),
  USA_GDP = rnorm(84, 100, 10),
  UK_GDP = rnorm(84, 80, 5),
  Japan_GDP = rnorm(84, 50, 2)
)

# Estimate the GVAR model
gvar <- VAR(data[, -1], p = 2, type = "const")
summary(gvar)

# Generate impulse response functions
irf_gvar <- irf(gvar, impulse = "USA_IR", response = c("USA_IR", "USA_Inflation", "USA_GDP"))

# Plot impulse response functions
plot(irf_gvar)


irf_gvar1 <- irf(gvar, impulse = "USA_IR", response = c("Japan_GDP", "UK_GDP", "USA_GDP"))
plot(irf_gvar1)

graphics.off()
# Generate forecast error variance decomposition(Forecast error variance decomposition (FEVD) plots show the proportion of the forecast error variance of each variable that can be attributed to shocks from each variable in the mode)
fevd_gvar <- fevd(gvar)

# Plot forecast error variance decomposition
plot(fevd_gvar)


