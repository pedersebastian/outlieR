mtcars["V1"] <- c(rnorm(30), -100, 100)
mtcars["V2"] <- c(-50, 32, rnorm(30))
filtred <-
  mtcars |> filter_outlier(V1, V2)

res <-
  paste(nrow(mtcars), "rows before filtered and", nrow(filtred), "rows after")


test_that("examples_filter_outlier", {
expect_equal(res, "32 rows before filtered and 28 rows after" )

})
