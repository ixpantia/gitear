context("get an organization")


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

    mockery::stub(where = get_an_organization,
                  what = "tryCatch",
                  how = "Failure")

    expect_error(get_an_organization("google.com", api_key, org),
                 "Error consulting the url: ")
})

test_that("The organization is read correctly", {

    mockery::stub(where = get_an_organization,
                  what = "GET",
                  how = r)

    mockery::stub(where = get_an_organization,
                  what = "fromJSON",
                  how = content_an_organization)

    test_an_organization <- get_an_organization(base_url, api_key, org)
    expect_true(exists("test_an_organization"))
})

test_that("Obtaining an organization gives the expected result", {

    mockery::stub(where = get_an_organization,
                  what = "GET",
                  how = r)

    mockery::stub(where = get_an_organization,
                  what = "fromJSON",
                  how = content_an_organization)

    value_an_organization <- get_an_organization(base_url, api_key, org)
    expect_equal(TRUE, !is.null(value_an_organization))
    expect_that(value_an_organization, is_a("data.frame"))
    expect_true(unique(value_an_organization$id) == id_org)
    expect_output(str(value_an_organization$username), org)
})
