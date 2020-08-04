#' @import httr
#' @import jsonlite
#'
#' @title Returns the repository issues in closed state
#' @description Returns the issues in closed state of a repository
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
#' get_issues_closed_state(base_url = "https://example.gitea.service.com",
#'                         api_key = "ccaf5c9a22e854856d0c5b1b96c81e851bafb288",
#'                         owner = "company",
#'                         repo = "test_repo")
#' }
get_issues_closed_state <- function(base_url, api_key, owner, repo){
  if (missing(base_url)) {
    stop("Please add a valid URL")
  } else if (missing(api_key)) {
      stop("Please add a valid API token")
  } else if (missing(owner)) {
      stop("Please add a valid owner")
  } else if (missing(repo)) {
      stop("Please add a valid repository")
  }
      page <- 1
      content_issues <- data.frame()
      while (TRUE) {
        base_url <- sub("/$", "", base_url)
        gitea_url <- file.path(base_url, "api/v1",
                               sub("^/", "", "/repos"),
                               owner,
                               repo,
                               paste0("issues?state=closed&page=", page))

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

        page_issues <- fromJSON(content(r, as = "text"))
        page_issues <- jsonlite::flatten(as.data.frame(page_issues))

        if (page != 1 && nrow(page_issues) == 0) {
           break
        }

        if (page == 1) {
            content_issues <- page_issues
        } else {
            content_issues <- dplyr::bind_rows(content_issues, page_issues)
        }
        page <- page + 1
    }

  content_issues <- dplyr::select_if(content_issues,
                                     .predicate = function(x) !is.list(x))
  return(content_issues)
}
