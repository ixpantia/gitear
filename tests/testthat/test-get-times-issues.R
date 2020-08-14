context("get times issues")



test_that("We get a error when there is no url", {
    expect_error(get_times_issue(api_key = api_key, owner = owner,
                                   repo = repo, id_issue = id_issue),
                   "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
    expect_error(get_times_issue(base_url = base_url, owner = owner,
                                   repo = repo, id_issue = id_issue),
                   "Please add a valid API token")
})

test_that("We get a error when there is no owner", {
    expect_error(get_times_issue(base_url = base_url, api_key = api_key,
                                   repo = repo, id_issue = id_issue),
                   "Please add a valid owner")
})

test_that("We get a error when there is no repository", {
    expect_error(get_times_issue(base_url = base_url, api_key = api_key,
                                   owner = owner, id_issue = id_issue),
                   "Please add a valid repository")
})

test_that("We get a error when there is no index issue", {
    expect_error(get_times_issue(base_url = base_url, api_key = api_key,
                                   owner = owner, repo = repo),
                   "Please add a index of the issue")
})

test_that("Error putting invalid url for API", {

    mockery::stub(where = get_times_issue,
                  what = "tryCatch",
                  how = "Failure")

    expect_error(get_times_issue("google.com", api_key, owner, repo,
                                 id_issue),
                 "Error consulting the url: ")
})

test_that("The times issues is read correctly", {

    mockery::stub(where = get_times_issue,
                  what = "GET",
                  how = r)

    mockery::stub(where = get_times_issue,
                  what = "fromJSON",
                  how = content_issue_times)

    test_times_issues <- get_times_issue(base_url, api_key, owner, repo,
                                         id_issue)
    expect_true(exists("test_times_issues"))
})

test_that("Obtaining an time issues gives the expected result", {

    mockery::stub(where = get_times_issue,
                  what = "GET",
                  how = r)

    mockery::stub(where = get_times_issue,
                  what = "fromJSON",
                  how = content_issue_times)

    value_times_issues <- get_times_issue(base_url, api_key, owner, repo,
                                          id_issue)

    expect_equal(TRUE, !is.null(value_times_issues))
    expect_that(value_times_issues, is_a("data.frame"))
})
