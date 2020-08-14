context("Get milestones")


test_that("We get a error when there is no url", {
  expect_error(get_milestones(api_key = api_key, owner = owner,
                            repo = repo),
                 "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
  expect_error(get_milestones(base_url = base_url, owner = owner,
                            repo = repo),
                 "Please add a valid API token")
})

test_that("We get a error when there is no owner", {
  expect_error(get_milestones(base_url = base_url, api_key = api_key,
                            repo = repo),
                 "Please add a valid owner")
})

test_that("We get a error when there is no repository", {
  expect_error(get_milestones(base_url = base_url, api_key = api_key,
                            owner = owner),
                 "Please add a valid repository")
})

test_that("Error putting invalid url for API", {

  mockery::stub(where = get_milestones,
                what = "tryCatch",
                how = "Failure")

  expect_error(get_milestones("google.com", api_key, owner, repo),
               "Error consulting the url: ")
})


test_that("Milestones are read correctly", {

  mockery::stub(where = get_milestones,
                what = "GET",
                how = r)

  mockery::stub(where = get_milestones,
                what = "fromJSON",
                how = content_milestones)

  test_list_milestones <- get_milestones(base_url, api_key, owner, repo)
  expect_true(exists("test_list_milestones"))
})

test_that("Getting milestones gives the expected result", {

  mockery::stub(where = get_milestones,
                what = "GET",
                how = r)

  mockery::stub(where = get_milestones,
                what = "fromJSON",
                how = content_milestones)

  value_milestones <- get_milestones(base_url, api_key, owner, repo)
  expect_equal(TRUE, !is.null(value_milestones))
  expect_that(value_milestones, is_a("data.frame"))
})
