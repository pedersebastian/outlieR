mtcars["V11"] <- c(rep("A", 15), rep("B", 15), "B", "C")
mtcars["V12"] <- factor(rep(LETTERS[1:5], times = c(10, 5, 15, 1, 1)))
set.seed(123)
mtcars["V13"] <- factor(rep(c("A", "B"), times = c(15, 17))) |> sample()




res1 <- identify_outlier(tibble::as_tibble(mtcars),
  V11,
  control = control_outlier(
    discrete_method = "min_times",
    min_times = 3
  )
)
res2 <- identify_outlier(tibble::as_tibble(mtcars),
  V12,
  control = control_outlier(
    discrete_method = "n",
    n_vars = 2
  )
)
res3 <- identify_outlier(tibble::as_tibble(mtcars),
  V13,
  control = control_outlier(
    discrete_method = "min_times",
    min_times = 3
  )
)


test_df <- tibble::tibble(let = rep(LETTERS[1:10], times = c(
  100, 120, 130, 92, 62, 2, 4, 10, 120, 99
)))

res4 <-
  identify_outlier(test_df, let, control = control_outlier(
    discrete_method = "prop", prop = 0.03
  ))



data <- ggplot2::mpg

# manufacturer
# model
# trans.    c("prop", "n", "low_freq", "min_times")

res5 <-
  identify_outlier(data, manufacturer, control = control_outlier(
    discrete_method = "min_times", min_times = 10
  ))

res6 <-
  identify_outlier(data, model, control = control_outlier(
    discrete_method = "n", n_vars = 7
  ))

res7 <-
  identify_outlier(data, trans, control = control_outlier(
    discrete_method = "low_freq"
  ))




test_that("plots_plot", {
  vdiffr::expect_doppelganger("V11 only", autoplot(res1))
  vdiffr::expect_doppelganger("V12 only", autoplot(res2))
  vdiffr::expect_doppelganger("V13 only", autoplot(res3))
  vdiffr::expect_doppelganger("V11 onlyH", autoplot(res1, type = "hist"))
  vdiffr::expect_doppelganger("V12 onlyH", autoplot(res2, type = "hist"))
  vdiffr::expect_doppelganger("V13 onlyH", autoplot(res3, type = "hist"))


  vdiffr::expect_doppelganger("let", autoplot(res4))
  vdiffr::expect_doppelganger("letH", autoplot(res4, type = "hist"))

  vdiffr::expect_doppelganger("let5", autoplot(res5))
  vdiffr::expect_doppelganger("letH6", autoplot(res6, type = "hist"))
  vdiffr::expect_doppelganger("let7", autoplot(res7))
  vdiffr::expect_doppelganger("letH5", autoplot(res5, type = "hist"))
  vdiffr::expect_doppelganger("let6", autoplot(res6))
  vdiffr::expect_doppelganger("letH7", autoplot(res7, type = "hist"))
})
