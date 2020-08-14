context("get org hook")


test_that("We get a error when there is no url", {
    expect_error(get_org_hook(api_key = api_key, org = org,
                                id_hook = id_hook), "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
    expect_error(get_org_hook(base_url = base_url, org = org,
                                id_hook = id_hook),
                   "Please add a valid API token")
})

test_that("We get a error when there is no name of organization", {
    expect_error(get_org_hook(base_url = base_url, api_key = api_key,
                                id_hook = id_hook),
                   "Please add a valid name of the organization")
})

test_that("We get a error when there is no id", {
    expect_error(get_org_hook(base_url = base_url, api_key = api_key,
                                org = org),
                   "Please add a id valid of hook")
})


test_that("Error putting invalid url for API", {

    mockery::stub(where = get_org_hook,
                  what = "tryCatch",
                  how = "Failure")

    expect_error(get_org_hook("google.com", api_key, org, id_hook),
                 "Error consulting the url: ")
})


