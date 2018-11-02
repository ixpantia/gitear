context("get list all comments in a repository")

# get_list_all_comments_in_a_repository
test_that("The connection to the test url gets a response", {
    skip_on_cran()
    
    base_url <- sub("/$", "", base_url)
    gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/repos"),
                           owner,repo,"issues/comments")
    
    authorization <- paste("token", api_key)
    r <- GET(gitea_url, add_headers(Authorization = authorization),
             accept_json())
    
    expect_true(r$status_code %in% c(200, 403, 500))
})

test_that("We geta warning when there is no url", {
    expect_warning(get_list_comments_repository(api_key = api_key, 
                                                owner = owner, repo = repo),
                   "Please add a valid URL")
})

test_that("We geta warning when there is no api_key", {
    expect_warning(get_list_comments_repository(base_url = base_url,
                                                owner = owner, repo = repo),
                   "Please add a valid API token")
})

test_that("We geta warning when there is no owner", {
    expect_warning(get_list_comments_repository(base_url = base_url,
                                                api_key = api_key, repo = repo),
                   "Please add a valid owner")
})

test_that("We geta warning when there is no repository", {
    expect_warning(get_list_comments_repository(base_url = base_url,
                                                api_key = api_key,
                                                owner = owner),
                   "Please add a valid repository")
})

test_that("The list all comments in a repository is read correctly", {
    test_list_comments_repository <- get_list_comments_repository(base_url,
                                                                  api_key, 
                                                                  owner, repo)
    expect_true(exists("test_list_comments_repository"))
})

test_that("Obtaining issue comments gives the expected result", {
    value_list_comments_repository <- get_list_comments_repository(base_url,
                                                              api_key, 
                                                              owner, repo)
    expect_equal(TRUE, !is.null(value_list_comments_repository))
    expect_that(value_list_comments_repository, is_a("data.frame"))
})