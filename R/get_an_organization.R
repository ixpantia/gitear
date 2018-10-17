#' @import httr
#' @import jsonlite
#'
#' @description Get an organization
#' @title Return an organization
#' 
#' @param org Name of the organization to get
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#'@export
get_an_organization <- function(org, base_url, api_key){
    if (missing(org)) {
        warning("Please add a valid name of the organization")
    } else if (missing(api_key)) {
        warning("Please add a valid API token for the URL you are trying to access")
    } else if (missing(base_url)) {
        warning("Please add a valid URL")
    }else
        try({
            base_url <- sub("/$", "", base_url)
            gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/orgs"), org)

            authorization <- paste("token", api_key)
            r <- GET(gitea_url, add_headers(Authorization = authorization), accept_json())
            
            # To convert http errors to R errors
            stop_for_status(r)
            
            content_an_organization <- content(r, as = "text")
            content_an_organization <- fromJSON(content_an_organization)
            content_an_organization <- as.data.frame(content_an_organization)
            return(content_an_organization)
        })
}