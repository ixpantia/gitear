context("edit an issue")


test_that("We get a error when there is no url", {
    expect_error(edit_issue(api_key = api_key, owner = owner, repo = repo,
                              id_issue = id_issue, body = body, state = state,
                              title = title),
                   "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
    expect_error(edit_issue(base_url = base_url, owner = owner, repo = repo,
                              id_issue = id_issue, body = body, state = state,
                              title = title),
                   "Please add a valid API token")
})

test_that("We get a error when there is no owner", {
    expect_error(edit_issue(base_url = base_url, api_key = api_key,
                              repo = repo, id_issue = id_issue, body = body,
                              state = state, title = title),
                   "Please add a valid owner")
})

test_that("We get a error when there is no repository", {
    expect_error(edit_issue(base_url = base_url, api_key = api_key,
                              owner = owner, id_issue = id_issue, body = body,
                              state = state, title = title),
                   "Please add a valid repository")
})

test_that("We get a error when there is no index issue", {
    expect_error(edit_issue(base_url = base_url, api_key = api_key,
                              owner = owner, repo = repo, body = body,
                              state = state, title = title),
                   "Please add a index of the issue")
})

test_that("We get a error when there is no body", {
    expect_error(edit_issue(base_url = base_url, api_key = api_key,
                              owner = owner, repo = repo, id_issue = id_issue,
                              state = state, title = title),
                   "Please add a valid body")
})

test_that("We get a error when there is no state", {
    expect_error(edit_issue(base_url = base_url, api_key = api_key,
                              owner = owner, repo = repo, id_issue = id_issue,
                              body = body, title = title),
                   "Please add a valid state")
})

test_that("We get a error when there is no title", {
    expect_error(edit_issue(base_url = base_url, api_key = api_key,
                              owner = owner, repo = repo, id_issue = id_issue,
                              body = body, state = state),
                   "Please add a valid title")
})

test_that("Error putting invalid url for API", {

    mockery::stub(where = edit_issue,
                  what = "tryCatch",
                  how = "Failure")

    expect_error(edit_issue("google.com", api_key = api_key,
                            owner = owner, repo = repo, id_issue = id_issue,
                            state = state, title = title, body = body),
                 "Error consulting the url: ")
})

test_that("The edit an issue is read correctly", {

    mockery::stub(where = edit_issue,
                  what = "PATCH",
                  how = r)

    mockery::stub(where = edit_issue,
                  what = "fromJSON",
                  how = content_edit_issue)

    test_edit_issue <- edit_issue(base_url = base_url, api_key = api_key,
                                  owner = owner, repo = repo, id_issue = id_issue,
                                  state = state, title = title, body = body)
    expect_true(exists("test_edit_issue"))
})

test_that("Edit an issue gives the expected result", {

    mockery::stub(where = edit_issue,
                  what = "PATCH",
                  how = r)

    mockery::stub(where = edit_issue,
                  what = "fromJSON",
                  how = content_edit_issue)

    value_edit_issue <- edit_issue(base_url = base_url, api_key = api_key,
                                   owner = owner, repo = repo, id_issue = id_issue,
                                   state = state, title = title, body = body)

    expect_equal(TRUE, !is.null(value_edit_issue))
    expect_that(value_edit_issue, is_a("list"))
})
