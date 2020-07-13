#' @import httr
#' @import jsonlite
#'
#' @title Edit a comment
#' @description Edit a comment in a specific issue
#'
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#' @param owner The owner of the repository
#' @param repo The name of the repository
#' @param id_comment Id of the comment to edit
#'
#' @param body The text to replace the old comment
#'
#'@export
edit_comment <- function(base_url, api_key, owner, repo, id_comment, body){
    if (missing(base_url)) {
        warning("Please add a valid URL")
    } else if (missing(api_key)) {
        warning("Please add a valid API token")
    } else if (missing(owner)) {
        warning("Please add a valid owner")
    } else if (missing(repo)) {
        warning("Please add a valid repository")
    } else if (missing(id_comment)) {
        warning("Please add a id of the comment")
    } else if (missing(body)) {
        warning("Please add a valid body")
    } else
        try({
            base_url <- sub("/$", "", base_url)
            gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/repos"),
                                   owner, repo,"issues/comments",id_comment)

            authorization <- paste("token", api_key)

            request_body <- as.list(data.frame(body = body))

            r <- PATCH(gitea_url, add_headers(Authorization = authorization),
                      content_type_json(), encode = "json", body = request_body)

            content_edited_comment <- content(r, as = "text")
            content_edited_comment <- fromJSON(content_edited_comment)

            return (content_edited_comment)
        })
}
