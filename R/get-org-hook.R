#' @import httr
#' @import jsonlite
#
#' @title Returns a hook
#' @description Get a hook information of a organizations
#'
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#' @param org Name of the organization
#' @param id_hook Id of the hook to get information
#'
#' @export
#'
#' @examples
#' \dontrun{
#' get_org_hook(base_url = "https://example.gitea.service.com",
#'              api_key = "ccaf5c9a22e854856d0c5b1b96c81e851bafb288",
#'              org = "company",
#'              id_hook = 2)
#' }
get_org_hook <- function(base_url, api_key, org, id_hook){
    if (missing(base_url)) {
        stop("Please add a valid URL")
    } else if (missing(api_key)) {
        stop("Please add a valid API token")
    } else if (missing(org)) {
        stop("Please add a valid name of the organization")
    } else if (missing(id_hook)) {
        stop("Please add a id valid of hook")
    }

    base_url <- sub("/$", "", base_url)
    gitea_url <- file.path(base_url, "api/v1",
                           sub("^/", "", "/orgs"),
                           org, "hooks", id_hook)

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

    content_org_hook <- content(r, as = "text")
    content_org_hook <- fromJSON(content_org_hook)
    content_org_hook <- as.data.frame(content_org_hook)

    return(content_org_hook)

}
