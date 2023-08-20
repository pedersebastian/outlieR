set.seed(123)
mtcars["v1"] <- c(rnorm(29), -100, 100, NA)
set.seed(234)
mtcars["v2"] <- c(-50, 32, rnorm(30))
mtcars["v3"] <- c(rep(TRUE, 31), FALSE)
mtcars["v4"] <- c(rep(2, 31), 100)
mtcars["v5"] <- c(rep(TRUE, 16), rep(FALSE, 16))
mtcars["v6"] <- c(rep(FALSE, 31), TRUE)
mtcars["v7"] <- c(rep(2, 31), -100)
mtcars["v8"] <- rep(FALSE, 32)
mtcars["v9"] <- c(rep(FALSE, 15), rep(NA, 16), TRUE)
mtcars["v10"] <- rep(TRUE, 32)

test_that("summary_plot", {
  vdiffr::expect_doppelganger("mtcarseverything",
                              summarise_outlier(
                                identify_outlier(mtcars,
                                                 everything())))

  vdiffr::expect_doppelganger("texas_everything",
                              summarise_outlier(
                                identify_outlier(ggplot2::txhousing,
                                                 everything())))
})
