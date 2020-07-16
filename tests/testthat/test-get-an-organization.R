context("get an organization")

# get_an_organization
test_that("The connection to the test url gets a response", {
    skip_on_cran()

    base_url <- sub("/$", "", base_url)
    gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/orgs"), org)

    authorization <- paste("token", api_key)
    r <- GET(gitea_url, add_headers(Authorization = authorization),
             accept_json(), config = httr::config(ssl_verifypeer = FALSE))

    expect_true(r$status_code %in% c(200, 403, 500))
})

test_that("We get a error when there is no url", {
    expect_error(get_an_organization(api_key = api_key, org = org),
                   "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
    expect_error(get_an_organization(base_url = base_url, org = org),
                   "Please add a valid API token")
})

test_that("We get a error when there is no name of organization", {
    expect_error(get_an_organization(base_url = base_url, api_key = api_key),
                   "Please add a valid name of the organization")
})

test_that("Error putting invalid url for API", {
    expect_error(get_an_organization("google.com", api_key, org),
                 "Error consulting the url: ")
})

test_that("The organization is read correctly", {
    test_an_organization <- get_an_organization(base_url, api_key, org)
    expect_true(exists("test_an_organization"))
})

test_that("Obtaining an organization gives the expected result", {
    value_an_organization <- get_an_organization(base_url, api_key, org)
    expect_equal(TRUE, !is.null(value_an_organization))
    expect_that(value_an_organization, is_a("data.frame"))
    expect_true(unique(value_an_organization$id) == id_org)
    expect_output(str(value_an_organization$username), org)
})
