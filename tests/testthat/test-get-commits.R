context("get list all commits in a repository")


test_that("We get a error when there is no url", {
  expect_error(get_commits(api_key = api_key,
                                              owner = owner, repo = repo),
                 "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
  expect_error(get_commits(base_url = base_url,
                                              owner = owner, repo = repo),
                 "Please add a valid API token")
})

test_that("We get a error when there is no owner", {
  expect_error(get_commits(base_url = base_url,
                                              api_key = api_key, repo = repo),
                 "Please add a valid owner")
})

test_that("We get a error when there is no repository", {
  expect_error(get_commits(base_url = base_url,
                                              api_key = api_key,
                                              owner = owner),
                 "Please add a valid repository")
})

test_that("Error putting invalid url for API", {

  mockery::stub(where = get_commits,
                what = "tryCatch",
                how = "Failure")

  expect_error(get_commits("google.com", api_key, owner,
                           repo),
               "Error consulting the url: ")
})

test_that("The list all comments in a repository is read correctly", {

  mockery::stub(where = get_commits,
                what = "GET",
                how = r)

  mockery::stub(where = get_commits,
                what = "fromJSON",
                how = content_commits)

  test_list_commits_repository <- get_commits(base_url, api_key, owner, repo)
  expect_true(exists("test_list_commits_repository"))
})

test_that("Obtaining issue comments gives the expected result", {

  mockery::stub(where = get_commits,
                what = "GET",
                how = r)

  mockery::stub(where = get_commits,
                what = "fromJSON",
                how = content_commits)

  value_list_commits_repository <- get_commits(base_url, api_key, owner,
                                               repo)

  expect_equal(TRUE, !is.null(value_list_commits_repository))
  expect_that(value_list_commits_repository, is_a("data.frame"))
})
