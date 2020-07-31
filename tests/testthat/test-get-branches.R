context("Get branches")


test_that("We get a error when there is no url", {
  expect_error(get_branches(api_key = api_key, owner = owner,
                                repo = repo),
                 "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
  expect_error(get_branches(base_url = base_url, owner = owner,
                                repo = repo),
                 "Please add a valid API token")
})

test_that("We get a error when there is no owner", {
  expect_error(get_branches(base_url = base_url, api_key = api_key,
                                repo = repo),
                 "Please add a valid owner")
})

test_that("We get a error when there is no repository", {
  expect_error(get_branches(base_url = base_url, api_key = api_key,
                                owner = owner),
                 "Please add a valid repository")
})

test_that("Error putting invalid url for API", {

  mockery::stub(where = get_branches,
                what = "tryCatch",
                how = "Failure")

  expect_error(get_branches("google.com", api_key, owner, repo),
               "Error consulting the url: ")
})

test_that("Branches are read correctly", {

  mockery::stub(where = get_branches,
                what = "GET",
                how = r)

  mockery::stub(where = get_branches,
                what = "fromJSON",
                how = content_branches)

  value_branches <- get_branches(base_url, api_key, owner, repo)
  expect_true(exists("value_branches"))
})

test_that("Getting branches gives the expected result", {
  mockery::stub(where = get_branches,
                what = "GET",
                how = r)

  mockery::stub(where = get_branches,
                what = "fromJSON",
                how = content_branches)

  value_branches <- get_branches(base_url, api_key, owner, repo)

  expect_equal(TRUE, !is.null(value_branches))
  expect_that(value_branches, is_a("data.frame"))
})
