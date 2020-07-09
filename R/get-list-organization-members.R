#' @import httr
#' @import jsonlite
#'
#' @title Returns organization's members
#' @description List an organization's members
#'
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#' @param org Name of the organization
#'
#'@export
get_list_org_members <- function(base_url, api_key, org){
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
                                   sub("^/", "", "/orgs"), org, "members")

            authorization <- paste("token", api_key)
            r <- GET(gitea_url, add_headers(Authorization = authorization),
                     accept_json())

            # To convert http errors to R errors
            stop_for_status(r)

            content_list_org_members <- content(r, as = "text")
            content_list_org_members <- fromJSON(content_list_org_members)
            content_list_org_members <- as.data.frame(content_list_org_members)

            return(content_list_org_members)
        })
}
