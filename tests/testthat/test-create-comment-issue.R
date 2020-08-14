context("create a comment about issue")


test_that("We get a error when there is no url", {
    expect_error(create_comment_issue(api_key = api_key, owner = owner,
                                        repo = repo, id_issue = id_issue,
                                        body = body),
                   "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
    expect_error(create_comment_issue(base_url = base_url, owner = owner,
                                        repo = repo, id_issue = id_issue,
                                        body = body),
                   "Please add a valid API token")
})

test_that("We get a error when there is no owner", {
    expect_error(create_comment_issue(base_url = base_url, api_key = api_key,
                                        repo = repo, id_issue = id_issue,
                                        body = body),
                   "Please add a valid owner")
})

test_that("We get a error when there is no repo", {
    expect_error(create_comment_issue(base_url = base_url, api_key = api_key,
                                        owner = owner, id_issue = id_issue,
                                        body = body),
                   "Please add a valid repository")
})

test_that("We get a error when there is no id issue", {
    expect_error(create_comment_issue(base_url = base_url, api_key = api_key,
                                        owner = owner, repo = repo,
                                        body = body),
                   "Please add a index of the issue")
})

test_that("We get a error when there is no body", {
    expect_error(create_comment_issue(base_url = base_url, api_key = api_key,
                                        owner = owner, repo = repo,
                                        id_issue = id_issue),
                   "Please add a valid body")
})

test_that("Error putting invalid url for API", {

    mockery::stub(where = create_comment_issue,
                  what = "tryCatch",
                  how = "Failure")

    expect_error(create_comment_issue("google.com", api_key,
                                      owner, repo,
                                      id_issue, body),
                 "Error consulting the url: ")
})

test_that("The issues comment create is read correctly", {

    mockery::stub(where = create_comment_issue,
                  what = "POST",
                  how = r)

    mockery::stub(where = create_comment_issue,
                  what = "fromJSON",
                  how = add_comment_issue)

    test_create_comment_issues <- create_comment_issue(base_url, api_key, owner,
                                               repo, id_issue, body)
    expect_true(exists("test_create_comment_issues"))
})

test_that("Create comment an issues gives the expected result", {

    mockery::stub(where = create_comment_issue,
                  what = "POST",
                  how = r)

    mockery::stub(where = create_comment_issue,
                  what = "fromJSON",
                  how = add_comment_issue)

    value_create_comment_issues <- create_comment_issue(base_url, api_key,
                                                        owner, repo,
                                                        id_issue, body)
    expect_equal(TRUE, !is.null(value_create_comment_issues))
    expect_that(value_create_comment_issues, is_a("data.frame"))
})

