context("Get forks")


test_that("We get a error when there is no url", {
  expect_error(get_forks(api_key = api_key, owner = owner,
                                repo = repo),
                 "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
  expect_error(get_forks(base_url = base_url, owner = owner,
                                repo = repo),
                 "Please add a valid API token")
})

test_that("We get a error when there is no owner", {
  expect_error(get_forks(base_url = base_url, api_key = api_key,
                                repo = repo),
                 "Please add a valid owner")
})

test_that("We get a error when there is no repository", {
  expect_error(get_forks(base_url = base_url, api_key = api_key,
                                owner = owner),
                 "Please add a valid repository")
})

test_that("Error putting invalid url for API", {

  mockery::stub(where = get_forks,
                what = "tryCatch",
                how = "Failure")


  expect_error(get_forks("google.com", api_key, owner, repo),
               "Error consulting the url: ")
})

test_that("Forks are read correctly", {

  mockery::stub(where = get_forks,
                what = "GET",
                how = r)

  mockery::stub(where = get_forks,
                what = "fromJSON",
                how = content_forks)

  test_list_forks <- get_forks(base_url, api_key, owner, repo)

  expect_true(exists("test_list_forks"))
})

test_that("Getting forks gives the expected result", {

  mockery::stub(where = get_forks,
                what = "GET",
                how = r)

  mockery::stub(where = get_forks,
                what = "fromJSON",
                how = content_forks)

  value_forks <- get_forks(base_url, api_key, owner, repo)

  expect_equal(TRUE, !is.null(value_forks))
  expect_that(value_forks, is_a("data.frame"))
})
