#' @import httr
#' @import jsonlite
#'
#' @title Returns releases of a repository
#' @description Returns releasess in a specific repository
#'
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#' @param owner The owner of the repository
#' @param repo The name of the repository
#'
#' @export
#'
#' @examples
#' \dontrun{
#' get_releases(base_url = "https://example.gitea.service.com",
#'              api_key = "ccaf5c9a22e854856d0c5b1b96c81e851bafb288",
#'              owner = "company",
#'              repo = "test_repo")
#' }
get_releases <- function(base_url, api_key, owner, repo){
  if (missing(base_url)) {
    stop("Please add a valid URL")
  } else if (missing(api_key)) {
    stop("Please add a valid API token")
  } else if (missing(owner)) {
    stop("Please add a valid owner")
  } else if (missing(repo)) {
    stop("Please add a valid repository")
  }

  base_url <- sub("/$", "", base_url)
  gitea_url <-
    file.path(base_url,
              "api/v1",
              sub("^/", "", "/repos"),
              owner,
              repo,
              "releases")

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

  content_releases <- fromJSON(content(r, as = "text"))
  content_releases <- as.data.frame(content_releases)

  return(content_releases)

}
