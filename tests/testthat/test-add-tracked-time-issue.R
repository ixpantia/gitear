context("add a tracked time to a issue")


test_that("We get a error when there is no url", {
    expect_error(add_tracked_time_issue(api_key = api_key, owner = owner,
                                   repo = repo, id_issue = id_issue,
                                   time = time),
                   "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
    expect_error(add_tracked_time_issue(base_url = base_url, owner = owner,
                                   repo = repo, id_issue = id_issue,
                                   time = time),
                   "Please add a valid API token")
})

test_that("We get a error when there is no owner", {
    expect_error(add_tracked_time_issue(base_url = base_url,
                                          api_key = api_key, repo = repo,
                                          id_issue = id_issue, time = time),
                   "Please add a valid owner")
})

test_that("We get a error when there is no repository", {
    expect_error(add_tracked_time_issue(base_url = base_url,
                                          api_key = api_key, owner = owner,
                                          id_issue = id_issue, time = time),
                   "Please add a valid repository")
})

test_that("We get a error when there is no index issue", {
    expect_error(add_tracked_time_issue(base_url = base_url,
                                          api_key = api_key, owner = owner,
                                          repo = repo, time = time),
                   "Please add a index of the issue")
})

test_that("We get a error when there is no time", {
    expect_error(add_tracked_time_issue(base_url = base_url,
                                          api_key = api_key, owner = owner,
                                          repo = repo, id_issue = id_issue),
                   "Please add a valid time in seconds")
})

test_that("Error putting invalid url for API", {

    mockery::stub(where = add_tracked_time_issue,
                  what = "tryCatch",
                  how = "Failure")

    expect_error(add_tracked_time_issue(base_url = "google.com",
                                        api_key = api_key, owner = owner,
                                        repo = repo, time = time,
                                        id_issue = id_issue),
                 "Error consulting the url: ")
})

test_that("The add tracked times issues is read correctly", {

    mockery::stub(where = add_tracked_time_issue,
                  what = "POST",
                  how = r)

    mockery::stub(where = add_tracked_time_issue,
                  what = "fromJSON",
                  how = content_tracked_time)

    test_tracked_time <- add_tracked_time_issue(base_url, api_key, owner,
                                                repo, id_issue, time)
    expect_true(exists("test_tracked_time"))
})

test_that("Add an tracked times issues gives the expected result", {

    mockery::stub(where = add_tracked_time_issue,
                  what = "POST",
                  how = r)

    mockery::stub(where = add_tracked_time_issue,
                  what = "fromJSON",
                  how = content_tracked_time)

    value_times_issues <- add_tracked_time_issue(base_url, api_key, owner,
                                                 repo, id_issue, time)
    expect_equal(TRUE, !is.null(value_times_issues))
    expect_that(value_times_issues, is_a("data.frame"))
})
