library(outlieR)
mtcars["V12"] <- factor(rep(LETTERS[1:5], times = c(10, 5, 15, 1, 1)))
mtcars["V13"] <- rep(LETTERS[1:5], times = c(13, 12, 1, 5, 1))
set.seed(123)
mtcars["V14"] <- rep(c(LETTERS[1:4], NA_character_), times = c(13, 1, 1, 5, 12)) |> sample()
set.seed(312)
mtcars["V15"] <- factor(rep(c(LETTERS[9:12], NA_character_), times = c(13, 1, 1, 5, 12)) |> sample())

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

# xxxx <- filter_outlier(tibble::as_tibble(mtcars), V12, V13, control = control_filter_outlier(
#   discrete_method = "n",
#   n_vars = 2
# ))
# xxxx <- filter_outlier(tibble::as_tibble(mtcars), V12, V13, control = control_filter_outlier(
#   discrete_method = "prop",
#   min_times = 0.1
# ))


### NA
#G Char
G <- filter_outlier(tibble::as_tibble(mtcars), V14, control = control_filter_outlier(
  discrete_method = "prop",
  min_times = 0.1, na_action = "omit"
))
GF <- fct_lump_prop(mtcars$V14, prop = 0.1)
GF <- GF[GF != "Other"] |> as.character()
GF <- GF[!is.na(GF)]

#H CHAR
H <- filter_outlier(tibble::as_tibble(mtcars), V14, control = control_filter_outlier(
  discrete_method = "prop",
  min_times = 0.1, na_action = "keep"
))
HF <- fct_lump_prop(mtcars$V14, prop = 0.1)
HF <- HF[HF != "Other"] |> as.character()
HF_na_length <- HF[is.na(HF)] |> length()
H_na_len <-  H$V14[is.na(H$V14)] |> length()

###I. FCT

I <-
  filter_outlier(tibble::as_tibble(mtcars), V15, control = control_filter_outlier(
    discrete_method = "n",
    n_vars = 2,
    na_action = "omit"
  ))

IF <- fct_lump_n(mtcars$V15, n = 2)
IF <- IF[IF != "Other"] |> droplevels()
IF <- IF[!is.na(IF)]
IF_na_length <- IF[is.na(IF)] |> length()
I_na_len <-  sum(is.na(I$V15))



###J. FCT
J <-
  filter_outlier(tibble::as_tibble(mtcars), V15, control = control_filter_outlier(
  discrete_method = "prop",
  min_times = 0.1, na_action = "keep"
))

JF <- fct_lump_prop(mtcars$V15, prop = 0.1)
JF <- JF[JF != "Other"] |> droplevels()
JF_na_length <- JF[is.na(JF)] |> length()
J_na_len <-  J$V15[is.na(J$V15)] |> length()




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



test_that("factor_works_single_NA", {
  #G
  expect_equal(nrow(G), 18)
  expect_equal(unique(G$V14), c( "D", "A"))
  expect_false(is.factor(G$V14))
  expect_equal(G$V14, GF)
  expect_equal(unique(G$V14), unique(GF))
  expect_equal(length(unique(G$V14)), length(unique(GF)))
  expect_equal(ncol(G), ncol(mtcars))

  #H
  expect_equal(nrow(H), 30)
  expect_equal(unique(H$V14), c(NA, "D", "A"))
  expect_false(is.factor(H$V14))
  expect_equal(H$V14, HF)
  expect_equal(unique(H$V14), unique(HF))
  expect_equal(length(unique(H$V14)), length(unique(HF)))
  expect_equal(ncol(H), ncol(mtcars))
  expect_equal(HF_na_length, H_na_len)

  #I
  expect_equal(nrow(I), 18)
  expect_equal(unique(I$V15) |> as.character(), c("I", "L"))
  expect_true(is.factor(I$V15))
  expect_equal(I$V15, IF)
  expect_equal(unique(I$V15), unique(IF))
  expect_equal(length(unique(I$V15)), length(unique(IF)))
  expect_equal(ncol(I), ncol(mtcars))
  expect_equal(IF_na_length, I_na_len)



  #J
  expect_equal(nrow(J), 30)
  expect_equal(unique(J$V15) |> as.character(), c("I", NA, "L"))
  expect_true(is.factor(J$V15))
  expect_equal(J$V15, JF)
  expect_equal(unique(J$V15), unique(JF))
  expect_equal(length(unique(J$V15)), length(unique(JF)))
  expect_equal(ncol(J), ncol(mtcars))
  expect_equal(JF_na_length, J_na_len)

})



test_that("factor_works_multiple", {})


test_that("factor_fails", {

})
