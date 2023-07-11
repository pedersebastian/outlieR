
mtcars["V1"] = c(rnorm(29), -100,100, NA)
mtcars["V2"] = c(-50,32, rnorm(30))
mtcars["V3"] = c(rep(TRUE, 31), FALSE)



filtred_V1 <-
  mtcars |>
  #tibble::as_tibble() |>
  outlier_flere(V1, method = "mean_sd")
filtred_V2 <-
  mtcars |>
 # tibble::as_tibble() |>
  outlier_flere(V2, method = "mean_sd")

filtred_V3 <-
  mtcars |>
  #tibble::as_tibble() |>
  outlier_flere(V3, method = "mean_sd")

#filtred

filtred_V1_omit <-
  mtcars |>
  #tibble::as_tibble() |>
  outlier_flere(V1, method = "mean_sd", na_action = "omit")

filtred_V_ALL_omit <-
  mtcars |>
  #tibble::as_tibble() |>
  outlier_flere(V1, V2, V3, method = "mean_sd", na_action = "omit")

filtred_everything <-
  mtcars |>
  #tibble::as_tibble() |>
  outlier_flere(everything(), method = "mean_sd", na_action = "keep")




test_that("multiplication works", {
  expect_equal(nrow(filtred_V1), 30)
  expect_equal(nrow(filtred_V2), 30)
  expect_equal(nrow(filtred_V3), 31)
  expect_equal(nrow(filtred_V1_omit), 29)
  expect_equal(nrow(filtred_V_ALL_omit), 27)
  expect_equal(nrow(filtred_everything), 27)


  expect_error(outlier_flere(mtcars, "hei"))
  expect_error(outlier_flere())
  expect_error(outlier_flere(mtcars,  fakevar))
  expect_error(dplyr::mutate(mtcars, am = factor(am)) |> outlier_flere(am))



})



