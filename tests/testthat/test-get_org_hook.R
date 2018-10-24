
context("get org hook")

# get_org_hook
test_that("The connection to the test url gets a response", {
    skip_on_cran()
    
    base_url <- sub("/$", "", base_url)
    gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/orgs"), org,"hooks", id_hook)

    authorization <- paste("token", api_key)
    r <- GET(gitea_url, add_headers(Authorization = authorization), accept_json(), config = httr::config(ssl_verifypeer = FALSE))
    
    expect_true(r$status_code %in% c(200, 403, 500))
})

test_that("We geta warning when there is no url", {
    expect_warning(get_org_hook(id_hook = id_hook, org = org, api_key = api_key), "Please add a valid URL")
})

test_that("We geta warning when there is no api_key", {
    expect_warning(get_org_hook(id_hook = id_hook, org = org, base_url = base_url),"Please add a valid API token for the URL you are trying to access")
})

test_that("We geta warning when there is no name of organization", {
    expect_warning(get_org_hook(id_hook = id_hook, base_url = base_url, api_key = api_key),"Please add a valid name of the organization")
})

test_that("We geta warning when there is no id", {
    expect_warning(get_org_hook(org = org, base_url = base_url, api_key = api_key),"Please add a id valid of hook")
})

test_that("The hook is read correctly", {
    test_get_org_hook <- get_org_hook(id_hook, org, base_url, api_key)
    expect_true(exists("test_get_org_hook"))
})

test_that("The calculation of obtaining one hook gives the expected result", {
    value_hook <- get_org_hook(id_hook, org, base_url, api_key)
    expect_equal(TRUE, !is.null(value_hook))
    expect_that(value_hook, is_a("data.frame"))
    expect_true(nrow(value_hook) == 1)
})
