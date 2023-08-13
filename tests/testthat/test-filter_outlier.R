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




filtred_v1 <-
  mtcars |>
  filter_outlier(v1,
    control = control_outlier(numeric_method = "mean_sd")
  )
filtred_v2 <-
  mtcars |>
  filter_outlier(v2,
    control = control_outlier(numeric_method = "mean_sd")
  )

filtred_v3 <-
  mtcars |>
  filter_outlier(v3,
    control = control_outlier(numeric_method = "mean_sd")
  )

filtred_v1_omit <-
  mtcars |>
  filter_outlier(v1,
    control = control_outlier(
      numeric_method = "mean_sd",
      na_action = "omit"
    )
  )

filtred_v_all_omit <-
  mtcars |>
  filter_outlier(v1,
    v2,
    v3,
    control = control_outlier(
      numeric_method = "mean_sd",
      na_action = "omit"
    )
  )

filtred_everything <-
  mtcars |>
  filter_outlier(everything(),
    control = control_outlier(na_action = "keep")
  )

date_tbl <-
  mtcars |>
  dplyr::mutate(date_var = as.Date(19551:19582, origin = "1970-01-01"))


atr_ignore <- c("tbls", "old_df", "vecs", "na_action", "filter_res", "control")

test_that("equals", {
  expect_equal(nrow(filtred_v1), 30)
  expect_equal(nrow(filtred_v2), 30)
  expect_equal(nrow(filtred_v3), 31)
  expect_equal(nrow(filtred_v1_omit), 29)
  expect_equal(nrow(filtred_v_all_omit), 27)
  expect_equal(nrow(filtred_everything), 27)

  expect_identical(subset(mtcars, c(FALSE, FALSE, rep(TRUE, 30))),
    filtred_v2 |> as.data.frame(),
    ignore_attr = atr_ignore
  )
  expect_identical(subset(mtcars, c(rep(TRUE, 29), FALSE, FALSE, TRUE)),
    filtred_v1 |>
      as.data.frame(),
    ignore_attr = atr_ignore
  )
  expect_identical(subset(mtcars, c(rep(TRUE, 29), FALSE, FALSE, FALSE)),
    filtred_v1_omit |>
      as.data.frame(),
    ignore_attr = atr_ignore
  )
})

test_that("warnings and errors", {
  expect_error(filter_outlier(mtcars, "hei"))
  expect_error(filter_outlier())
  expect_error(filter_outlier(mtcars, fakevar))
  expect_warning(filter_outlier(mtcars,
    v1,
    v2,
    v3,
    control = control_outlier(
      threshold = 10000
    )
  ))

  expect_error(filter_outlier(
    mtcars,
    v1,
    v2,
    v3,
    control = control_outlier(
      numeric_method = "mean_sd",
      na_action = "djsa"
    )
  ))
  expect_error(filter_outlier(mtcars,
    v1,
    v2,
    v3,
    control = control_outlier(
      numeric_method = "t_test",
      conf_int = 8,
      na_action = "omit"
    )
  ))
  expect_error(filter_outlier(date_tbl, date_var))
})
