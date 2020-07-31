context("repositories")


test_that("We get a error when there is no url", {
    expect_error(get_repositories(api_key = api_key),
                   "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
    expect_error(get_repositories(base_url = base_url),
                   "Please add a valid API token")
})

test_that("Error putting invalid url for API", {

    mockery::stub(where = get_repositories,
                  what = "tryCatch",
                  how = "Failure")

    expect_error(get_repositories("google.com", api_key),
                 "Error consulting the url: ")
})


test_that("The repositories is read correctly", {

    mockery::stub(where = get_repositories,
                  what = "GET",
                  how = r)

    mockery::stub(where = get_repositories,
                  what = "fromJSON",
                  how = content_repositories)

    test_repositories <- get_repositories(base_url, api_key)
    expect_true(exists("test_repositories"))
})

test_that("Obtaining repositories list gives the expected result", {

    mockery::stub(where = get_repositories,
                  what = "GET",
                  how = r)

    mockery::stub(where = get_repositories,
                  what = "fromJSON",
                  how = content_repositories)

    value_list_rep <- get_repositories(base_url, api_key)
    expect_equal(TRUE, !is.null(value_list_rep))
    expect_that(value_list_rep, is_a("data.frame"))
})
