#' @import httr
#' @import jsonlite
#'
#' @description User list for a gitea server
#' @title Return a user list for a gitea server
#'
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#'@export
get_list_users <- function(base_url, api_key) {
  if (missing(base_url)) {
    warning("Please add a valid URL")
  } else if (missing(api_key)) {
    warning("Please add a valid API token")
  } else
    try({
      base_url <- sub("/$", "", base_url)
      gitea_url <- file.path(base_url, "api/v1", "users/search")

      authorization <- paste("token", api_key)
      r <- GET(gitea_url, add_headers(Authorization = authorization),
               accept_json())

      # To convert http errors to R errors
      stop_for_status(r)

      content_list_users <- content(r, as = "text")
      content_list_users <- fromJSON(content_list_users)
      content_list_users <- as.data.frame(content_list_users)

      return(content_list_users)
    })
}
