#' @import httr
#' @import jsonlite
#'
#' @title Organization's teams
#' @description Get organization's teams
#'
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#' @param org Name of the organization
#'
#'@export
get_list_org_teams <- function(base_url, api_key, org){
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
                                   sub("^/", "", "/orgs"), org,"teams")

            authorization <- paste("token", api_key)
            r <- GET(gitea_url, add_headers(Authorization = authorization),
                     accept_json())

            # To convert http errors to R errors
            stop_for_status(r)

            cont_list_an_org_teams <- content(r, as = "text")
            cont_list_an_org_teams <- fromJSON(cont_list_an_org_teams)
            cont_list_an_org_teams <- as.data.frame(cont_list_an_org_teams)

            return(cont_list_an_org_teams)
        })
}
