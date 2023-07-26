## .  DATA PREP
prep_data <- function(object, type, ...) {
  if (length(attr(object, "tbls")) > 1) {
    data <- prep_data_many(object, type, ...)
  } else if (length(attr(object, "tbls")) == 1) {
    data <- prep_data_one(object, type, ...)
  } else {
    cli::cli_abort("noe feil as")
  }
  data
}
###############################################
prep_data_one <- function(object, type, ...) {
  summary_tbl <- attr(object, "tbl")[[1]]
  var_name <- summary_tbl$var
  dat <- attr(object, "old_df")

  na_action <- attr(object, "na_action")

  if (summary_tbl$var_type == "lgl") {
    dat <- prep_data_many_logical(data = dat, var_name, summary_tbl)
    class <- "lgl"

    ## Hvis det ikke finnes outlier er data ok som det er.
  } else if (summary_tbl$var_type %in% c("dbl", "int")) {
    dat["outlier_var"] <- ifelse(dat[[var_name]] > summary_tbl$upper, "Outlier (>)", ifelse(dat[[var_name]] < summary_tbl$lower, "Outlier (<)", "No Outlier"))
    dat <- dat |>
      dplyr::mutate(outlier_var = factor(outlier_var, levels = c("Outlier (<)", "No Outlier", "Outlier (>)"))) |>
      dplyr::filter(!is.na(outlier_var))
    class <- "dbl"
  } else if (summary_tbl$var_type %in% c("fct", "chr")) {
    dat <- prep_data_many_discrete(dat, var_name, summary_tbl, na_action)
    class <- "fct"
  }
  class_var <- c("outlier_data", glue::glue("outlier_{class}_{type}"), "list")



  out <- structure(
    list(
      summary_tbl = summary_tbl,
      var_name = var_name,
      dat = dat
    ),
    one_variable = TRUE,
    variable_type = summary_tbl$var_type,
    class = class_var
  )
  out
}

prep_data_many <- function(object, type, ...) {
  summary_tbl <- attr(object, "tbls") |> dplyr::bind_rows()
  vars_name <- summary_tbl$var

  na_action <- attr(object, "na_action")

  lgl_names <- summary_tbl["var"][summary_tbl["var_type"] == "lgl"]
  dbl_names <- summary_tbl["var"][summary_tbl["var_type"] == "dbl"]
  int_names <- summary_tbl["var"][summary_tbl["var_type"] == "int"]
  fct_names <- summary_tbl["var"][summary_tbl["var_type"] == "fct"]
  chr_names <- summary_tbl["var"][summary_tbl["var_type"] == "chr"]

  dis_name <- c(fct_names, chr_names)
  dbl_names <- c(dbl_names, int_names)


  lgl <- length(lgl_names)
  dbl <- length(dbl_names)
  dis <- length(dis_name)
  other <- 0
  # Not implemented så
  # other <- length(vars_name) - lgl - dbl




  dbl_data <-
    prep_data_many_numeric(attr(object, "old_df"), dbl_names, summary_tbl)
  lgl_data <-
    prep_data_many_logical(attr(object, "old_df"), lgl_names, summary_tbl)

  dis_data <-
    prep_data_many_discrete(attr(object, "old_df"), dis_name, summary_tbl, na_action)
  #############################################################################

  class_var <- c("outlier_data", glue::glue("outlier_lgl{lgl>0}_dbl{dbl>0}_dis{dis>0}_other{other>1}_{type}"), "list")

  out <- structure(
    list(
      summary_tbl = summary_tbl,
      vars_name = vars_name,
      dat = list(
        dbl_data = dbl_data,
        lgl_data = lgl_data,
        dis_data = dis_data
      )
    ),
    "one_variable" = FALSE,
    "lgl" = lgl,
    "dbl" = dbl,
    "dis" = dis,
    "other" = other,
    "total_count" = length(vars_name),
    class = class_var
  )
  out
}
