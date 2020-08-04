#' @import httr
#' @import jsonlite
#'
#' @title Returns repositories of a gitea service
#' @description Returns the repositories of the Gitea application
#'
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#' @export
#'
#' @examples
#' \dontrun{
#' get_repositories(base_url = "https://example.gitea.service.com",
#'                  api_key = "ccaf5c9a22e854856d0c5b1b96c81e851bafb288")
#' }
get_repositories <- function(base_url, api_key){
    if (missing(base_url)) {
        stop("Please add a valid URL")
    } else if (missing(api_key)) {
        stop("Please add a valid API token")
    }

    base_url <- sub("/$", "", base_url)
    gitea_url <- file.path(base_url, "api/v1",
                           sub("^/", "", "/repos/search"))

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

    content_repositories <- fromJSON(content(r, as = "text"))
    content_repositories <- as.data.frame(content_repositories)

    return(content_repositories)

}
