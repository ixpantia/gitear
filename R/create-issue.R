#' @import httr
#' @import jsonlite
#'
#' @title Create a new issue
#' @description Create an new issue in a specific repository
#'
#' @param base_url URL prefix for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#' @param owner The owner of the repository
#' @param repo The name of the repository
#'
#' @param title The title of the issue
#' @param body The body text of the issue
#'
#' @return list with results of the new issue
#'
#' @export
create_issue <- function(base_url, api_key, owner, repo, title, body){
    if (missing(base_url)) {
        warning("Please add a valid URL")
    } else if (missing(api_key)) {
        warning("Please add a valid API token")
    } else if (missing(owner)) {
        warning("Please add a valid owner")
    } else if (missing(repo)) {
        warning("Please add a valid repository")
    } else if (missing(title)) {
        warning("Please add a valid title")
    } else if (missing(body)) {
        warning("Please add a valid body")
    } else
        try({
            base_url <- sub("/$", "", base_url)
            gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/repos"),
                                   owner, repo, "issues")

            authorization <- paste("token", api_key)

            request_body <- as.list(data.frame(title = title, body = body))

            r <- POST(gitea_url, add_headers(Authorization = authorization),
                      content_type_json(), encode = "json", body = request_body)

            content_create_issue <- content(r, as = "text")
            content_create_issue <- fromJSON(content_create_issue)

            return(content_create_issue)

            })
}
