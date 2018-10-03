#' @import httr
#' @import jsonlite
#'
#' @description List an organization's webhooks
#'
#' @title Return list an organization's webhooks
#' @param org Name of the organization
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#' @examples
#' get_org_list_hooks("Organizacion_1", "https://try.gitea.io", "token 6ebcaefdaaf06aa7f59b4efc5faa4bcf1b56cfb1")
#'@export
get_org_list_hooks <- function(org, base_url, api_key){
    if (missing(org)) {
        warning("Please add a valid name of the organization")
    } else if (missing(api_key)) {
        warning("Please add a valid API token for the URL you are trying to access")
    } else if (missing(base_url)) {
        warning("Please add a valid URL")
    }else
        try({
            base_url <- sub("/$", "", base_url)
            gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/orgs"), org,"hooks")
            r <- GET(gitea_url, add_headers(Authorization=api_key), accept_json())
            
            # To convert http errors to R errors
            stop_for_status(r)
            
            content_org_list_hooks <-content(r, as = "text")
            content_org_list_hooks <- fromJSON(content_org_list_hooks)
            content_org_list_hooks <- as.data.frame(content_org_list_hooks)
            return(content_org_list_hooks)
        })
}
