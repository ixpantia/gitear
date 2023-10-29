#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom dplyr %>%
## usethis namespace: end
NULL

## quiets concerns of R CMD check re: the .'s that appear in pipelines
utils::globalVariables(c(".",
                        "username",
                        "number",
                        "created_at",
                        "updated_at",
                        "due_date",
                        "created_time",
                        "updated_time",
                        "created_at",
                        "created_time",
                        "due_date number",
                        "updated_at",
                        "updated_time",
                        "username"
                         ))
