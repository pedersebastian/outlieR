test_that("control_fail", {
  expect_warning(control_filter_outlier(
    discrete_method = "prop",
    prop = 0.6
  ))

  expect_error(
    control_filter_outlier(
      discrete_method = "prop",
      prop = -1
    )
  )


  expect_error(
    control_filter_outlier(
      discrete_method = "n",
      n_vars = -1
    )
  )
  expect_error(
    control_filter_outlier(
      discrete_method = "n",
      n_vars = NULL
    )
  )

  expect_error(
    control_filter_outlier(
      discrete_method = "min_times",
      min_times = NULL
    )
  )
  expect_error(
    control_filter_outlier(
      discrete_method = "min_times",
      min_times = -2
    )
  )
  expect_error(
    control_filter_outlier(
      discrete_method = "prop",
      prop = 10
    )
  )
  expect_error(
    control_filter_outlier(
      discrete_method = "prdsaop"
    )
  )

  expect_error(
    control_filter_outlier(
      discrete_method = c(1, 2, 3)
    )
  )
})
