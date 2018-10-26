
context("organizations")

# get_organizations
test_that("The connection to the test url gets a response", {
    skip_on_cran()

    base_url <- sub("/$", "", base_url)
    gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/user/orgs"))
    
    authorization <- paste("token", api_key)
    r <- GET(gitea_url, add_headers(Authorization = authorization), accept_json(), config = httr::config(ssl_verifypeer = FALSE))
    
    expect_true(r$status_code %in% c(200, 403, 500))
})

test_that("We geta warning when there is no url", {
    expect_warning(get_organizations(api_key = api_key), "Please add a valid URL")
})

test_that("We geta warning when there is no api_key", {
    expect_warning(get_organizations(base_url = base_url),"Please add a valid API token for the URL you are trying to access")
})

test_that("The organizations is read correctly", {
    test_organizations <- get_organizations(base_url, api_key)
    expect_true(exists("test_organizations"))
})

test_that("The calculation of obtaining organization list gives the expected result", {
    value_list_org <- get_organizations(base_url, api_key)
    expect_equal(TRUE, !is.null(value_list_org))
    expect_that(value_list_org, is_a("data.frame"))
    expect_true(nrow(value_list_org) > 0)
})
