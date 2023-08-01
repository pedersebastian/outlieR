library(outlieR)
atr_ignore <- c(
  "tbls",
  "old_df",
  "vecs",
  "na_action",
  "filter_res",
  "class",
  "control"
)

mtcars["v12"] <- factor(rep(
  LETTERS[1:5],
  times = c(10, 5, 15, 1, 1)
  ))

mtcars["v13"] <- rep(LETTERS[1:5],
  times = c(13, 12, 1, 5, 1)
)
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



###########

a <- filter_outlier(tibble::as_tibble(mtcars),
  v12,
  v13,
  control = control_filter_outlier(
    discrete_method = "n",
    n_vars = 2
  )
)
a_raw_meth <-
  mtcars |>
  dplyr::as_tibble() |>
  dplyr::mutate(dplyr::across(v12:v13, ~ forcats::fct_lump_n(.x, n = 2)),
    v13 = as.character(v13)
  ) |>
  dplyr::filter(v12 != "Other", v13 != "Other") |>
  dplyr::mutate(v12 = droplevels(v12))


b <- filter_outlier(tibble::as_tibble(mtcars),
  v12,
  v13,
  v14,
  v15,
  control = control_filter_outlier(
    discrete_method = "n",
    n_vars = 3,
    na_action = "omit"
  )
)


b_raw_meth <-
  tibble::as_tibble(mtcars) |>
  dplyr::mutate(dplyr::across(v12:v14, ~ forcats::fct_lump_n(.x, n = 3)),
    v13 = as.character(v13),
    v14 = as.character(v14)
  ) |>
  dplyr::filter(
    v12 != "Other",
    v13 != "Other",
    v14 != "Other",
    v15 != "Other"
  ) |>
  dplyr::mutate(
    v12 = droplevels(v12),
    v15 = droplevels(v15)
  )

c <- filter_outlier(tibble::as_tibble(mtcars),
  v12,
  v13,
  v14,
  v15,
  control = control_filter_outlier(
    discrete_method = "n",
    n_vars = 3,
    na_action = "keep"
  )
)



test_that("factor_works_multiple", {
  expect_identical(a, a_raw_meth, ignore_attr = atr_ignore)
  expect_identical(b, b_raw_meth, ignore_attr = atr_ignore)
  expect_identical(nrow(c), as.integer(29))
})
