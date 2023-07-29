library(outlieR)
atr_ignore <- c("tbls",
                "old_df",
                "vecs",
                "na_action",
                "filter_res",
                "class",
                "control")

mtcars["V12"] <- factor(rep(LETTERS[1:5],
                            times = c(10, 5, 15, 1, 1)))
mtcars["V13"] <- rep(LETTERS[1:5],
                     times = c(13, 12, 1, 5, 1))
set.seed(123)
mtcars["V14"] <- rep(c(LETTERS[1:4],
                       NA_character_),
                     times = c(13, 1, 1, 5, 12)) |> sample()
set.seed(312)
mtcars["V15"] <- factor(rep(c(LETTERS[9:12],
                              NA_character_),
                            times = c(13, 1, 1, 5, 12)) |> sample())



###########

A <- filter_outlier(tibble::as_tibble(mtcars),
                    V12,
                    V13,
                    control = control_filter_outlier(
  discrete_method = "n",
  n_vars = 2
))
A_raw_meth <-
  mtcars |>
  dplyr::as_tibble() |>
  dplyr::mutate(dplyr::across(V12:V13, ~ fct_lump_n(.x, n = 2)),
    V13 = as.character(V13)
  ) |>
  dplyr::filter(V12 != "Other", V13 != "Other") |>
  dplyr::mutate(V12 = droplevels(V12))


B <- filter_outlier(tibble::as_tibble(mtcars),
                    V12,
                    V13,
                    V14,
                    V15,
                    control = control_filter_outlier(
  discrete_method = "n",
  n_vars = 3,
  na_action = "omit"
))


B_raw_meth <-
  tibble::as_tibble(mtcars) |>
  dplyr::mutate(dplyr::across(V12:V14, ~ fct_lump_n(.x, n = 3)),
    V13 = as.character(V13),
    V14 = as.character(V14)
  ) |>
  dplyr::filter(V12 != "Other",
                V13 != "Other",
                V14 != "Other",
                V15 != "Other") |>
  dplyr::mutate(
    V12 = droplevels(V12),
    V15 = droplevels(V15)
  )

C <- filter_outlier(tibble::as_tibble(mtcars),
                    V12,
                    V13,
                    V14,
                    V15, control = control_filter_outlier(
  discrete_method = "n",
  n_vars = 3,
  na_action = "keep"
))



test_that("factor_works_multiple", {
  expect_identical(A, A_raw_meth, ignore_attr = atr_ignore)
  expect_identical(B, B_raw_meth, ignore_attr = atr_ignore)
  expect_identical(nrow(C), as.integer(29))
})
