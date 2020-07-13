#' @import httr
#' @import jsonlite
#'
#' @title Returns the branches of a repository
#' @description Returns branches in a specific repository
#'
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#' @param owner The owner of the repository
#' @param repo The name of the repository
#'
#'@export
get_branches <- function(base_url, api_key, owner, repo){
  if (missing(base_url)) {
    warning("Please add a valid URL")
  } else if (missing(api_key)) {
    warning("Please add a valid API token")
  } else if (missing(owner)) {
    warning("Please add a valid owner")
  } else if (missing(repo)) {
    warning("Please add a valid repository")
  } else
    try({
      base_url <- sub("/$", "", base_url)
      gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/repos"),
                             owner, repo, "branches")

      authorization <- paste("token", api_key)
      r <- GET(gitea_url, add_headers(Authorization = authorization),
               accept_json())

      content_branches <- content(r, as = "text")
      content_branches <- jsonlite::fromJSON(content_branches)
      content_branches <- as.data.frame(content_branches)

      return(content_branches)
    })
}
