#' @import httr
#' @import jsonlite
#'
#' @description Create an issue
#' @title Create an issue
#'
#' @param base_url URL prefix for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#' @param owner Owner of the repo
#' @param repo Is the name of the repo
#'
#' @param title Is the title of the issue
#' @param body Is the body of the issue
#'
#' @return list (invisibly) with the status result of the API
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
