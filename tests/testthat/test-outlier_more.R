set.seed(123)
mtcars["V1"] <- c(rnorm(29), -100, 100, NA)
set.seed(234)
mtcars["V2"] <- c(-50, 32, rnorm(30))
set.seed(345)
mtcars["V3"] <- c(rep(TRUE, 31), FALSE)



filtred_V1 <-
  mtcars |>
  outlier_flere(V1, method = "mean_sd")
filtred_V2 <-
  mtcars |>
  outlier_flere(V2, method = "mean_sd")

filtred_V3 <-
  mtcars |>
  outlier_flere(V3, method = "mean_sd")

filtred_V1_omit <-
  mtcars |>
  outlier_flere(V1, method = "mean_sd", na_action = "omit")

filtred_V_ALL_omit <-
  mtcars |>
  outlier_flere(V1, V2, V3, method = "mean_sd", na_action = "omit")

filtred_everything <-
  mtcars |>
  outlier_flere(everything(), method = "mean_sd", na_action = "keep")

date_tbl <-
  mtcars |>
  dplyr::mutate(date_var = as.Date(19551:19582, origin = "1970-01-01"))


test_that("equals", {
  expect_equal(nrow(filtred_V1), 30)
  expect_equal(nrow(filtred_V2), 30)
  expect_equal(nrow(filtred_V3), 31)
  expect_equal(nrow(filtred_V1_omit), 29)
  expect_equal(nrow(filtred_V_ALL_omit), 27)
  expect_equal(nrow(filtred_everything), 27)

  expect_identical(subset(mtcars, c(FALSE, FALSE, rep(TRUE, 30))), filtred_V2|> as.data.frame(), ignore_attr = c("tbls", "old_df"))
  expect_identical(subset(mtcars, c(rep(TRUE, 29), FALSE, FALSE, TRUE)), filtred_V1|> as.data.frame(), ignore_attr = c("tbls", "old_df"))
  expect_identical(subset(mtcars, c(rep(TRUE, 29), FALSE, FALSE, FALSE)), filtred_V1_omit |> as.data.frame(), ignore_attr = c("tbls", "old_df"))
})

test_that("warnings and errors", {
  expect_error(outlier_flere(mtcars, "hei"))
  expect_error(outlier_flere())
  expect_error(outlier_flere(mtcars, fakevar))
  expect_warning(outlier_flere(mtcars, V1, V2, V3, method = "mean_sd", threshold = 100))
  expect_error(outlier_flere(mtcars, V1, V2, V3, na_action = "fake", threshold = 100, conf_int = 1000))
  expect_error(outlier_flere(mtcars, V1, V2, V3, method = "t_test", conf_int = 1000))
  ## Ikke implementert faktorer
  expect_error(dplyr::mutate(mtcars, am = factor(am)) |> outlier_flere(am))
  expect_error(outlier_flere(date_tbl, date_var))
})
