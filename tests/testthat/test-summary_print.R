set.seed(123)
mtcars["v1"] <- c(rnorm(29), -100, 100, NA)
set.seed(234)
mtcars["v2"] <- c(-50, 32, rnorm(30))
mtcars["v3"] <- c(rep(TRUE, 31), FALSE)
mtcars["v12"] <- factor(rep(LETTERS[1:5],
  times = c(10, 5, 15, 1, 1)
))
mtcars["v13"] <- rep(LETTERS[1:5], times = c(13, 12, 1, 5, 1))
set.seed(123)
mtcars["v14"] <- rep(
  c(
    LETTERS[1:4],
    NA_character_
  ),
  times = c(13, 1, 1, 5, 12)
) |> sample()
set.seed(312)
mtcars["v15"] <- factor(rep(
  c(
    LETTERS[9:12],
    NA_character_
  ),
  times = c(13, 1, 1, 5, 12)
) |> sample())

filtred_v1 <-
  mtcars |>
  filter_outlier(v1,
    control = control_filter_outlier(numeric_method = "mean_sd")
  )
filtred_v2 <-
  mtcars |>
  filter_outlier(v2,
    control = control_filter_outlier(numeric_method = "mean_sd")
  )
filtred_v3 <-
  mtcars |>
  filter_outlier(v3,
    control = control_filter_outlier(numeric_method = "mean_sd")
  )
filtred_v1_omit <-
  mtcars |>
  filter_outlier(v1,
    control = control_filter_outlier(
      numeric_method = "mean_sd",
      na_action = "omit"
    )
  )

filtred_v_all_omit <-
  mtcars |>
  filter_outlier(v1,
    v2,
    v3,
    control = control_filter_outlier(
      numeric_method = "mean_sd",
      na_action = "omit"
    )
  )

filterd_everything <-
  filter_outlier(mtcars, everything())

filter_v12 <-
  filter_outlier(mtcars, v12)
filter_v13 <-
  filter_outlier(mtcars, v13)
filter_v14 <-
  filter_outlier(mtcars, v14)
filter_v1213 <-
  filter_outlier(mtcars, v12, v14)
filter_fct <-
  filter_outlier(mtcars |> tibble::as_tibble(), v12, v13, v14)



test_that("summary_nofail", {
  expect_snapshot(summary(filtred_v1))
  expect_snapshot(summary(filtred_v2))
  expect_snapshot(summary(filtred_v3))
  expect_snapshot(summary(filtred_v1_omit))
  expect_snapshot(summary(filtred_v_all_omit))
  expect_snapshot(summary(filterd_everything))

  expect_snapshot(summary(filter_v12))
  expect_snapshot(summary(filter_v13))
  expect_snapshot(summary(filter_v14))
  expect_snapshot(summary(filter_v1213))
  expect_snapshot(summary(filter_fct))
})
