context("get issues in closed state")


test_that("We get a error when there is no url", {
    expect_error(get_issues_closed_state(api_key = api_key, owner = owner,
                                          repo = repo),
                   "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
    expect_error(get_issues_closed_state(base_url = base_url, owner = owner,
                                         repo = repo),
                   "Please add a valid API token")
})

test_that("We get a error when there is no owner", {
    expect_error(get_issues_closed_state(base_url = base_url,
                                           api_key = api_key, repo = repo),
                   "Please add a valid owner")
})

test_that("We get a error when there is no repository", {
    expect_error(get_issues_closed_state(base_url = base_url,
                                           api_key = api_key, owner = owner),
                   "Please add a valid repository")
})

test_that("Error putting invalid url for API", {

    mockery::stub(where = get_issues_closed_state,
                  what = "tryCatch",
                  how = "Failure")

    expect_error(get_issues_closed_state("google.com", api_key,
                                         owner, repo),
                 "Error consulting the url: ")
})
