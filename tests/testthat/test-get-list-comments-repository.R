context("get list all comments in a repository")


test_that("We get a error when there is no url", {
    expect_error(get_list_comments_repository(api_key = api_key,
                                                owner = owner, repo = repo),
                   "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
    expect_error(get_list_comments_repository(base_url = base_url,
                                                owner = owner, repo = repo),
                   "Please add a valid API token")
})

test_that("We get a error when there is no owner", {
    expect_error(get_list_comments_repository(base_url = base_url,
                                                api_key = api_key, repo = repo),
                   "Please add a valid owner")
})

test_that("We get a error when there is no repository", {

    mockery::stub(where = get_list_comments_repository,
                  what = "tryCatch",
                  how = "Failure")

    expect_error(get_list_comments_repository(base_url = base_url,
                                                api_key = api_key,
                                                owner = owner),
                   "Please add a valid repository")
})

test_that("Error putting invalid url for API", {

    mockery::stub(where = get_list_comments_repository,
                  what = "tryCatch",
                  how = "Failure")

    expect_error(get_list_comments_repository("google.com",
                                              api_key,
                                              owner, repo),
                 "Error consulting the url: ")
})

test_that("The list all comments in a repository is read correctly", {

    mockery::stub(where = get_list_comments_repository,
                  what = "GET",
                  how = r)

    mockery::stub(where = get_list_comments_repository,
                  what = "fromJSON",
                  how = list_com_repository)

    test_list_comments_repository <- get_list_comments_repository(base_url,
                                                                  api_key,
                                                                  owner, repo)
    expect_true(exists("test_list_comments_repository"))
})

test_that("Obtaining issue comments gives the expected result", {

    mockery::stub(where = get_list_comments_repository,
                  what = "GET",
                  how = r)

    mockery::stub(where = get_list_comments_repository,
                  what = "fromJSON",
                  how = list_com_repository)

    value_list_comments_repository <- get_list_comments_repository(base_url,
                                                              api_key,
                                                              owner, repo)

    expect_equal(TRUE, !is.null(value_list_comments_repository))
    expect_that(value_list_comments_repository, is_a("data.frame"))
})
