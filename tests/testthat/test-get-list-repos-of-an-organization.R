context("get list an organization's repos")


test_that("We get a error when there is no url", {
    expect_error(get_list_repos_org(api_key = api_key, org = org),
                   "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
    expect_error(get_list_repos_org(base_url = base_url, org = org),
                   "Please add a valid API token")
})

test_that("We get a error when there is no name of organization", {
    expect_error(get_list_repos_org(base_url = base_url, api_key = api_key),
                   "Please add a valid name of the organization")
})

test_that("Error putting invalid url for API", {

    mockery::stub(where = get_list_repos_org,
                  what = "tryCatch",
                  how = "Failure")

    expect_error(get_list_repos_org("google.com", api_key, org),
                 "Error consulting the url: ")
})


test_that("The organization is read correctly", {

    mockery::stub(where = get_list_repos_org,
                  what = "GET",
                  how = r)

    mockery::stub(where = get_list_repos_org,
                  what = "fromJSON",
                  how = content_list_repos_org)

    test_lis_org_repos <- get_list_repos_org(base_url, api_key, org)
    expect_true(exists("test_lis_org_repos"))
})

test_that("Obtain a list of repositories of an org the expected result", {

    mockery::stub(where = get_list_repos_org,
                  what = "GET",
                  how = r)

    mockery::stub(where = get_list_repos_org,
                  what = "fromJSON",
                  how = content_list_repos_org)

    value_lis_repo <- get_list_repos_org(base_url, api_key, org)
    expect_equal(TRUE, !is.null(value_lis_repo))
    expect_that(value_lis_repo, is_a("data.frame"))
    expect_true(nrow(value_lis_repo) > 0)
})
