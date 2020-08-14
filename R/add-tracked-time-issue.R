#' @import httr
#' @import jsonlite
#'
#' @title Add tracked time to an issue
#' @description Add a tracked time to an issue
#'
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#' @param owner The owner of the repository
#' @param repo The name of the repository
#' @param id_issue Index of the issue to add tracked time to
#'
#' @param time The time in seconds to add to the issue
#'
#' @export
#'
#' @examples
#' \dontrun{
#' add_tracked_time_issue(base_url = "https://example.gitea.service.com",
#'                        api_key = "ccaf5c9a22e854856d0c5b1b96c81e851bafb288",
#'                        owner = "company",
#'                        repo = "test_repo",
#'                        id_issue = 2,
#'                        time = 15)
#' }
add_tracked_time_issue <- function(base_url, api_key, owner, repo, id_issue, time){
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
    } else if (missing(time)) {
        stop("Please add a valid time in seconds")
    }

    base_url <- sub("/$", "", base_url)
    gitea_url <- file.path(base_url,
                           "api/v1",
                            sub("^/", "", "/repos"),
                            owner,
                            repo,
                            "issues",
                            id_issue,
                            "times")

    authorization <- paste("token", api_key)

    request_body <- as.list(data.frame(time = as.numeric(time)))

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


    content_tracked_time <- fromJSON(content(r, as = "text"))

    repo_info <-  as.data.frame(content_tracked_time$issue$repository)

    if(ncol(repo_info) != 0) {
        names(repo_info) <- paste0("repo_", names(repo_info))
    }

    content_tracked_time <-as.data.frame(content_tracked_time
                                         [-length(content_tracked_time)])

    if(nrow(content_tracked_time) != 0) {
        content_tracked_time$issue_id <- id_issue
    }

    content_tracked_time <- cbind(content_tracked_time, repo_info)

    return (content_tracked_time)

}
