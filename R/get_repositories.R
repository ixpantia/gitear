#' @import httr
#' @import jsonlite
#'
#' @description Returns the repositories of the Gitea application
#'
#' @title Returns the repositories
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#' @examples
#' get_repositories("https://try.gitea.io", "token 6ebcaefdaaf06aa7f59b4efc5faa4bcf1b56cfb1")
#'@export
get_repositories <- function(base_url, api_key){
    if (missing(base_url)) {
        warning("Please add a valid URL")
    } else if (missing(api_key)) {
        warning("Please add a valid API token for the URL you are trying to access")
    } else
        try({
            base_url <- sub("/$", "", base_url)
            gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/repos/search"))
            r <- GET(gitea_url, add_headers(Authorization=api_key), accept_json())

            # To convert http errors to R errors
            stop_for_status(r)

            content_repositories <- content(r, as = "text")
            content_repositories <- fromJSON(content_repositories)
            return(content_repositories)
        })
}


