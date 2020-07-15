#' @import httr
#' @import jsonlite
#'
#' @title Returns organization's teams
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
        stop("Please add a valid URL")
    } else if (missing(api_key)) {
        stop("Please add a valid API token")
    } else if (missing(org)) {
        stop("Please add a valid name of the organization")
    }
        base_url <- sub("/$", "", base_url)
        gitea_url <- file.path(base_url, "api/v1",
                               sub("^/", "", "/orgs"), org,"teams")

        authorization <- paste("token", api_key)
        r <- tryCatch(GET(gitea_url,
                          add_headers(Authorization = authorization),
                          accept_json()),
                      error = function(cond) {"Failure"})

        if (class(r) != "response") {
            stop(paste0("Error consulting the url: ", gitea_url))
        }

        # To convert http errors to R errors
        stop_for_status(r)

        cont_list_an_org_teams <- content(r, as = "text")
        cont_list_an_org_teams <- fromJSON(cont_list_an_org_teams)
        cont_list_an_org_teams <- as.data.frame(cont_list_an_org_teams)

        return(cont_list_an_org_teams)
}
