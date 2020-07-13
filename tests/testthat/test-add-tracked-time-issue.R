context("add a tracked time to a issue")

# add_tracked_time_issue
test_that("The connection to the test url gets a response", {
    skip_on_cran()

    base_url <- sub("/$", "", base_url)
    gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/repos"),
                           owner, repo, "issues", id_issue, "times")

    authorization <- paste("token", api_key)

    request_body <- as.list(data.frame(time = as.numeric(time)))

    r <- POST(gitea_url, add_headers(Authorization = authorization),
              content_type_json(), encode = "json", body = request_body)

    expect_true(r$status_code %in% c(200, 403, 500))
})

test_that("We geta warning when there is no url", {
    expect_warning(add_tracked_time_issue(api_key = api_key, owner = owner,
                                   repo = repo, id_issue = id_issue,
                                   time = time),
                   "Please add a valid URL")
})

test_that("We geta warning when there is no api_key", {
    expect_warning(add_tracked_time_issue(base_url = base_url, owner = owner,
                                   repo = repo, id_issue = id_issue,
                                   time = time),
                   "Please add a valid API token")
})

test_that("We geta warning when there is no owner", {
    expect_warning(add_tracked_time_issue(base_url = base_url,
                                          api_key = api_key, repo = repo,
                                          id_issue = id_issue, time = time),
                   "Please add a valid owner")
})

test_that("We geta warning when there is no repository", {
    expect_warning(add_tracked_time_issue(base_url = base_url,
                                          api_key = api_key, owner = owner,
                                          id_issue = id_issue, time = time),
                   "Please add a valid repository")
})

test_that("We geta warning when there is no index issue", {
    expect_warning(add_tracked_time_issue(base_url = base_url,
                                          api_key = api_key, owner = owner,
                                          repo = repo, time = time),
                   "Please add a index of the issue")
})

test_that("We geta warning when there is no time", {
    expect_warning(add_tracked_time_issue(base_url = base_url,
                                          api_key = api_key, owner = owner,
                                          repo = repo, id_issue = id_issue),
                   "Please add a valid time in seconds")
})

test_that("The add tracked times issues is read correctly", {
    test_tracked_time <- add_tracked_time_issue(base_url, api_key, owner,
                                                repo, id_issue, time)
    expect_true(exists("test_tracked_time"))
})

test_that("Add an tracked times issues gives the expected result", {
    value_times_issues <- add_tracked_time_issue(base_url, api_key, owner,
                                                 repo, id_issue, time)
    expect_equal(TRUE, !is.null(value_times_issues))
    expect_that(value_times_issues, is_a("data.frame"))
})
