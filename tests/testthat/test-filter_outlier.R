set.seed(123)
mtcars["V1"] <- c(rnorm(29), -100, 100, NA)
set.seed(234)
mtcars["V2"] <- c(-50, 32, rnorm(30))
mtcars["V3"] <- c(rep(TRUE, 31), FALSE)
mtcars["V4"] <- c(rep(2, 31), 100)
mtcars["V5"] <- c(rep(TRUE, 16), rep(FALSE, 16))
mtcars["V6"] <- c(rep(FALSE, 31), TRUE)
mtcars["V7"] <- c(rep(2, 31), -100)
mtcars["V8"] <- rep(FALSE, 32)
mtcars["V9"] <- c(rep(FALSE, 15), rep(NA, 16), TRUE)
mtcars["V10"] <- rep(TRUE, 32)




filtred_V1 <-
  mtcars |>
  filter_outlier(V1, control = control_filter_outlier(numeric_method = "mean_sd"))
filtred_V2 <-
  mtcars |>
  filter_outlier(V2, control = control_filter_outlier(numeric_method = "mean_sd"))

filtred_V3 <-
  mtcars |>
  filter_outlier(V3, control = control_filter_outlier(numeric_method = "mean_sd"))

filtred_V1_omit <-
  mtcars |>
  filter_outlier(V1, control = control_filter_outlier(numeric_method = "mean_sd", na_action = "omit"))

filtred_V_ALL_omit <-
  mtcars |>
  filter_outlier(V1, V2, V3, control = control_filter_outlier(numeric_method = "mean_sd", na_action = "omit"))

filtred_everything <-
  mtcars |>
  filter_outlier(everything(), control = control_filter_outlier(na_action = "keep"))

date_tbl <-
  mtcars |>
  dplyr::mutate(date_var = as.Date(19551:19582, origin = "1970-01-01"))


atr_ignore <- c("tbls", "old_df", "vecs", "na_action", "filter_res")

test_that("equals", {
  expect_equal(nrow(filtred_V1), 30)
  expect_equal(nrow(filtred_V2), 30)
  expect_equal(nrow(filtred_V3), 31)
  expect_equal(nrow(filtred_V1_omit), 29)
  expect_equal(nrow(filtred_V_ALL_omit), 27)
  expect_equal(nrow(filtred_everything), 27)

  expect_identical(subset(mtcars, c(FALSE, FALSE, rep(TRUE, 30))), filtred_V2 |> as.data.frame(), ignore_attr = atr_ignore)
  expect_identical(subset(mtcars, c(rep(TRUE, 29), FALSE, FALSE, TRUE)), filtred_V1 |> as.data.frame(), ignore_attr = atr_ignore)
  expect_identical(subset(mtcars, c(rep(TRUE, 29), FALSE, FALSE, FALSE)), filtred_V1_omit |> as.data.frame(), ignore_attr = atr_ignore)
})

test_that("warnings and errors", {
  expect_error(filter_outlier(mtcars, "hei"))
  expect_error(filter_outlier())
  expect_error(filter_outlier(mtcars, fakevar))
  expect_warning(filter_outlier(mtcars, V1, V2, V3, control = control_filter_outlier(threshold = 10000)))
  expect_error(filter_outlier(mtcars, V1, V2, V3, control = control_filter_outlier(numeric_method = "mean_sd", na_action = "djsa")))
  expect_error(filter_outlier(mtcars, V1, V2, V3, control = control_filter_outlier(numeric_method = "t_test", conf_int = 8, na_action = "omit")))
  ## Ikke implementert faktorer
  # expect_error(dplyr::mutate(mtcars, am = factor(am)) |> filter_outlier(am))
  expect_error(filter_outlier(date_tbl, date_var))
})
