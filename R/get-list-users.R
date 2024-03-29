#' @import httr
#' @import jsonlite
#'
#' @title Returns users of a gitea server
#' @description User list for a gitea server
#'
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#' @export
#'
#' @examples
#' \dontrun{
#' get_list_users(base_url = "https://example.gitea.service.com",
#'                api_key = "ccaf5c9a22e854856d0c5b1b96c81e851bafb288")
#' }
get_list_users <- function(base_url, api_key) {
  if (missing(base_url)) {
    stop("Please add a valid URL")
  } else if (missing(api_key)) {
    stop("Please add a valid API token")
  }

  base_url <- sub("/$", "", base_url)
  gitea_url <- file.path(base_url, "api/v1", "users/search")

  authorization <- paste("token", api_key)
  r <- tryCatch(
    GET(
      gitea_url,
      add_headers(Authorization = authorization),
      accept_json()
    ),
    error = function(cond) {
      "Failure"
    }
  )

  if (class(r) != "response") {
    stop(paste0("Error consulting the url: ", gitea_url))
  }

  # To convert http errors to R errors
  stop_for_status(r)

  content_list_users <- jsonlite::fromJSON(content(r, as = "text"))
  content_list_users <- as.data.frame(content_list_users)

  return(content_list_users)

}
