
context("get list an organization's webhooks")

# get_org_list_hooks
test_that("The connection to the test url gets a response", {
    skip_on_cran()
    
    base_url <- sub("/$", "", base_url)
    gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/orgs"), org,"hooks")
    
    r <- GET(gitea_url, add_headers(Authorization=api_key), accept_json())
    expect_true(r$status_code %in% c(200, 403, 500))
})

test_that("We geta warning when there is no url", {
    expect_warning(get_org_list_hooks(org = org, api_key = api_key), "Please add a valid URL")
})

test_that("We geta warning when there is no api_key", {
    expect_warning(get_org_list_hooks(org = org, base_url = base_url),"Please add a valid API token for the URL you are trying to access")
})

test_that("We geta warning when there is no name of organization", {
    expect_warning(get_org_list_hooks(base_url = base_url, api_key = api_key),"Please add a valid name of the organization")
})

test_that("The list hook is read correctly", {
    test_org_list_hooks <- get_org_list_hooks(org, base_url, api_key)
    expect_true(exists("test_org_list_hooks"))
})
