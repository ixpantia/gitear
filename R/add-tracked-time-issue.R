#' @import httr
#' @import jsonlite
#'
#' @description Add a tracked time to a issue
#' @title Tracked time to a issue
#' 
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#' @param owner The owner of the repo
#' @param repo The name of the repo
#' @param id_issue Index of the issue to add tracked time to
#' @param time The time to add the issue
#'
#'@export
add_tracked_time_issue <- function(base_url, api_key, owner, repo, id_issue, time){
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
    } else if (missing(time)) {
        warning("Please add a valid time in seconds")
    } else
        try({
            base_url <- sub("/$", "", base_url)
            gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/repos"),
                                   owner,repo,"issues",id_issue,"times")
            
            authorization <- paste("token", api_key)
            
            request_body <- as.list(data.frame(time = as.numeric(time)))
            
            r <- POST(gitea_url, add_headers(Authorization = authorization),
                      content_type_json(), encode = "json", body = request_body)
            
            content_tracked_time <- content(r, as = "text")
            content_tracked_time <- fromJSON(content_tracked_time)
            return (content_tracked_time)
        })
}