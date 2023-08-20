library(outlieR)
mtcars["v12"] <- factor(rep(LETTERS[1:5],
  times = c(10, 5, 15, 1, 1)
))
mtcars["v13"] <- rep(LETTERS[1:5], times = c(13, 12, 1, 5, 1))
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



a <- filter_outlier(identify_outlier(tibble::as_tibble(mtcars),
  v12,
  control = control_outlier(
    discrete_method = "min_times",
    min_times = 3
  )
))
af <- fct_lump_min(mtcars$v12, min = 3)
af <- af[af != "Other"] |> droplevels()

b <- filter_outlier(identify_outlier(tibble::as_tibble(mtcars),
  v12,
  control = control_outlier(
    discrete_method = "prop",
    prop = 0.04
  )
))
bf <- fct_lump_prop(mtcars$v12, prop = 0.04)
bf <- bf[bf != "Other"] |> droplevels()


c <- filter_outlier(identify_outlier(tibble::as_tibble(mtcars),
  v12,
  control = control_outlier(
    discrete_method = "n",
    n_vars = 2
  )
))

cf <- fct_lump_n(mtcars$v12, n = 2)
cf <- cf[cf != "Other"] |> droplevels()

d <- filter_outlier(identify_outlier(tibble::as_tibble(mtcars),
  v12,
  control = control_outlier(
    discrete_method = "low_freq"
  )
))

df <- fct_lump_lowfreq(mtcars$v12)
df <- df[df != "Other"] |> droplevels()


e <- filter_outlier(identify_outlier(tibble::as_tibble(mtcars),
  v13,
  control = control_outlier(
    discrete_method = "prop",
    prop = 0.1
  )
))

ef <- fct_lump_prop(mtcars$v13, prop = 0.1)
ef <- ef[ef != "Other"] |>
  droplevels() |>
  as.character()
###

### NA
# G Char
g <- filter_outlier(identify_outlier(tibble::as_tibble(mtcars),
  v14,
  control = control_outlier(
    discrete_method = "prop",
    min_times = 0.1, na_action = "omit"
  )
))
gf <- fct_lump_prop(mtcars$v14, prop = 0.1)
gf <- gf[gf != "Other"] |> as.character()
gf <- gf[!is.na(gf)]

# H CHAR
h <- filter_outlier(identify_outlier(tibble::as_tibble(mtcars),
  v14,
  control = control_outlier(
    discrete_method = "prop",
    min_times = 0.1,
    na_action = "keep"
  )
))
hf <- fct_lump_prop(mtcars$v14, prop = 0.1)
hf <- hf[hf != "Other"] |> as.character()
hf_na_length <- hf[is.na(hf)] |> length()
h_na_len <- h$v14[is.na(h$v14)] |> length()

### I. FCT

i <-
  filter_outlier(identify_outlier(tibble::as_tibble(mtcars),
    v15,
    control = control_outlier(
      discrete_method = "n",
      n_vars = 2,
      na_action = "omit"
    )
  ))

iff <- fct_lump_n(mtcars$v15, n = 2)
iff <- iff[iff != "Other"] |> droplevels()
iff <- iff[!is.na(iff)]
iff_na_length <- iff[is.na(iff)] |> length()
i_na_len <- sum(is.na(i$v15))



### J. FCT
j <-
  filter_outlier(identify_outlier(tibble::as_tibble(mtcars),
    v15,
    control = control_outlier(
      discrete_method = "prop",
      min_times = 0.1,
      na_action = "keep"
    )
  ))

jf <- fct_lump_prop(mtcars$v15, prop = 0.1)
jf <- jf[jf != "Other"] |> droplevels()
jf_na_length <- jf[is.na(jf)] |> length()
j_na_len <- j$v15[is.na(j$v15)] |> length()


## K EQUAL VARIANCE -- > No outliers

k_df <- tibble::tibble(x = rep(LETTERS, 4) |> sample())

k_rows <-
  identify_outlier(k_df, x) |>
  filter_outlier() |>
  nrow()

## L EQUAL VARIANCE with NA

l_df <- tibble::tibble(x = rep(c(LETTERS, NA_character_), 4) |> sample())

l_rows <-
  identify_outlier(l_df, x) |>
  filter_outlier() |>
  nrow()



identify_outlier(l_df, x, control = control_outlier(na_action = "omit")) |>
  filter_outlier() |>
  nrow()


##M ONLY TWO
m_df <- tibble::tibble(A = rep(c("K", "P"), 20))

m_rows <- identify_outlier(m_df, A) |>
  filter_outlier() |> nrow()

##N ONLY ONE
n_df <- tibble::tibble(M = rep("L", 2007))

n_row <- identify_outlier(n_df, M) |>
  filter_outlier() |> nrow()

test_that("factor_works_single_without_NAs", {
  # A
  expect_equal(nrow(a), 30)
  expect_equal(levels(a$v12), c("A", "B", "C"))
  expect_true(is.factor(a$v12))
  expect_equal(a$v12, af)
  expect_equal(levels(a$v12), levels(af))
  expect_equal(length(levels(a$v12)), length(levels(af)))
  expect_equal(ncol(a), ncol(mtcars))

  # B
  expect_equal(nrow(b), 30)
  expect_equal(levels(b$v12), c("A", "B", "C"))
  expect_true(is.factor(b$v12))
  expect_equal(b$v12, bf)
  expect_equal(levels(b$v12), levels(bf))
  expect_equal(length(levels(b$v12)), length(levels(bf)))
  expect_equal(ncol(b), ncol(mtcars))

  # C
  expect_equal(nrow(c), 25)
  expect_equal(levels(c$v12), c("A", "C"))
  expect_true(is.factor(c$v12))
  expect_equal(c$v12, cf)
  expect_equal(levels(c$v12), levels(cf))
  expect_equal(length(levels(c$v12)), length(levels(cf)))
  expect_equal(ncol(c), ncol(mtcars))

  # D
  expect_equal(nrow(d), 25)
  expect_equal(levels(d$v12), c("A", "C"))
  expect_true(is.factor(d$v12))
  expect_equal(d$v12, df)
  expect_false(is.character(d$v12))
  expect_equal(levels(d$v12), levels(df))
  expect_equal(length(levels(d$v12)), length(levels(df)))
  expect_equal(ncol(d), ncol(mtcars))

  # E 13

  expect_equal(nrow(e), 30)
  expect_equal(unique(e$v13), c("A", "B", "D"))
  expect_false(is.factor(e$v13))
  expect_equal(e$v13, ef)
  expect_equal(unique(e$v13), unique(ef))
  expect_equal(length(unique(e$v13)), length(unique(ef)))
  expect_equal(ncol(e), ncol(mtcars))
})



test_that("factor_works_single_NA", {
  # G
  expect_equal(nrow(g), 18)
  expect_equal(unique(g$v14), c("D", "A"))
  expect_false(is.factor(g$v14))
  expect_equal(g$v14, gf)
  expect_equal(unique(g$v14), unique(gf))
  expect_equal(length(unique(g$v14)), length(unique(gf)))
  expect_equal(ncol(g), ncol(mtcars))

  # H
  expect_equal(nrow(h), 30)
  expect_equal(unique(h$v14), c(NA, "D", "A"))
  expect_false(is.factor(h$v14))
  expect_equal(h$v14, hf)
  expect_equal(unique(h$v14), unique(hf))
  expect_equal(length(unique(h$v14)), length(unique(hf)))
  expect_equal(ncol(h), ncol(mtcars))
  expect_equal(hf_na_length, h_na_len)

  # I
  expect_equal(nrow(i), 18)
  expect_equal(unique(i$v15) |> as.character(), c("I", "L"))
  expect_true(is.factor(i$v15))
  expect_equal(i$v15, iff)
  expect_equal(unique(i$v15), unique(iff))
  expect_equal(length(unique(i$v15)), length(unique(iff)))
  expect_equal(ncol(i), ncol(mtcars))
  expect_equal(iff_na_length, i_na_len)

  # J
  expect_equal(nrow(j), 30)
  expect_equal(unique(j$v15) |> as.character(), c("I", NA, "L"))
  expect_true(is.factor(j$v15))
  expect_equal(j$v15, jf)
  expect_equal(unique(j$v15), unique(jf))
  expect_equal(length(unique(j$v15)), length(unique(jf)))
  expect_equal(ncol(j), ncol(mtcars))
  expect_equal(jf_na_length, j_na_len)
})

test_that("equal_variance", {
  expect_equal(k_rows, 104)
  expect_equal(l_rows, 108)
  expect_equal(m_rows, 40)
  expect_equal(n_row, 2007)
})
