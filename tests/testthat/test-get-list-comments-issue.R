context("get list comment issue")

# get_list_comment_issue
test_that("The connection to the test url gets a response", {
    skip_on_cran()

    base_url <- sub("/$", "", base_url)
    gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/repos"),
                           owner, repo, "issues", id_issue, "comments")

    authorization <- paste("token", api_key)
    r <- GET(gitea_url, add_headers(Authorization = authorization),
             accept_json())

    expect_true(r$status_code %in% c(200, 403, 500))
})

test_that("We get a error when there is no url", {
    expect_error(get_list_comments_issue(api_key = api_key, owner = owner,
                                        repo = repo, id_issue = id_issue),
                   "Please add a valid URL")
    })

test_that("We get a error when there is no api_key", {
    expect_error(get_list_comments_issue(base_url = base_url, owner = owner,
                                        repo = repo, id_issue = id_issue),
                   "Please add a valid API token")
})

test_that("We get a error when there is no owner", {
    expect_error(get_list_comments_issue(base_url = base_url,
                                           api_key = api_key, repo = repo,
                                           id_issue = id_issue),
                   "Please add a valid owner")
})

test_that("We get a error when there is no repository", {
    expect_error(get_list_comments_issue(base_url = base_url,
                                           api_key = api_key, owner = owner,
                                           id_issue = id_issue),
                   "Please add a valid repository")
})

test_that("We get a error when there is no index issue", {
    expect_error(get_list_comments_issue(base_url = base_url,
                                           api_key = api_key, owner = owner,
                                           repo = repo),
                   "Please add a index of the issue")
})

test_that("The comments of issues is read correctly", {
    test_list_comments_issue <- get_list_comments_issue(base_url, api_key,
                                                        owner, repo, id_issue)
    expect_true(exists("test_list_comments_issue"))
})

test_that("Obtaining issue comments gives the expected result", {
    value_list_comments_issue <- get_list_comments_issue(base_url, api_key,
                                                         owner, repo, id_issue)
    expect_equal(TRUE, !is.null(value_list_comments_issue))
    expect_that(value_list_comments_issue, is_a("data.frame"))
})
