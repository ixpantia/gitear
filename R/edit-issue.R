#' @import httr
#' @import jsonlite
#'
#' @description Edit an issue
#' @title Edit an issue
#' 
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#' 
#' @param owner The owner of the repo
#' @param repo The name of the repo
#' @param id_issue Index of the issue to edit
#' 
#' @param body The time to add the issue
#' @param state The time to add the issue
#' @param title The time to add the issue
#'
#'@export
edit_issue <- function(base_url, api_key, owner, repo, id_issue, body, state, title){
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
    } else if (missing(body)) {
        warning("Please add a valid body")
    } else if (missing(state)) {
        warning("Please add a valid state")
    } else if (missing(title)) {
        warning("Please add a valid title")
    } else
        try({
            base_url <- sub("/$", "", base_url)
            gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/repos"),
                                   owner,repo,"issues",id_issue)
            
            authorization <- paste("token", api_key)
      
            request_body <- as.list(data.frame(body = body, state = state,
                                               title = title))

            r <- PATCH(gitea_url, add_headers(Authorization = authorization),
                      content_type_json(), encode = "json", body = request_body)

            content_edit_issue <- content(r, as = "text")
            content_edit_issue <- fromJSON(content_edit_issue)
            
            return (content_edit_issue)
        })
}