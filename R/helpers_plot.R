Freedman_Diaconis_binwidth <- function(x) {
  # binwidth
  # https://stats.stackexchange.com/questions/798/calculating-optimal-number-of-bins-in-a-histogram
  if (!is.numeric(x) | length(x) < 1) {
    cli::cli_abort(paste0(deparse1(substitute(x)), " must be a numeric vector > 0 "))
  }
  return(2 * stats::IQR(x, na.rm = TRUE) / (length(x)^(1 / 3)))
}



get_errormes <- function(class) {
  x <- grepl("TRUE", strsplit(class, "_")[[1]][2:3]) |> as.logical()
  if (all(x)) {
    mes <- "Outlierplot for both logical and double variables is not yet supported "
  } else {
    if (isTRUE(x[[1]])) {
      mes <- "Outlierplot for multiple logical variables is not yet supported. "
    } else {
      mes <- "Outlierplot for multiple double variables is not yet supported "
    }
  }
  paste0(mes, "for plottype '", strsplit(class, "_")[[1]][[5]], "'")
}

fix_levels_outlier_var <- function(levels) {
  pal <- col_mid

  ## LOW
  if ("Outlier (<)" %in% levels & "Outlier (FALSE)" %in% levels) {
    pal <- c(col_low, col_mid)
    low <- "Outlier (< or FALSE)"
  } else if ("Outlier (<)" %in% levels) {
    pal <- c(col_low, col_mid)
    low <- "Outlier (<)"
  } else if ("Outlier (FALSE)" %in% levels) {
    pal <- c(col_low, col_mid)
    low <- "Outlier (FALSE)"
  } else {
    low <- NA
  }


  ## HIGH
  if ("Outlier (>)" %in% levels & "Outlier (TRUE)" %in% levels) {
    pal <- append(pal, col_high)
    high <- "Outlier (> or TRUE)"
  } else if ("Outlier (>)" %in% levels) {
    pal <- append(pal, col_high)
    high <- "Outlier (>)"
  } else if ("Outlier (TRUE)" %in% levels) {
    pal <- append(pal, col_high)
    high <- "Outlier (TRUE)"
  } else {
    high <- NA
  }
  return(list("levels" = c(low, "No Outliers", high), pal = pal))
}


complete_helper <- function(data) {
  if (nrow(data) == 2) {
    return(data)
  }

  if (unique(data$outlier_var) == "No Outlier (TRUE)") {
    # data <- tibble::add_row(data, var = data$var[[1]], outlier_var = "Outlier (FALSE)", n = 0)

    data[2, ] <- data.frame(var = data$var[[1]], outlier_var = "Outlier (FALSE)", n = 0)
  } else if (unique(data$outlier_var) == "No Outlier (FALSE)") {
    data[2, ] <- data.frame(var = data$var[[1]], outlier_var = "Outlier (TRUE)", n = 0)
    # data <- tibble::add_row(data, var = data$var[[1]], outlier_var = "Outlier (TRUE)", n = 0)
  } else {
    rlang::abort("Noe feil complete factors",
      .internal = TRUE
    )
  }
  data
}
