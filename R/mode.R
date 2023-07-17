mode_vec <- function(x) {
  UseMethod("mode_vec")
}

mode_vec.default <- function(x) {
  sort(table(x), decreasing = TRUE)[1]  |> names()
}

mode_vec.character <- function(x) {
  sort(table(x), decreasing = TRUE)[1]  |> names()
}


mode_vec.logical <- function(x) {
  mean(x, na.rm = TRUE) >= 0.5
}

mode_vec.numeric <- function(x) {
  stats::median(x, na.rm = TRUE)
}



