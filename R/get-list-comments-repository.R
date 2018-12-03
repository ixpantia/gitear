#' @import httr
#' @import jsonlite
#'
#' @description Returns one list all comments in a repository
#' @title Returns list of comments in a repository
#' 
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#' @param owner The owner of the repository
#' @param repo The name of repository for the gitea service
#'
#'@export
get_list_comments_repository <- function(base_url, api_key, owner, repo){
    if (missing(base_url)) {
        warning("Please add a valid URL")
    } else if (missing(api_key)) {
        warning("Please add a valid API token")
    } else if (missing(owner)) {
        warning("Please add a valid owner")
    } else if (missing(repo)) {
        warning("Please add a valid repository")
    } else
        try({
            base_url <- sub("/$", "", base_url)
            gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/repos"),
                                   owner,repo,"issues/comments")
            
            authorization <- paste("token", api_key)
            r <- GET(gitea_url, add_headers(Authorization = authorization),
                     accept_json())
            
            # To convert http errors to R errors
            stop_for_status(r)
            
            content_list_comments_repository <- content(r, as = "text")
            content_list_comments_repository <- fromJSON(content_list_comments_repository)

            return(content_list_comments_repository)
        })
}