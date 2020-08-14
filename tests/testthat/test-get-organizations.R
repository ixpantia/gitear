context("organizations")


test_that("We get a error when there is no url", {
    expect_error(get_organizations(api_key = api_key),
                   "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
    expect_error(get_organizations(base_url = base_url),
                   "Please add a valid API token")
})

test_that("Error putting invalid url for API", {

    mockery::stub(where = get_organizations,
                  what = "tryCatch",
                  how = "Failure")

    expect_error(get_organizations("google.com", api_key),
                 "Error consulting the url: ")
})

test_that("The organizations is read correctly", {

    mockery::stub(where = get_organizations,
                  what = "GET",
                  how = r)

    mockery::stub(where = get_organizations,
                  what = "fromJSON",
                  how = content_organizations)

    test_organizations <- get_organizations(base_url, api_key)
    expect_true(exists("test_organizations"))
})

test_that("Obtaining organization list gives the expected result", {

    mockery::stub(where = get_organizations,
                  what = "GET",
                  how = r)

    mockery::stub(where = get_organizations,
                  what = "fromJSON",
                  how = content_organizations)

    value_list_org <- get_organizations(base_url, api_key)
    expect_equal(TRUE, !is.null(value_list_org))
    expect_that(value_list_org, is_a("data.frame"))
    expect_true(nrow(value_list_org) > 0)
})
