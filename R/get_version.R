#' @import httr
#' @import jsonlite
#'
#' @description Returns the version of the Gitea application
#'
#' @title Returns the version
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#' @examples
#' get_version("https://try.gitea.io", "token 6ebcaefdaaf06aa7f59b4efc5faa4bcf1b56cfb1")
#'@export
get_version <- function(base_url, api_key){
    if (missing(base_url)) {
        warning("Please add a valid URL")
    } else if (missing(api_key)) {
        warning("Please add a valid API token for the URL you are trying to access")
    } else
        try({
            base_url <- sub("/$", "", base_url)
            gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/version"))
            r <- GET(gitea_url, add_headers(Authorization=api_key), accept_json())

            # To convert http errors to R errors
            stop_for_status(r)

            content_version <- content(r, "parse")
            content_version <- as.data.frame(content_version)
            return(content_version)
        })
}

