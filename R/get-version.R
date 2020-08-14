#' @import httr
#' @import jsonlite
#'
#' @title Returns gitea service version
#' @description Returns the version of the Gitea application
#'
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#' @export
#'
#' @examples
#' \dontrun{
#' get_version(base_url = "https://example.gitea.service.com",
#'             api_key = "ccaf5c9a22e854856d0c5b1b96c81e851bafb288")
#' }
get_version <- function(base_url, api_key){
    if (missing(base_url)) {
        stop("Please add a valid URL")
    } else if (missing(api_key)) {
        stop("Please add a valid API token")
    }

    base_url <- sub("/$", "", base_url)
    gitea_url <- file.path(base_url, "api/v1",
                           sub("^/", "", "/version"))

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

    content_version <- fromJSON(content(r, "text"))
    content_version <- as.data.frame(content_version)

    return(content_version)

}
