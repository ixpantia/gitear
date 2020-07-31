context("Get pull requests")


test_that("We get a error when there is no url", {
  expect_error(get_pull_requests(api_key = api_key, owner = owner,
                                repo = repo),
                 "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
  expect_error(get_pull_requests(base_url = base_url, owner = owner,
                                repo = repo),
                 "Please add a valid API token")
})

test_that("We get a error when there is no owner", {
  expect_error(get_pull_requests(base_url = base_url, api_key = api_key,
                                repo = repo),
                 "Please add a valid owner")
})

test_that("We get a error when there is no repository", {
  expect_error(get_pull_requests(base_url = base_url, api_key = api_key,
                                owner = owner),
                 "Please add a valid repository")
})

test_that("Error putting invalid url for API", {

  mockery::stub(where = get_pull_requests,
                what = "tryCatch",
                how = "Failure")

  expect_error(get_pull_requests("google.com", api_key, owner, repo),
               "Error consulting the url: ")
})

test_that("Pull requests are read correctly", {

  mockery::stub(where = get_pull_requests,
                what = "GET",
                how = r)

  mockery::stub(where = get_pull_requests,
                what = "fromJSON",
                how = content_pull_req)

  test_list_pull_req <- get_pull_requests(base_url, api_key, owner, repo)
  expect_true(exists("test_list_pull_req"))
})

test_that("Getting pull requests gives the expected result", {

  mockery::stub(where = get_pull_requests,
                what = "GET",
                how = r)

  mockery::stub(where = get_pull_requests,
                what = "fromJSON",
                how = content_pull_req)

  value_pull_requests <- get_pull_requests(base_url, api_key, owner, repo)
  expect_equal(TRUE, !is.null(value_pull_requests))
  expect_that(value_pull_requests, is_a("data.frame"))
})
