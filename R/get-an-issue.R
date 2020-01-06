#' @import httr
#' @import jsonlite
#'
#' @description Returns open issues in an specific repository
#' @title Returns open issues from an specific repository
#'
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#' @param owner The owner of the repo (The name of the project where the repo belongs)
#' @param repo The repository name for the gitea service
#'
#'@export
get_issues <- function(base_url, api_key, owner, repo, full_info = FALSE) {
    if (missing(base_url)) {
        warning("Please add a valid URL")
    } else if (missing(api_key)) {
        warning("Please add a valid API token")
    } else if (missing(owner)) {
        warning("Please add a valid owner")
    } else if (missing(repo)) {
        warning("Please add a valid repository")
    } else if (missing(id_issue)) {
        warning("Please add a index of the issue")
    } else
        try({
            base_url <- sub("/$", "", base_url)
            gitea_url <- file.path(base_url, "api/v1",
                                   sub("^/", "", "/repos"),
                                   owner, repo, "issues")

            authorization <- paste("token", api_key)
            r <- GET(gitea_url, add_headers(Authorization = authorization),
                     accept_json())

            content_an_issue <- content(r, as = "text")
            content_an_issue <- fromJSON(content_an_issue)

            # Data frame wrangling
            if (full_info == TRUE) {
                content <- content_an_issue %>%
                    select
            }

            return(content_an_issue)
        })
}
