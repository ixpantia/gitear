#' @import httr
#' @import jsonlite
#'
#' @description Returns an issue's labels
#' @title Returns an issue's labels
#' 
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#' @param owner The owner of the repo
#' @param repo The reposository name for the gitea service
#' @param id_issue Index of the issue
#'
#'@export
get_label_issue <- function(base_url, api_key, owner, repo, id_issue){
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
            gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/repos")
                                   ,owner,repo,"issues",id_issue, "labels")
            
            authorization <- paste("token", api_key)
            r <- GET(gitea_url, add_headers(Authorization = authorization),
                     accept_json())
            
            content_label_issue <- content(r, as = "text")
            content_label_issue <- as.data.frame(content_label_issue)
            
            return(content_label_issue)
        })
}