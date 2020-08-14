#' @import httr
#' @import jsonlite
#'
#' @title Edit a comment
#' @description Edit a comment in a specific issue
#'
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#' @param owner The owner of the repository
#' @param repo The name of the repository
#' @param id_comment Id of the comment to edit
#'
#' @param body The text to replace the old comment
#'
#' @export
#'
#' @examples
#' \dontrun{
#' edit_comment(base_url = "https://example.gitea.service.com",
#'              api_key = "ccaf5c9a22e854856d0c5b1b96c81e851bafb288",
#'              owner = "company",
#'              repo = "test_repo",
#'              id_comment = 612,
#'              body = "This is the correction of my comment")
#' }
edit_comment <- function(base_url, api_key, owner, repo, id_comment, body){
    if (missing(base_url)) {
        stop("Please add a valid URL")
    } else if (missing(api_key)) {
        stop("Please add a valid API token")
    } else if (missing(owner)) {
        stop("Please add a valid owner")
    } else if (missing(repo)) {
        stop("Please add a valid repository")
    } else if (missing(id_comment)) {
        stop("Please add a id of the comment")
    } else if (missing(body)) {
        stop("Please add a valid body")
    }

    base_url <- sub("/$", "", base_url)
    gitea_url <- file.path(base_url,
                           "api/v1",
                           sub("^/", "", "/repos"),
                           owner,
                           repo,
                           "issues/comments",
                           id_comment)

    authorization <- paste("token", api_key)

    request_body <- as.list(data.frame(body = body))

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

    content_edited_comment <- fromJSON(content(r, as = "text"))

    return (content_edited_comment)

}
