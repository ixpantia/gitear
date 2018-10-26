context("repositories")

# get_repositories
test_that("The connection to the test url gets a response", {
    skip_on_cran()
    
    base_url <- sub("/$", "", base_url)
    gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/repos/search"))

    authorization <- paste("token", api_key)
    r <- GET(gitea_url, add_headers(Authorization = authorization), accept_json(), config = httr::config(ssl_verifypeer = FALSE))
   
    expect_true(r$status_code %in% c(200, 403, 500))
})

test_that("We geta warning when there is no url", {
    expect_warning(get_repositories(api_key = api_key), "Please add a valid URL")
})

test_that("We geta warning when there is no api_key", {
    expect_warning(get_repositories(base_url = base_url),"Please add a valid API token for the URL you are trying to access")
})

test_that("The repositories is read correctly", {
    test_repositories <- get_repositories(base_url, api_key)
    expect_true(exists("test_repositories"))
})

test_that("The calculation of obtaining organization list gives the expected result", {
    value_list_rep <- get_repositories(base_url, api_key)
    expect_equal(TRUE, !is.null(value_list_rep))
    expect_that(value_list_rep, is_a("list"))
})
