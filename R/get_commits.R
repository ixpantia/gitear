#' @import httr
#' @import jsonlite
#'
#' @description Returns the repository commits of the Gitea application
#' @title Returns the repository commits
#' 
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#' @param owner The name of the project where the repository exists
#' @param repo The repository name of which you want to obtain the information
#' @param branch The branch name 
#'
#'@export
get_commits <- function(base_url, api_key, owner, repo, branch){
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
            gitea_url <- file.path(base_url, "api/v1",
                                   sub("^/", "", "/repos"), owner,repo,
                                   "commits", branch,
                                   "statuses")

            authorization <- paste("token", api_key)
            r <- GET(gitea_url, add_headers(Authorization = authorization),
                     accept_json())
            
            # To convert http errors to R errors
            stop_for_status(r)
            
            content_issues <- content(r, as = "text")
            content_issues <- fromJSON(content_issues)
            content_issues <- as.data.frame(content_issues)
            
            return(content_issues)
        })
}


