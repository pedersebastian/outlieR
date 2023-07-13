##

##hovedfun må kunne "lagre" begge for å kunne se forskjellene.
#
#
#
#' @importFrom ggplot2 autoplot
#' @export

ggplot2::autoplot

#' @param object data
#'
#' @param ... d
#'
#' @export
autoplot.outlier <- function(object, ...) {

  if (length(attributes(object)$tbls) >1) {
    NULL
  }
  else if (length(attributes(object)$tbls) == 1) {
    p <- plot_1_var(object, ...)
  }
  else {
    rlang::abort("ha")
  }
  p
}


plot_1_var <- function(x, ...){
  atr <- attributes(x)
  tbl_1 <- atr$tbls[[1]]
  p <- ggplot2::ggplot(atr$old_df,
                       ggplot2::aes(x = .data[[tbl_1$var]])) +
    ggplot2::geom_histogram() +
    ggplot2::geom_vline(data = tbl_1, ggplot2::aes(xintercept = .data$upper))+
    ggplot2::geom_vline(data = tbl_1, ggplot2::aes(xintercept = .data$lower))
  p
}


#autoplot.outlier(filtred)


#attributes(filtred)$tbls[[1]]$var
