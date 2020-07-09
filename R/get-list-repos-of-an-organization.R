#' @import httr
#' @import jsonlite
#'
#' @title Organization's repositories
#' @description Get a list of an organization's repositories
#'
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#' @param org Name of the organization
#'
#'@export
get_list_repos_org <- function(base_url, api_key, org){
    if (missing(base_url)) {
        warning("Please add a valid URL")
    } else if (missing(api_key)) {
        warning("Please add a valid API token")
    } else if (missing(org)) {
        warning("Please add a valid name of the organization")
    }else
        try({
            base_url <- sub("/$", "", base_url)
            gitea_url <- file.path(base_url, "api/v1",
                                   sub("^/", "", "/orgs"), org, "repos")

            authorization <- paste("token", api_key)
            r <- GET(gitea_url, add_headers(Authorization = authorization),
                     accept_json())

            # To convert http errors to R errors
            stop_for_status(r)

            content_list_repos_org <- content(r, as = "text")
            content_list_repos_org <- fromJSON(content_list_repos_org)
            content_list_repos_org <- as.data.frame(content_list_repos_org)

            return(content_list_repos_org)
        })
}
