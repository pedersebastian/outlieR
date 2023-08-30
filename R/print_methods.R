#' @export
print.outlier_identify <- function(x, ...) {
  if (length(x$tbls) == 1) {
    print_single(x, ...)
  } else {
    print_multiple(x, ...)
  }
}

print_simple <- function(x, ...) {
  vec_raw <- x$filter_res
  if (mean(vec_raw, na.rm = TRUE) < 1) {
    # finnes outliers
    first_text <-
      glue::glue("{sum(vec_raw == FALSE, na.rm = TRUE)} Outliers were removed of {length(vec_raw)} rows.")
  } else {
    first_text <-
      "No Outliers were removed"
  }
  cli::cat_rule(first_text)
  cat("\n")
}

print_single <- function(x, ...) {
  if (x$na_action == "keep") {
    print_simple(x, ...)
  } else {
    na_count <-
      x$tbls[[1]]$na_count

    n_outliers <-
      x$tbls[[1]]$n_outliers
    n <-
      x$tbls[[1]]$n
    var_type <- x$tbls[[1]]$var_type

    if (var_type %in% c("chr", "fct")) {
      non_outlier_vars <- x$tbls[[1]]$non_outlier_vars[[1]]
    } else {
      non_outlier_vars <- NULL
    }

    if (x$tbls[[1]]$na_exist) {
      # Det finnes NA som er outlier
      if (n_outliers == 1) {
        text <- glue::glue("{n_outliers} Outlier (NA) were removed out of {n} rows. ")
      } else {
        # Finnes begge deler.
        if (var_type %in% c("chr", "fct")) {
          n_outliers <- n_outliers - na_count
          if (n_outliers>0) {

          }
          else {
            text <- glue::glue("None Outliers and {na_count} NA's were removed out of {n} rows. ")

          }
        }
        else {
          text <- glue::glue("{n_outliers} Outliers and {na_count} NA's were removed out of {n} rows. ")
        }


      }
    } else if (any(is.na(non_outlier_vars))) {
      # Det finnes NA som IKKE er outlier, men som skal filteres
      text <- glue::glue("{n_outliers} Outliers and {na_count} NA's were removed out of {n} rows. ")
    } else if (n_outliers > 0) {
      # Finnes bare outliers
      text <- glue::glue("{n_outliers} Outliers were removed out of {n} rows. ")
    } else {
      text <-
        "No Outliers were removed"
    }
    cli::cat_rule(text)
    cat("\n")
  }
}

print_multiple <- function(x, ...) {
  print_simple(x, ...)
}
