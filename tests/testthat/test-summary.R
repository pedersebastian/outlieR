set.seed(123)
mtcars["v1"] <- c(rnorm(29), -100, 100, NA)
set.seed(234)
mtcars["v2"] <- c(-50, 32, rnorm(30))
mtcars["v3"] <- c(rep(TRUE, 31), FALSE)

v1_filtred <-
  filter_outlier(mtcars, v1, v2, v3)
everything_filtred <-
  filter_outlier(mtcars, everything())


test_that("summary_nofail", {
  expect_snapshot(summary(v1_filtred))
  expect_snapshot(summary(everything_filtred))
})




