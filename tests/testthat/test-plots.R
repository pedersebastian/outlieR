set.seed(123)
mtcars["V1"] <- c(rnorm(29), -100, 100, NA)
set.seed(234)
mtcars["V2"] <- c(-50, 32, rnorm(30))
set.seed(345)
mtcars["V3"] <- c(rep(TRUE, 31), FALSE)
filtred_V3 <-
  mtcars |>
  filter_outlier(V3)

filtred_V1_omit <-
  mtcars |>
  filter_outlier(V1)

filtred_V_ALL_omit <-
  mtcars |>
  filter_outlier(V1, V2, V3)


test_that("plots_error", {
  expect_error(autoplot(filtred_V_ALL_omit, type = 123))
  expect_error(autoplot(filtred_V_ALL_omit, type = "da"))
  # expect_error(autoplot(filtred_V_ALL_omit, type = NULL))
})


test_that("plots_plot", {
  vdiffr::expect_doppelganger("A blank plot", ggplot2::ggplot())
})
