context("get list an organization's webhooks")


test_that("We get a error when there is no url", {
    expect_error(get_org_list_hooks(api_key = api_key, org = org),
                   "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
    expect_error(get_org_list_hooks(base_url = base_url, org = org),
                   "Please add a valid API token")
})

test_that("We get a error when there is no name of organization", {
    expect_error(get_org_list_hooks(base_url = base_url, api_key = api_key),
                   "Please add a valid name of the organization")
})

test_that("Error putting invalid url for API", {

  mockery::stub(where = get_org_list_hooks,
                what = "tryCatch",
                how = "Failure")

    expect_error(get_org_list_hooks("google.com", api_key, org),
                 "Error consulting the url: ")
})

