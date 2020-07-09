#' @import httr
#' @import jsonlite
#' @import magrittr
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
#'@export
get_issues <- function(base_url, api_key, owner, repo, full_info = FALSE) {
    if (missing(base_url)) {
        warning("Please add a valid URL")
    } else if (missing(api_key)) {
        warning("Please add a valid API token")
    } else if (missing(owner)) {
        warning("Please add a valid owner")
    } else if (missing(repo)) {
        warning("Please add a valid repository")
    } else
        try({
            base_url <- sub("/$", "", base_url)
            gitea_url <- file.path(base_url, "api/v1",
                                   sub("^/", "", "/repos"),
                                   owner, repo, "issues")

            authorization <- paste("token", api_key)
            r <- GET(gitea_url, add_headers(Authorization = authorization),
                     accept_json())

            if (r$status_code == 403) {
                stop("Invalid API Token. Please check your API token")
            } else {
                content_an_issue <- content(r, as = "text")
                content_an_issue <- fromJSON(content_an_issue)
            }

            # Data frame wrangling
            if (full_info == FALSE) {
                # Get users who created the ticket
                users <- content_an_issue$user
                users <- tibble::as_tibble(users) %>%
                    dplyr::select(username) %>%
                    dplyr::rename(author = username)

                # Get users who have been assigned to the ticket
                assignees <- content_an_issue$assignee
                assignees <- tibble::as_tibble(assignees) %>%
                    dplyr::select(username) %>%
                    dplyr::rename(assignee = username)

                # Join by position
                issues_content <- content_an_issue %>%
                    dplyr::select(number, title, created_at, updated_at, due_date) %>%
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
                return(content_an_issue)
            }

        })
}
