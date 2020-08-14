context("create a issue")


test_that("We get a error when there is no url", {
    expect_error(create_issue(api_key = api_key, owner = owner, repo = repo,
                                title = title, body = body),
                   "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
    expect_error(create_issue(base_url = base_url, owner = owner, repo = repo,
                                title = title, body = body),
                   "Please add a valid API token")
})

test_that("We get a error when there is no owner", {
    expect_error(create_issue(base_url = base_url, api_key = api_key,
                                repo = repo, title = title, body = body),
                   "Please add a valid owner")
})

test_that("We get a error when there is no repository", {
    expect_error(create_issue(base_url = base_url, api_key = api_key,
                                owner = owner, title = title, body = body),
                   "Please add a valid repository")
})

test_that("We get a error when there is no title", {
    expect_error(create_issue(base_url = base_url, api_key = api_key,
                                owner = owner, repo = repo,
                                body = body), "Please add a valid title")
})

test_that("We get a error when there is no body", {
    expect_error(create_issue(base_url = base_url, api_key = api_key,
                                owner = owner, repo = repo,
                                title = title), "Please add a valid body")
})

test_that("Error putting invalid url for API", {

    mockery::stub(where = create_issue,
                  what = "tryCatch",
                  how = "Failure")

    expect_error(create_issue("google.com", api_key, owner,
                              repo, title, body),
                 "Error consulting the url: ")
})

test_that("The issues create is read correctly", {

    mockery::stub(where = create_issue,
                  what = "POST",
                  how = r)

    mockery::stub(where = create_issue,
                  what = "fromJSON",
                  how = content_create_issue)

    test_create_issues <- create_issue(base_url, api_key, owner, repo, title,
                                       body)

    expect_true(exists("test_create_issues"))
})

test_that("The calculation of create an issues gives the expected result", {

    mockery::stub(where = create_issue,
                  what = "POST",
                  how = r)

    mockery::stub(where = create_issue,
                  what = "fromJSON",
                  how = content_create_issue)

    value_create_issues <- create_issue(base_url, api_key, owner,
                                        repo, title, body)

    expect_equal(TRUE, !is.null(value_create_issues))
    expect_that(value_create_issues, is_a("list"))
})
