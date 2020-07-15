context("list gitea server users")

test_that("The connection to the test url gets a response", {
  skip_on_cran()

  base_url <- sub("/$", "", base_url)
  gitea_url <- file.path(base_url, "api/v1", "users/search")

  authorization <- paste("token", api_key)
  r <- GET(gitea_url, add_headers(Authorization = authorization),
           accept_json())

  expect_true(r$status_code %in% c(200, 403, 500))
})

test_that("We get a error when there is no url", {
  expect_error(get_list_users(api_key = api_key),
                 "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
  expect_error(get_list_users(base_url = base_url),
                 "Please add a valid API token")
})


test_that("Users are read correctly", {
  test_list_org_memb <- get_list_users(base_url, api_key)
  expect_true(exists("test_list_org_memb"))
})

test_that("Getting users gives the expected result", {
  value_list_users <- get_list_users(base_url, api_key)
  expect_equal(TRUE, !is.null(value_list_users))
  expect_that(value_list_users, is_a("data.frame"))
})
