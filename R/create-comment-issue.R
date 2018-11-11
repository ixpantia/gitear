#' @import httr
#' @import jsonlite
#'
#' @description Add a comment to an issue
#' @title Adding a comment to an issue
#' 
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#' @param owner The owner of the repo
#' @param repo The name of the repo for the gitea service
#' @param id_issue Index of the issue to get
#' @param body Respresent of content comments
#'
#'@export
create_comment_issue <- function(base_url, api_key, owner, repo, id_issue, body){
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
    } else
        try({
            base_url <- sub("/$", "", base_url)
            gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/repos"), 
                                   owner,repo,"issues",id_issue, "comments")
            
            authorization <- paste("token", api_key)
           
            request_body <- as.list(data.frame(body = body))
            
            r <- POST(gitea_url, add_headers(Authorization = authorization),
                      content_type_json(), encode = "json", body = request_body)
            
            add_comment_issue <- content(r, as = "text")
            add_comment_issue <- fromJSON(add_comment_issue)
            return(add_comment_issue)
        })
}