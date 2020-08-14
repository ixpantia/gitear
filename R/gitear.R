#' \code{gitear} package
#'
#' 'Gitea' is a community managed, lightweight code hosting solution 
#'  were projects and their respective git repositories can be managed 
# ' <https://gitea.io>. This package gives an interface to the 'Gitea' API to 
#'  access and manage repositories, issues and organizations directly in R. 
#'
#' @docType package
#' @name gitear
#' @importFrom dplyr %>%
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
