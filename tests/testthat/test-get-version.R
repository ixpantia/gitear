context("version")


test_that("We get a error when there is no url", {
    expect_error(get_version(api_key = api_key), "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
    expect_error(get_version(base_url = base_url),
                   "Please add a valid API token")
})

test_that("Error putting invalid url for API", {

    mockery::stub(where = get_version,
                  what = "tryCatch",
                  how = "Failure")

    expect_error(get_version("google.com", api_key),
                 "Error consulting the url: ")
})

test_that("The version is read correctly", {

    mockery::stub(where = get_version,
                  what = "GET",
                  how = r)

    mockery::stub(where = get_version,
                  what = "fromJSON",
                  how = content_version)

    test_version <- get_version(base_url, api_key)
    expect_true(exists("test_version"))
})

test_that("The calculation of obtaining version gives the expected result", {

    mockery::stub(where = get_version,
                  what = "GET",
                  how = r)

    mockery::stub(where = get_version,
                  what = "fromJSON",
                  how = content_version)

    value_version <- get_version(base_url, api_key)
    expect_equal(TRUE, !is.null(value_version))
    expect_that(value_version, is_a("data.frame"))
})
