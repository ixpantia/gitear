context("list an organization's members")


test_that("We get a error when there is no url", {
    expect_error(get_list_org_members(api_key = api_key, org = org),
                   "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
    expect_error(get_list_org_members(base_url = base_url, org = org),
                   "Please add a valid API token")
})

test_that("We get a error when there is no name of organization", {
    expect_error(get_list_org_members(base_url = base_url, api_key = api_key),
                   "Please add a valid name of the organization")
})

test_that("Error putting invalid url for API", {

    mockery::stub(where = get_list_org_members,
                  what = "tryCatch",
                  how = "Failure")

    expect_error(get_list_org_members("google.com", api_key, org),
                 "Error consulting the url: ")
})

test_that("The organization is read correctly", {

    mockery::stub(where = get_list_org_members,
                  what = "GET",
                  how = r)

    mockery::stub(where = get_list_org_members,
                  what = "fromJSON",
                  how = content_list_org_members)

    test_list_org_memb <- get_list_org_members(base_url, api_key, org)
    expect_true(exists("test_list_org_memb"))
})

test_that("Obtaining an organization gives the expected result", {

    mockery::stub(where = get_list_org_members,
                  what = "GET",
                  how = r)

    mockery::stub(where = get_list_org_members,
                  what = "fromJSON",
                  how = content_list_org_members)

    value_list_org_memb <- get_list_org_members(base_url, api_key, org)
    expect_equal(TRUE, !is.null(value_list_org_memb))
    expect_that(value_list_org_memb, is_a("data.frame"))
})
