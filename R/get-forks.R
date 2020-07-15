#' @import httr
#' @import jsonlite
#'
#' @title Returns the forks of a repository
#' @description Returns forks in a specific repository
#'
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#' @param owner The owner of the repository
#' @param repo The name of the repository
#'
#'@export
get_forks <- function(base_url, api_key, owner, repo) {
  if (missing(base_url)) {
    warning("Please add a valid URL")
  } else if (missing(api_key)) {
    warning("Please add a valid API token")
  } else if (missing(owner)) {
    warning("Please add a valid owner")
  } else if (missing(repo)) {
    warning("Please add a valid repository")
  }
      base_url <- sub("/$", "", base_url)
      gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/repos"),
                             owner, repo, "forks")

      authorization <- paste("token", api_key)
      r <- tryCatch(GET(gitea_url,
                        add_headers(Authorization = authorization),
                        accept_json()),
                    error = function(cond) {"Failure"})

      if (class(r) != "response") {
        stop(paste0("Error consulting the url: ", gitea_url))
      }

      # To convert http errors to R errors
      stop_for_status(r)

      content_forks <- content(r, as = "text")
      content_forks <- jsonlite::fromJSON(content_forks)
      content_forks <- as.data.frame(content_forks)

      return(content_forks)

}
