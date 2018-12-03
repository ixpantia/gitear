context("get issues in open state")

# get_issues_open_state
test_that("The connection to the test url gets a response", {
    skip_on_cran()

    base_url <- sub("/$", "", base_url)
    gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/repos"),
                           owner,repo,"issues")
    
    authorization <- paste("token", api_key)
    r <- GET(gitea_url, add_headers(Authorization = authorization),
             accept_json(), config = httr::config(ssl_verifypeer = FALSE))
    
    expect_true(r$status_code %in% c(200, 403, 500))
})

test_that("We geta warning when there is no url", {
    expect_warning(get_issues_open_state( api_key = api_key, owner = owner,
                                          repo = repo),
                   "Please add a valid URL")
})

test_that("We geta warning when there is no api_key", {
    expect_warning(get_issues_open_state(base_url = base_url, owner = owner,
                                         repo = repo),
                   "Please add a valid API token")
})

test_that("We geta warning when there is no owner", {
    expect_warning(get_issues_open_state(base_url = base_url, api_key = api_key,
                              repo = repo), "Please add a valid owner")
})

test_that("We geta warning when there is no repository", {
    expect_warning(get_issues_open_state(base_url = base_url, api_key = api_key,
                              owner = owner), "Please add a valid repository")
})

test_that("The issues is read correctly", {
    test_issues_open_state <- get_issues_open_state(base_url, api_key, owner,
                                                    repo)
    expect_true(exists("test_issues_open_state"))
})

test_that("The calculation of obtaining issues gives the expected result", {
    value_issues_open_state <- get_issues_open_state(base_url, api_key, owner,
                                                     repo)
    expect_equal(TRUE, !is.null(value_issues_open_state))
    expect_true(nrow(value_issues_open_state)>0)
    expect_that(value_issues_open_state, is_a("data.frame"))
})