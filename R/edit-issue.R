#' @import httr
#' @import jsonlite
#'
#' @description Edit an issue
#' @title Edit an issue
#'
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#' @param owner The owner of the repo
#' @param repo The name of the repo
#' @param id_issue Index of the issue to edit
#'
#' @param body  The new issue body text
#' @param state The issue state
#' @param title The new issue title text
#'
#' @export
#'
#' @examples
#' \dontrun{
#' edit_issue(base_url = "https://example.gitea.service.com",
#'            api_key = "ccaf5c9a22e854856d0c5b1b96c81e851bafb288",
#'            owner = "company",
#'            repo = "test_repo",
#'            id_issue = 3,
#'            title = "My new title for this issue",
#'            body = "My new comment starts on this issue",
#'            state = "open")
#' }
edit_issue <- function(base_url, api_key, owner, repo, id_issue, title, body, state){
    if (missing(base_url)) {
        stop("Please add a valid URL")
    } else if (missing(api_key)) {
        stop("Please add a valid API token")
    } else if (missing(owner)) {
        stop("Please add a valid owner")
    } else if (missing(repo)) {
        stop("Please add a valid repository")
    } else if (missing(id_issue)) {
        stop("Please add a index of the issue")
    } else if (missing(body)) {
        stop("Please add a valid body")
    } else if (missing(state)) {
        stop("Please add a valid state")
    } else if (missing(title)) {
        stop("Please add a valid title")
    }

    base_url <- sub("/$", "", base_url)
    gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/repos"),
                           owner, repo, "issues", id_issue)

    authorization <- paste("token", api_key)

    request_body <- as.list(data.frame(body = body, state = state,
                                       title = title))

    r <- tryCatch(
        PATCH(
            gitea_url,
            add_headers(Authorization = authorization),
            content_type_json(),
            encode = "json",
            body = request_body
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

    content_edit_issue <- fromJSON(content(r, as = "text"))

    return (content_edit_issue)
}
