context("get comment issue")

# get_comment_issue
test_that("The connection to the test url gets a response", {
    skip_on_cran()
    
    base_url <- sub("/$", "", base_url)
    gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/repos"), 
                           owner,repo,"issues",id_issue, "comments")
    
    authorization <- paste("token", api_key)
    r <- GET(gitea_url, add_headers(Authorization = authorization),
             accept_json())
    
    expect_true(r$status_code %in% c(200, 403, 500))
})

test_that("We geta warning when there is no url", {
    expect_warning(get_an_issue_comment(api_key = api_key, owner = owner,
                                        repo = repo, id_issue = id_issue),
                   "Please add a valid URL")
    })

test_that("We geta warning when there is no api_key", {
    expect_warning(get_an_issue_comment(base_url = base_url, owner = owner,
                                        repo = repo, id_issue = id_issue),
                   "Please add a valid API token")
})

test_that("The comments of issues is read correctly", {
    test_issue_comment <- get_an_issue_comment(base_url, api_key, owner,
                                               repo, id_issue)
    expect_true(exists("test_issue_comment"))
})

test_that("Obtaining issue comments gives the expected result", {
    value_issue_comment<- get_an_issue_comment(base_url, api_key, owner,
                                           repo, id_issue)
    expect_equal(TRUE, !is.null(value_issue_comment))
    expect_that(value_issue_comment, is_a("data.frame"))
    expect_true(nrow(value_issue_comment) > 0)
})


