library("httr")
library("jsonlite")
library("gitear")

get_overview_state_issues <- function(base_url, api_key){
    if (missing(base_url)) {
        warning("Please add a valid URL")
    } else if (missing(api_key)) {
        warning("Please add a valid API token for the URL you are trying to access")
    } else 
        try({
            o <- ((get_organizations(base_url, api_key))$username)
            for (org in o) {
                r <- ((get_list_repos_org(org, base_url, api_key))$name)
                    for (rep in r) {
                        t <- ((get_issues(base_url, api_key ,org, rep))$title)
                        b <- ((get_issues(base_url, api_key ,org, rep))$body)
                        s <-  ((get_issues(base_url, api_key ,org, rep))$state)
                        sa <- paste("ORG:", org, " REPO:",rep , " TITULO:",t," DESCRIPCION:", b," ESTADO:", s)
                        print(sa)
                    }
                    }
            })
}

base_url <- Sys.getenv("URI")
api_key <- Sys.getenv("TOKEN")

get_overview_state_issues(base_url, api_key)
