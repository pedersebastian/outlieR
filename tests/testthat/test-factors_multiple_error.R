library(outlieR)
mtcars["V12"] <- factor(rep(LETTERS[1:5], times = c(10, 5, 15, 1, 1)))
mtcars["V13"] <- rep(LETTERS[1:5], times = c(13, 12, 1, 5, 1))
set.seed(123)
mtcars["V14"] <- rep(c(LETTERS[1:4], NA_character_), times = c(13, 1, 1, 5, 12)) |> sample()
set.seed(312)
mtcars["V15"] <- factor(rep(c(LETTERS[9:12], NA_character_), times = c(13, 1, 1, 5, 12)) |> sample())



###########

# xxxx <- filter_outlier(tibble::as_tibble(mtcars), V12, V13, control = control_filter_outlier(
#   discrete_method = "n",
#   n_vars = 2
# ))
# xxxx <- filter_outlier(tibble::as_tibble(mtcars), V12, V13, control = control_filter_outlier(
#   discrete_method = "prop",
#   min_times = 0.1
# ))





test_that("factor_works_multiple", {})


test_that("factor_fails", {

})
