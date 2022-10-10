#' @import httr
#' @import jsonlite
#'
#' @description Edit an issue
#' @title Edit an issue
#'
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#' @param username  The user name
#' @param active Whether the user should be active or not
#' @param login_name The login name
#' @param source_id The source ID
#'
#' @export
#'
#' @examples
#' \dontrun{
#' edit_user(base_url = "https://example.gitea.service.com",
#'           api_key = "ccaf5c9a22e854856d0c5b1b96c81e851bafb288",
#'           username = "user",
#'           active = 1,
#'           login_name = "user")
#' }
edit_user <- function(base_url, api_key, username, active, login_name,
                      source_id){
  if (missing(base_url)) {
    stop("Please add a valid URL")
  } else if (missing(api_key)) {
    stop("Please add a valid API token")
  } else if (missing(username)) {
    stop("Please add a valid username")
  } else if (missing(active)) {
    stop("Please add a if you want the user active or not")
  } else if (missing(login_name)) {
    stop("Please add a valid login name")
  } else if (missing(source_id)) {
    stop("Please add a valid login name")
  }

  base_url <- sub("/$", "", base_url)

  gitea_url <- file.path(base_url, "api/v1",
                         sub("^/", "", "/admin/users"), user)

  authorization <- paste("token", api_key)

  request_body <- as.list(data.frame(active = active, login_name = login_name,
                                     source_id = source_id))

  r <- tryCatch(
    PATCH(
      gitea_url,
      add_headers(Authorization = authorization),
      content_type_json(),
      encode = "json",
      body = request_body
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

  content_edit_user <- fromJSON(content(r, as = "text"))

  return (content_edit_user)
}
