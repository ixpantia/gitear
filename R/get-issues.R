#' @import httr
#' @import jsonlite
#' @import magrittr
#' @import graphics
#'
#' @title Returns open issues from an specific repository
#' @description Returns open issues in an specific repository
#'
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#'
#' @param owner The owner of the repository
#' @param repo The name of the repository
#' @param full_info TRUE or FALSE value. If FALSE this will select specific
#' columns from the issues data
#'
#' @export
#'
#' @examples
#' \dontrun{
#' get_issues(base_url = "https://example.gitea.service.com",
#'            api_key = "ccaf5c9a22e854856d0c5b1b96c81e851bafb288",
#'            owner = "company",
#'            repo = "test_repo",
#'            full_info = FALSE)
#' }
get_issues <- function(base_url, api_key, owner, repo, full_info = FALSE) {
    if (missing(base_url)) {
        stop("Please add a valid URL")
    } else if (missing(api_key)) {
        stop("Please add a valid API token")
    } else if (missing(owner)) {
        stop("Please add a valid owner")
    } else if (missing(repo)) {
        stop("Please add a valid repository")
    }
        base_url <- sub("/$", "", base_url)
        gitea_url <- file.path(base_url, "api/v1",
                               sub("^/", "", "/repos"),
                               owner, repo, "issues")

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

        content_issues <- fromJSON(content(r, as = "text"))

        # Data frame wrangling
        if (full_info == FALSE) {

            if (is.data.frame(content_issues$user)) {
                users <- tibble::as_tibble(content_issues$user) %>%
                    dplyr::select(username) %>%
                    dplyr::rename(author = username)
            } else {
                users <- data.frame()
            }


            if (is.list(content_issues$assignees)) {
                assignees <- tibble::as_tibble(content_issues$assignee) %>%
                    dplyr::select(username) %>%
                    dplyr::rename(assignee = username)
            } else {
                assignees <- data.frame()
            }

            # Join by position
            issues_content <- content_issues %>%
                dplyr::select(number, title, body, created_at, updated_at,
                              due_date) %>%
                dplyr::bind_cols(users, assignees) %>%
                tidyr::separate(col = created_at,
                                into = c("created_date", "created_time"),
                                sep = "T") %>%
                tidyr::separate(col = updated_at,
                                into = c("updated_date", "updated_time"),
                                sep = "T") %>%
                dplyr::mutate(created_time = stringr::str_remove(created_time,
                                                          pattern = "Z"),
                       updated_time = stringr::str_remove(updated_time,
                                                         pattern = "Z"))

            # Return object filtered out
            return(issues_content)

        } else {
            return(content_issues)
            }

}
