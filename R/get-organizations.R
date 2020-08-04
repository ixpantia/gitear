#' @import httr
#' @import jsonlite
#'
#' @title Returns organizations of the user
#' @description Returns list the current user's organizations
#'
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#' @export
#'
#' @examples
#' \dontrun{
#' get_organizations(base_url = "https://example.gitea.service.com",
#'                   api_key = "ccaf5c9a22e854856d0c5b1b96c81e851bafb288")
#' }
get_organizations <- function(base_url, api_key){
    if (missing(base_url)) {
        stop("Please add a valid URL")
    } else if (missing(api_key)) {
        stop("Please add a valid API token")
    }

    base_url <- sub("/$", "", base_url)
    gitea_url <- file.path(base_url, "api/v1",
                           sub("^/", "", "/user/orgs"))

    authorization <- paste("token", api_key)
    r <- tryCatch(
        GET(
            gitea_url,
            add_headers(Authorization = authorization),
            accept_json()
        ),
        error = function(cond) {
            "Failure"
        }
    )

    if (class(r) != "response") {
        stop(paste0("Error consulting the url: ", gitea_url))
    }

    # To convert http errors to R errors
    stop_for_status(r)

    content_organizations <- fromJSON(content(r, as = "text"))

    return(content_organizations)

}

#' @title Returns organizations for an administrator user
#' @description Returns the list of organizations for a user with an
#'  administrator role
#' @details This function works only in the case that the `api_key` is
#' associated with a user with administrator role
#'
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#' @export
#'
#' @examples
#' \dontrun{
#' get_admin_organizations(base_url = "https://example.gitea.service.com",
#'                         api_key = "b6026f861fd41a94c3389d54293de9d04bde6f7c")
#' }
get_admin_organizations <- function(base_url, api_key){
    if (missing(base_url)) {
        stop("Please add a valid URL")
    } else if (missing(api_key)) {
        stop("Please add a valid API token")
    }

    base_url <- sub("/$", "", base_url)
    gitea_url <- file.path(base_url, "api/v1",
                           sub("^/", "", "/admin/orgs"))

    authorization <- paste("token", api_key)
    r <- tryCatch(
        GET(
            gitea_url,
            add_headers(Authorization = authorization),
            accept_json()
        ),
        error = function(cond) {
            "Failure"
        }
    )

    if (class(r) != "response") {
        stop(paste0("Error consulting the url: ", gitea_url))
    }

    # To convert http errors to R errors
    stop_for_status(r)

    content_organizations <- fromJSON(content(r, as = "text"))

    return(content_organizations)

}
