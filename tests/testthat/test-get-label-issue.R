context("get an issue's labels")


test_that("We get a error when there is no url", {
    expect_error(get_label_issue(api_key = api_key, owner = owner,
                                   repo = repo, id_issue = id_issue),
                   "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
    expect_error(get_label_issue(base_url = base_url, owner = owner,
                                   repo = repo, id_issue = id_issue),
                   "Please add a valid API token")
})

test_that("We get a error when there is no owner", {
    expect_error(get_label_issue(base_url = base_url, api_key = api_key,
                                   repo = repo, id_issue = id_issue),
                   "Please add a valid owner")
})

test_that("We get a error when there is no repository", {
    expect_error(get_label_issue(base_url = base_url, api_key = api_key,
                                   owner = owner, id_issue = id_issue),
                   "Please add a valid repository")
})

test_that("We get a error when there is no index issue", {
    expect_error(get_label_issue(base_url = base_url, api_key = api_key,
                                   owner = owner, repo = repo),
                   "Please add a index of the issue")
})

test_that("Error putting invalid url for API", {

    mockery::stub(where = get_label_issue,
                  what = "tryCatch",
                  how = "Failure")

    expect_error(get_label_issue(base_url = "google.com",
                                 api_key = api_key, owner = owner,
                                 repo = repo, id_issue = id_issue),
                 "Error consulting the url: ")
})

test_that("The label issues is read correctly", {

    mockery::stub(where = get_label_issue,
                  what = "GET",
                  how = r)

    mockery::stub(where = get_label_issue,
                  what = "fromJSON",
                  how = content_label_issue)

    test_labels_issues <- get_label_issue(base_url, api_key, owner, repo,
                                          id_issue)

    expect_true(exists("test_labels_issues"))
})

test_that("Obtaining an time issues gives the expected result", {

    mockery::stub(where = get_label_issue,
                  what = "GET",
                  how = r)

    mockery::stub(where = get_label_issue,
                  what = "fromJSON",
                  how = content_label_issue)

    value_labels_issues <- get_label_issue(base_url = base_url,
                                           api_key = api_key, owner = owner,
                                           repo = repo, id_issue = id_issue)

    expect_equal(TRUE, !is.null(value_labels_issues))
})
