#' @import httr
#' @import jsonlite
#'
#' @description Returns the issues of the Gitea application
#' @title Returns the issues in closed state
#' 
#' @param base_url The base URL for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#' 
#' @param owner The user's owner for the gitea service
#' @param repo The reposository for the gitea service
#'
#'@export
get_issues_closed_state <- function(base_url, api_key, owner, repo){
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
      page <- 1
      while (TRUE) {
        base_url <- sub("/$", "", base_url)
        gitea_url <- file.path(base_url, "api/v1", 
                               sub("^/", "", "/repos"), 
                               owner, 
                               repo, 
                               paste0("issues?state=closed&page=", page))
        
        authorization <- paste("token", api_key)
        r <- GET(gitea_url, add_headers(Authorization = authorization),
                 accept_json())
        
        # To convert http errors to R errors
        stop_for_status(r)

        page_issues <- content(r, as = "text")
        page_issues <- fromJSON(page_issues)
        page_issues <- flatten(as.data.frame(page_issues))

        if (nrow(page_issues) == 0) {
           content_issues <- page_issues
           break
        }
        if (page == 1) {
            content_issues <- page_issues
        } else {
            content_issues <- dplyr::bind_rows(content_issues, page_issues)
        }
        page <- page + 1
    }
  })
  return(content_issues)
}
