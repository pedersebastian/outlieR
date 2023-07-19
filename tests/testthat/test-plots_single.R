set.seed(123)
mtcars["V1"] <- c(rnorm(29), -100, 100, NA)
set.seed(234)
mtcars["V2"] <- c(-50, 32, rnorm(30))
mtcars["V3"] <- c(rep(TRUE, 31), FALSE)
mtcars["V4"] = c(rep(2, 31), 100)
mtcars["V5"] = c(rep(TRUE, 16), rep(FALSE, 16))
mtcars["V6"] = c(rep(FALSE, 31), TRUE)
mtcars["V7"] = c(rep(2, 31), -100)
mtcars["V8"]  = rep(FALSE, 32)
mtcars["V9"]  = c(rep(FALSE, 15), rep(NA, 16),TRUE)
mtcars["V10"]  = rep(TRUE, 32)

filtred_V3 <-
  mtcars |>
  filter_outlier(V3)

filtred_V1_omit <-
  mtcars |>
  filter_outlier(V1)


filtred_V12L_omit <-
  mtcars |>
  filter_outlier(V1, V2)


test_that("plots_error", {
  expect_error(autoplot(filtred_V_ALL_omit, type = 123))
  expect_error(autoplot(filtred_V_ALL_omit, type = "da"))
})


test_that("plots_plot", {
  vdiffr::expect_doppelganger("A blank plot", ggplot2::ggplot())
  vdiffr::expect_doppelganger("V3 only", autoplot(filtred_V3))
  vdiffr::expect_doppelganger("V1 ommited", autoplot(filtred_V1_omit))
  vdiffr::expect_doppelganger("V1, V2", autoplot(filtred_V12L_omit))
  vdiffr::expect_doppelganger("V3 onlycount", autoplot(filtred_V3, type = "count"))
  vdiffr::expect_doppelganger("V1 ommitedcount", autoplot(filtred_V1_omit, type = "count"))
  vdiffr::expect_doppelganger("V1, V2count", autoplot(filtred_V12L_omit, type = "count"))
})
