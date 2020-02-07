#' @import httr
#' @import jsonlite
#'
#' @description Returns open issues in an specific repository
#' @title Returns open issues from an specific repository
#'
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#' @param owner The owner of the repo (The name of the project where the repo belongs)
#' @param repo The repository name for the gitea service
#' @param full_info If FALSE this will select specific columns from the issues data
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

            content_an_issue <- content(r, as = "text")
            content_an_issue <- fromJSON(content_an_issue)

            #TODO: Si credenciales son erroneas no hay error correcto aqui.
            # para probar imprimir content_an_issue

            # Data frame wrangling
            if (full_info == FALSE) {
                # Sacarlo usuarios que crearon el tiquete
                users <- content_an_issue$user
                users <- as_tibble(users) %>%
                    select(username) %>%
                    rename(author = username)

                # Sacar usuarios que han sido asigandos al tiquete
                assignees <- content_an_issue$assignee
                assignees <- as_tibble(assignees) %>%
                    select(username) %>%
                    rename(assignee = username)

                # Unirlo por posicion
                issues_content <- content_an_issue %>%
                    select(number, title, created_at, updated_at, due_date) %>%
                    bind_cols(users, assignees) %>%
                    tidyr::separate(col = created_at,
                                    into = c("created_date", "created_time"),
                                    sep = "T") %>%
                    tidyr::separate(col = updated_at,
                                    into = c("updated_date", "updated_time"),
                                    sep = "T") %>%
                    mutate(created_time = stringr::str_remove(created_time,
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
