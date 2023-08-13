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

filtred_v3 <-
  mtcars |>
  identify_outlier(v3)

filtred_v1_omit <-
  mtcars |>
  identify_outlier(v1)


filtred_v12_omit <-
  mtcars |>
  identify_outlier(v1, v2)


test_that("plots_error", {
  expect_error(autoplot(filtred_v12_omit,
    type = 123
  ))
  expect_error(autoplot(filtred_v12_omit,
    type = "da"
  ))
})


test_that("plots_plot", {
  vdiffr::expect_doppelganger(
    "A blank plot",
    ggplot2::ggplot()
  )
  vdiffr::expect_doppelganger(
    "V3 only",
    autoplot(filtred_v3)
  )
  vdiffr::expect_doppelganger(
    "V1 ommited",
    autoplot(filtred_v1_omit)
  )
  vdiffr::expect_doppelganger(
    "V1, V2",
    autoplot(filtred_v12_omit)
  )
  vdiffr::expect_doppelganger(
    "V3 onlycount",
    autoplot(filtred_v3,
      type = "count"
    )
  )
  vdiffr::expect_doppelganger(
    "V1 ommitedcount",
    autoplot(filtred_v1_omit,
      type = "count"
    )
  )
  vdiffr::expect_doppelganger(
    "V1, V2count",
    autoplot(filtred_v12_omit,
      type = "count"
    )
  )
})
