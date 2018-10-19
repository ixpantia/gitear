library("httr")
library("jsonlite")
library("gitear")

get_overview_state_issues <- function(base_url, api_key){
    o <- ((get_organizations(base_url, api_key))$username)
    for (org in o) {
        r <- ((get_list_repos_org(org, base_url, api_key))$name)
        for (rep in r) {
            t <- ((get_issues(base_url, api_key ,org, rep))$title)
            b <- ((get_issues(base_url, api_key ,org, rep))$body)
            s <-  ((get_issues(base_url, api_key ,org, rep))$state)
            
            sa <- paste("ORG:", org, " REPO:",rep , " TITULO:",t," DESCRIPCION:", b," ESTADO:", s)
            sa
            return(result) 
            }
    }
}

print(get_overview_state_issues("https://try.gitea.io", "6ebcaefdaaf06aa7f59b4efc5faa4bcf1b56cfb1"))
 

