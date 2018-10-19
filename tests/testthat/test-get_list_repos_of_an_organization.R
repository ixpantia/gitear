
context("get list an organization's repos")

# get_list_repos_org
test_that("The connection to the test url gets a response", {
    skip_on_cran()

    base_url <- sub("/$", "", base_url)
    gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/orgs"), org, "repos")
    
    authorization <- paste("token", api_key)
    r <- GET(gitea_url, add_headers(Authorization = authorization), accept_json(), config = httr::config(ssl_verifypeer = FALSE))
    
    expect_true(r$status_code %in% c(200, 403, 500))
})

test_that("We geta warning when there is no url", {
    expect_warning(get_list_repos_org(org = org, api_key = api_key), "Please add a valid URL")
})

test_that("We geta warning when there is no api_key", {
    expect_warning(get_list_repos_org(org = org, base_url = base_url),"Please add a valid API token for the URL you are trying to access")
})

test_that("We geta warning when there is no name of organization", {
    expect_warning(get_list_repos_org(base_url = base_url, api_key = api_key),"Please add a valid name of the organization")
})

test_that("The organization is read correctly", {
    test_lis_org_repos <- get_list_repos_org(org, base_url, api_key)
    expect_true(exists("test_lis_org_repos"))
})

test_that("Calculation to obtain a list of repositories of an organization gives the expected result", {
    value_lis_repo <- get_list_repos_org(org, base_url, api_key)
    expect_equal(TRUE, !is.null(value_lis_repo))
    expect_that(value_lis_repo, is_a("data.frame"))
    expect_true(nrow(value_lis_repo)>0)
})