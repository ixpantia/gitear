#' @import httr
#' @import jsonlite
#'
#' @title Returns pull requests of a repository
#' @description Returns open and closed pull requests in a specific repository
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
#' get_pull_requests(base_url = "https://example.gitea.service.com",
#'                   api_key = "ccaf5c9a22e854856d0c5b1b96c81e851bafb288",
#'                   owner = "company",
#'                   repo = "test_repo")
#' }
get_pull_requests <- function(base_url, api_key, owner, repo){
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
    file.path(base_url, "api/v1", sub("^/", "", "/repos"),
              owner, repo, "pulls")

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

  content_pull_req <- fromJSON(content(r, as = "text"))
  content_pull_req <- as.data.frame(content_pull_req)

  return(content_pull_req)

}
