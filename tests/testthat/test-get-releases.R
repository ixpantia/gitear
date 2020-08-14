context("Get releases")


test_that("We get a error when there is no url", {
  expect_error(get_releases(api_key = api_key, owner = owner,
                                repo = repo),
                 "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
  expect_error(get_releases(base_url = base_url, owner = owner,
                                repo = repo),
                 "Please add a valid API token")
})

test_that("We get a error when there is no owner", {
  expect_error(get_releases(base_url = base_url, api_key = api_key,
                                repo = repo),
                 "Please add a valid owner")
})

test_that("We get a error when there is no repository", {
  expect_error(get_releases(base_url = base_url, api_key = api_key,
                                owner = owner),
                 "Please add a valid repository")
})

test_that("Error putting invalid url for API", {

  mockery::stub(where = get_releases,
                what = "tryCatch",
                how = "Failure")

  expect_error(get_releases("google.com", api_key, owner, repo),
               "Error consulting the url: ")
})


test_that("releases are read correctly", {

  mockery::stub(where = get_releases,
                what = "GET",
                how = r)

  mockery::stub(where = get_releases,
                what = "fromJSON",
                how = content_releases)

  test_list_releases <- get_releases(base_url, api_key, owner, repo)
  expect_true(exists("test_list_releases"))
})

test_that("Getting releases gives the expected result", {

  mockery::stub(where =get_releases,
                what = "GET",
                how = r)

  mockery::stub(where = get_releases,
                what = "fromJSON",
                how = content_releases)

  value_releases <- get_releases(base_url, api_key, owner, repo)

  expect_equal(TRUE, !is.null(value_releases))
  expect_that(value_releases, is_a("data.frame"))
})
