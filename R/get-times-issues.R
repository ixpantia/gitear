#' @import httr
#' @import jsonlite
#'
#' @title Returns issue's tracked times
#' @description Returns a data frame of an issue's tracked times
#'
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#' @param owner The owner of the repository
#' @param repo The name of the repository
#' @param id_issue Index of the issue
#'
#' @export
#'
#' @examples
#' \dontrun{
#' get_times_issue(base_url = "https://example.gitea.service.com",
#'                 api_key = "ccaf5c9a22e854856d0c5b1b96c81e851bafb288",
#'                 owner = "company",
#'                 repo = "test_repo",
#'                 id_issue = 3)
#' }
get_times_issue <- function(base_url, api_key, owner, repo, id_issue){
    if (missing(base_url)) {
        stop("Please add a valid URL")
    } else if (missing(api_key)) {
        stop("Please add a valid API token")
    } else if (missing(owner)) {
        stop("Please add a valid owner")
    } else if (missing(repo)) {
        stop("Please add a valid repository")
    } else if (missing(id_issue)) {
        stop("Please add a index of the issue")
    }

    base_url <- sub("/$", "", base_url)
    gitea_url <-
        file.path(base_url,
                  "api/v1",
                  sub("^/", "", "/repos"),
                  owner,
                  repo,
                  "issues",
                  id_issue,
                  "times")

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

    content_issue_times <- fromJSON(content(r, as = "text"))
    content_issue_times <- as.data.frame(content_issue_times)

    return (content_issue_times)

}
