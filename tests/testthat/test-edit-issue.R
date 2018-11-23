context("edit an issue")

# edit_issue
test_that("The connection to the test url gets a response", {
    skip_on_cran()
    
    base_url <- sub("/$", "", base_url)
    gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/repos"),
                           owner,repo,"issues",id_issue)
    
    authorization <- paste("token", api_key)
    
    request_body <- as.list(data.frame(body = body, state = state,
                                       title = title))
    
    r <- PATCH(gitea_url, add_headers(Authorization = authorization),
               content_type_json(), encode = "json", body = request_body)

    expect_true(r$status_code %in% 201)
})

test_that("We geta warning when there is no url", {
    expect_warning(edit_issue(api_key = api_key, owner = owner, repo = repo,
                              id_issue = id_issue, body = body, state = state, 
                              title = title),
                   "Please add a valid URL")
})

test_that("We geta warning when there is no api_key", {
    expect_warning(edit_issue(base_url = base_url, owner = owner, repo = repo,
                              id_issue = id_issue, body = body, state = state, 
                              title = title),
                   "Please add a valid API token")
})

test_that("We geta warning when there is no owner", {
    expect_warning(edit_issue(base_url = base_url, api_key = api_key,
                              repo = repo, id_issue = id_issue, body = body,
                              state = state, title = title),
                   "Please add a valid owner")
})

test_that("We geta warning when there is no repository", {
    expect_warning(edit_issue(base_url = base_url, api_key = api_key,
                              owner = owner, id_issue = id_issue, body = body,
                              state = state, title = title),
                   "Please add a valid repository")
})

test_that("We geta warning when there is no index issue", {
    expect_warning(edit_issue(base_url = base_url, api_key = api_key,
                              owner = owner, repo = repo, body = body,
                              state = state, title = title), 
                   "Please add a index of the issue")
})

test_that("We geta warning when there is no body", {
    expect_warning(edit_issue(base_url = base_url, api_key = api_key,
                              owner = owner, repo = repo, id_issue = id_issue,
                              state = state, title = title),
                   "Please add a valid body")
})

test_that("We geta warning when there is no state", {
    expect_warning(edit_issue(base_url = base_url, api_key = api_key,
                              owner = owner, repo = repo, id_issue = id_issue,
                              body = body, title = title),
                   "Please add a valid state")
})

test_that("We geta warning when there is no title", {
    expect_warning(edit_issue(base_url = base_url, api_key = api_key,
                              owner = owner, repo = repo, id_issue = id_issue,
                              body = body, state = state),
                   "Please add a valid title")
})

test_that("The edit an issue is read correctly", {
    test_edit_issue <- edit_issue(base_url, api_key, owner, repo, id_issue,
                                    body, state, title)
    expect_true(exists("test_edit_issue"))
})

test_that("Edit an issue gives the expected result", {
    value_edit_issue <- edit_issue(base_url, api_key, owner, repo, id_issue,
                                     body, state, title)
    class(value_edit_issue)
    expect_equal(TRUE, !is.null(value_edit_issue))
    expect_that(value_edit_issue, is_a("list"))
})