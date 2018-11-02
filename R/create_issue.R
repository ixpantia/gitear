#' @import httr
#' @import jsonlite
#'
#' @description Create an issue
#' @title Create an issue 
#'
#' @param owner Owner of the repo
#' @param repo Is the name of the repo.
#' @param base_url URL prefix for your gitea server (no trailing '/')
#' @param api_key The user's API token key for the gitea service
#' 
#' @return list (invisibly) with the status result of the API
#' 
create_issue <- function(base_url, api_key, titulo, incidente){
 #   /repos/{owner}/{repo}/issues 
    if (missing(base_url)) {
        warning("Please add a valid URL")
    } else if (missing(api_key)) {
        warning("Please add a valid API token")
    } else if (missing(titulo)) {
        warning("Please add a valid title")
    } else if (missing(incidente)) {
        warning("Please add a valid body")
    } else
        try({
            base_url <- sub("/$", "", base_url)
            gitea_url <- file.path(base_url, "api/v1",
                                   sub("^/", "", "/repos"), owner,repo,"issues")
       
            authorization <- paste("token", api_key)
            
            requestBody <- data.frame(
                title = titulo,
                body = incidente
            )
            
            r <- POST(gitea_url, add_headers(Authorization = authorization),
                      content_type_json(), encode = "json", 
                      body = as.list(requestBody))
            
            content_issue <- content(r, as = "text")
            content_issue <- fromJSON(content_issue)
            content_issue
            return(content_issues)
            })
}

titulo = "Prueba de Rstudio"
incidente = "Esperando a que funcione"
print(create_issue(base_url, api_key, title ,body))

    