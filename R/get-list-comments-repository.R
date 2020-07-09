#' @import httr
#' @import jsonlite
#'
#' @title All comments in a repository
#' @description Returns a list of all comments in a repository
#'
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#' @param owner The owner of the repository
#' @param repo The name of the repository
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
                                   owner, repo, "issues/comments")

            authorization <- paste("token", api_key)
            r <- GET(gitea_url, add_headers(Authorization = authorization),
                     accept_json())

            # To convert http errors to R errors
            stop_for_status(r)

            list_com_repository <- content(r, as = "text")
            list_com_repository <- fromJSON(list_com_repository)

            return(list_com_repository)
        })
}
