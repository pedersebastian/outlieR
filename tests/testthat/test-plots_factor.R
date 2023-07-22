library(outlieR)
mtcars["V12"] <- factor(rep(LETTERS[1:5], times = c(10, 5, 15, 1, 1)))
mtcars["V13"] <- rep(LETTERS[1:5], times = c(13, 12, 1, 5, 1))
set.seed(123)
mtcars["V14"] <- rep(c(LETTERS[1:4], NA_character_), times = c(13, 1, 1, 5, 12)) |> sample()


c("prop", "n", "low_freq", "min_times")

A <- filter_outlier(tibble::as_tibble(mtcars), V12, control = control_filter_outlier(
  discrete_method = "min_times",
  min_times = 3
))
AF <- fct_lump_min(mtcars$V12, min = 3)
AF <- AF[AF != "Other"] |> droplevels()

B <- filter_outlier(tibble::as_tibble(mtcars), V12, control = control_filter_outlier(
  discrete_method = "prop",
  prop = 0.04
))
BF <- fct_lump_prop(mtcars$V12, prop = 0.04)
BF <- BF[BF != "Other"] |> droplevels()


C <- filter_outlier(tibble::as_tibble(mtcars), V12, control = control_filter_outlier(
  discrete_method = "n",
  n_vars = 2
))

CF <- fct_lump_n(mtcars$V12, n = 2)
CF <- CF[CF != "Other"] |> droplevels()

D <- filter_outlier(tibble::as_tibble(mtcars), V12, control = control_filter_outlier(
  discrete_method = "low_freq"
))

DF <- fct_lump_lowfreq(mtcars$V12)
DF <- DF[DF != "Other"] |> droplevels()


E <- filter_outlier(tibble::as_tibble(mtcars), V13, control = control_filter_outlier(
  discrete_method = "prop",
  prop = 0.1
))

EF <- fct_lump_prop(mtcars$V13, prop = 0.1)
EF <- EF[EF != "Other"] |>
  droplevels() |>
  as.character()
###



###########

xxxx <- filter_outlier(tibble::as_tibble(mtcars), V12, V13, control = control_filter_outlier(
  discrete_method = "n",
  n_vars = 2
))
xxxx <- filter_outlier(tibble::as_tibble(mtcars), V12, V13, control = control_filter_outlier(
  discrete_method = "prop",
  min_times = 0.1
))


### NA

K <- filter_outlier(tibble::as_tibble(mtcars), V14, control = control_filter_outlier(
  discrete_method = "prop",
  min_times = 0.1, na_action = "keep"
))





test_that("factor_works_single_without_NAs", {
  # A
  expect_equal(nrow(A), 30)
  expect_equal(levels(A$V12), c("A", "B", "C"))
  expect_true(is.factor(A$V12))
  expect_equal(A$V12, AF)
  expect_equal(levels(A$V12), levels(AF))
  expect_equal(length(levels(A$V12)), length(levels(AF)))
  expect_equal(ncol(A), ncol(mtcars))

  # B
  expect_equal(nrow(B), 30)
  expect_equal(levels(B$V12), c("A", "B", "C"))
  expect_true(is.factor(B$V12))
  expect_equal(B$V12, BF)
  expect_equal(levels(B$V12), levels(BF))
  expect_equal(length(levels(B$V12)), length(levels(BF)))
  expect_equal(ncol(B), ncol(mtcars))

  # C
  expect_equal(nrow(C), 25)
  expect_equal(levels(C$V12), c("A", "C"))
  expect_true(is.factor(C$V12))
  expect_equal(C$V12, CF)
  expect_equal(levels(C$V12), levels(CF))
  expect_equal(length(levels(C$V12)), length(levels(CF)))
  expect_equal(ncol(C), ncol(mtcars))

  # D
  expect_equal(nrow(D), 25)
  expect_equal(levels(D$V12), c("A", "C"))
  expect_true(is.factor(D$V12))
  expect_equal(D$V12, DF)
  expect_false(is.character(D$V12))
  expect_equal(levels(D$V12), levels(DF))
  expect_equal(length(levels(D$V12)), length(levels(DF)))
  expect_equal(ncol(D), ncol(mtcars))

  # E 13

  expect_equal(nrow(E), 30)
  expect_equal(unique(E$V13), c("A", "B", "D"))
  expect_false(is.factor(E$V13))

  expect_equal(E$V13, EF)
  expect_equal(unique(E$V13), unique(EF))
  expect_equal(length(unique(E$V13)), length(unique(EF)))
  expect_equal(ncol(E), ncol(mtcars))
})

test_that("factor_works_multiple", {})


test_that("factor_fails", {

})
