#' @import httr
#' @import jsonlite
#'
#' @title Add a comment to an issue
#' @description Add a comment to an issue in a gitea server
#'
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#' @param owner The owner of the repository
#' @param repo The name of the repository
#' @param id_issue Index of the issue to create a comment
#'
#' @param body The text that is added as a comment to the issue
#'
#' @export
#'
#' @examples
#' \dontrun{
#' create_comment_issue(base_url = "https://example.gitea.service.com",
#'                      api_key = "ccaf5c9a22e854856d0c5b1b96c81e851bafb288",
#'                      owner = "company",
#'                      repo = "test_repo",
#'                      id_issue = 2,
#'                      body = "my first comment on this issue")
#' }
create_comment_issue <- function(base_url, api_key, owner, repo, id_issue, body){
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
    }

    base_url <- sub("/$", "", base_url)
    gitea_url <- file.path(base_url,
                           "api/v1",
                           sub("^/", "", "/repos"),
                           owner,
                           repo,
                           "issues",
                           id_issue,
                           "comments")

    authorization <- paste("token", api_key)

    request_body <- as.list(data.frame(body = body))

    r <- tryCatch(
        POST(
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

    add_comment_issue <- jsonlite::fromJSON(content(r, as = "text"))
    add_comment_issue <- as.data.frame(add_comment_issue)

    return(add_comment_issue)

}
