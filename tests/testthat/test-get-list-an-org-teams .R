context("list an organization's teams")

# get_list_an_org_teams
test_that("The connection to the test url gets a response", {
    skip_on_cran()

    base_url <- sub("/$", "", base_url)
    gitea_url <- file.path(base_url, "api/v1",
                           sub("^/", "", "/orgs"), org,"teams") 
    
    authorization <- paste("token", api_key)
    r <- GET(gitea_url, add_headers(Authorization = authorization), 
             accept_json(), config = httr::config(ssl_verifypeer = FALSE))
    
    expect_true(r$status_code %in% c(200, 403, 500))
})

test_that("We get a error when there is no url", {
    expect_error(get_list_org_teams(api_key = api_key, org = org), 
                   "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
    expect_error(get_list_org_teams(base_url = base_url, org = org), 
                   "Please add a valid API token")
})

test_that("We get a error when there is no name of organization", {
    expect_error(get_list_org_teams(base_url = base_url, api_key = api_key), 
                   "Please add a valid name of the organization")
})

test_that("The list an organization's teams is read correctly", {
    test_list_org_teams <- get_list_org_teams(base_url, api_key, org)
    expect_true(exists("test_list_org_teams"))
})

test_that("Obtaining list an organization's teams gives the expected result", {
    value_list_org_teams <- get_list_org_teams(base_url, api_key, org)
    expect_equal(TRUE, !is.null(value_list_org_teams))
    expect_that(value_list_org_teams, is_a("data.frame"))
})
