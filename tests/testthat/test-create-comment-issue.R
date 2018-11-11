context("create a comment about issue")

# create_comment_issue
test_that("The connection to the test url gets a response", {
    skip_on_cran()
    
    base_url <- sub("/$", "", base_url)
    gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/repos"), 
                           owner,repo,"issues",id_issue, "comments")
    
    authorization <- paste("token", api_key)
    
    request_body <- as.list(data.frame(body = body))
    
    r <- POST(gitea_url, add_headers(Authorization = authorization),
              content_type_json(), encode = "json", body = request_body)

    expect_equal(r$status_code, 201)
})

test_that("We geta warning when there is no url", {
    expect_warning(create_comment_issue(api_key = api_key, owner = owner,
                                        repo = repo, id_issue = id_issue,
                                        body = body),
                   "Please add a valid URL")
})

test_that("We geta warning when there is no api_key", {
    expect_warning(create_comment_issue(base_url = base_url, owner = owner,
                                        repo = repo, id_issue = id_issue,
                                        body = body),
                   "Please add a valid API token")
})

test_that("We geta warning when there is no owner", {
    expect_warning(create_comment_issue(base_url = base_url, api_key = api_key,
                                        repo = repo, id_issue = id_issue,
                                        body = body),
                   "Please add a valid owner")
})

test_that("We geta warning when there is no repo", {
    expect_warning(create_comment_issue(base_url = base_url, api_key = api_key,
                                        owner = owner, id_issue = id_issue, 
                                        body = body),
                   "Please add a valid repository")
})

test_that("We geta warning when there is no id issue", {
    expect_warning(create_comment_issue(base_url = base_url, api_key = api_key,
                                        owner = owner, repo = repo,
                                        body = body),
                   "Please add a index of the issue")
})

test_that("We geta warning when there is no body", {
    expect_warning(create_comment_issue(base_url = base_url, api_key = api_key,
                                        owner = owner, repo = repo,
                                        id_issue = id_issue),
                   "Please add a valid body")
})

test_that("The issues create is read correctly", {
    test_create_comment_issues <- create_comment_issue(base_url, api_key, owner,
                                               repo, id_issue, body)
    expect_true(exists("test_create_comment_issues"))
})

test_that("Create comment an issues gives the expected result", {
    value_create_comment_issues <- create_comment_issue(base_url, api_key,
                                                        owner, repo, 
                                                        id_issue, body)
    expect_equal(TRUE, !is.null(value_create_comment_issues))
    expect_that(value_create_comment_issues, is_a("list"))
})