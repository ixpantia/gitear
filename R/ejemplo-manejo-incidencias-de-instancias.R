library("httr")
library("jsonlite")
library("gitear")

extraer_incidentes <- function(lista_intancia) {
  
    hilera <- " "
    
    if (missing(lista_intancia)) {
        warning("Please add a valid list")
    } else {
        try({
            for (ins in lista) {
                issues <- (get_issues(ins$inst1[1], ins$inst1[2], ins$inst1[3], ins$inst1[4]))
                print(issues)
                }
        })
    }
}

base_url <- Sys.getenv("URI")
api_key <- Sys.getenv("TOKEN")
owner <- Sys.getenv("USUARIO")

instancia_1 <- c(base_url, api_key, owner, "repositorio_1")
instancia_2 <- c(base_url, api_key, owner,"repositorio_2")

lista <- list()
lista$inst1 <- instancia_1
lista$inst2 <- instancia_2

extraer_incidentes(lista)
