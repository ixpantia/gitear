context("create a issue")

# create_issues
test_that("The connection to the test url gets a response", {
    skip_on_cran()
    
    base_url <- sub("/$", "", base_url)
    gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/repos"), 
                           owner, repo, "issues")
    
    authorization <- paste("token", api_key)
    request_body <- as.list(data.frame(title = title, body = body))
    
    r <- POST(gitea_url, add_headers(Authorization = authorization), 
              content_type_json(), encode = "json", body = request_body)
    
    expect_equal(r$status_code, 201)
})

test_that("We geta warning when there is no url", {
    expect_warning(create_issue(api_key = api_key, owner = owner, repo = repo, 
                                title = title, body = body), 
                   "Please add a valid URL")
})

test_that("We geta warning when there is no api_key", {
    expect_warning(create_issue(base_url = base_url, owner = owner, repo = repo,
                                title = title, body = body), 
                   "Please add a valid API token")
})

test_that("We geta warning when there is no owner", {
    expect_warning(create_issue(base_url = base_url, api_key = api_key, 
                                repo = repo, title = title, body = body), 
                   "Please add a valid owner")
})

test_that("We geta warning when there is no repository", {
    expect_warning(create_issue(base_url = base_url, api_key = api_key, 
                                owner = owner, title = title, body = body), 
                   "Please add a valid repository")
})

test_that("We geta warning when there is no title", {
    expect_warning(create_issue(base_url = base_url, api_key = api_key, 
                                owner = owner, repo = repo, 
                                body = body), "Please add a valid title")
})

test_that("We geta warning when there is no body", {
    expect_warning(create_issue(base_url = base_url, api_key = api_key, 
                                owner = owner, repo = repo, 
                                title = title), "Please add a valid body")
})

test_that("The issues create is read correctly", {
    test_create_issues <- create_issue(base_url, api_key, owner, repo, title, 
                                       body)
    expect_true(exists("test_create_issues"))
})

test_that("The calculation of create an issues gives the expected result", {
    value_create_issues <- create_issue(base_url, api_key, owner, 
                                        repo, title, body)
    expect_equal(TRUE, !is.null(value_create_issues))
    expect_that(value_create_issues, is_a("list"))
})