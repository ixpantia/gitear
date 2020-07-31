context("get issues")


test_that("We get a error when there is no url", {
    expect_error(get_issues(api_key = api_key, owner = owner,
                                    repo = repo),
                   "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
    expect_error(get_issues(base_url = base_url, owner = owner,
                                repo = repo),
                   "Please add a valid API token")
})

test_that("We get a error when there is no owner", {
    expect_error(get_issues(base_url = base_url, api_key = api_key,
                                repo = repo),
                   "Please add a valid owner")
})

test_that("We get a error when there is no repository", {
    expect_error(get_issues(base_url = base_url, api_key = api_key,
                                owner = owner),
                   "Please add a valid repository")
})

test_that("Error putting invalid url for API", {

    mockery::stub(where = get_issues,
                  what = "tryCatch",
                  how = "Failure")

    expect_error(get_issues("google.com", api_key, owner, repo,
                            full_info = TRUE),
                 "Error consulting the url: ")
})

test_that("Obtaining an issue gives the expected result", {

    mockery::stub(where = get_issues,
                  what = "GET",
                  how = r)

    mockery::stub(where = get_issues,
                  what = "fromJSON",
                  how = content_issues)

    value_an_issue <- get_issues(base_url, api_key, owner, repo)
    expect_equal(TRUE, !is.null(value_an_issue))
    expect_that(value_an_issue, is_a("data.frame"))
})
