context("list gitea server users")


test_that("We get a error when there is no url", {
  expect_error(get_list_users(api_key = api_key),
                 "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
  expect_error(get_list_users(base_url = base_url),
                 "Please add a valid API token")
})

test_that("Error putting invalid url for API", {

  mockery::stub(where = get_list_users,
                what = "tryCatch",
                how = "Failure")

  expect_error(get_list_users("google.com", api_key),
               "Error consulting the url: ")
})


test_that("Users are read correctly", {

  mockery::stub(where = get_list_users,
                what = "GET",
                how = r)

  mockery::stub(where = get_list_users,
                what = "fromJSON",
                how = content_list_users)

  test_list_users <- get_list_users(base_url, api_key)
  expect_true(exists("test_list_users"))
})

test_that("Getting users gives the expected result", {

  mockery::stub(where = get_list_users,
                what = "GET",
                how = r)

  mockery::stub(where = get_list_users,
                what = "fromJSON",
                how = content_list_users)

  value_list_users <- get_list_users(base_url, api_key)
  expect_equal(TRUE, !is.null(value_list_users))
  expect_that(value_list_users, is_a("data.frame"))
})
