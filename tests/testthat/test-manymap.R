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



methods <- c("mean_sd", "MAD", "IQD", "t_test", "fake")
na_action <- c("keep", "omit", "fake")
conf_int =  seq(-1,0.99,0.1)
threshold <-seq(1, 4, by = 0.2)
col_names <-
  colnames(mtcars)

pol_outlier <- purrr::possibly(filter_outlier, NA)
set.seed(123)
res <-
  tidyr::expand_grid(col_names, methods,threshold,  conf_int, na_action) |>
  dplyr::slice_sample(n = 2000) |>
  tibble::rownames_to_column() |>
  tidyr::nest(data = -rowname) |>
  dplyr::mutate(test = purrr::map(data,~pol_outlier(.data = mtcars,
                                      .x$col_names,
                                      method = .x$methods,
                                      threshold = .x$threshold,
                                      conf_int = .x$conf_int,
                                      na_action = .x$na_action)))



res <-
  res |>
  dplyr::count(is.na(test)) |> purrr::pluck("n", 1)


test_that("plots_plot", {
  expect_equal(res, 884)
})
