context("list an organization's teams")


test_that("We get a error when there is no url", {
    expect_error(get_list_org_teams(api_key = api_key, org = org),
                   "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
    expect_error(get_list_org_teams(base_url = base_url, org = org),
                   "Please add a valid API token")
})

test_that("We get a error when there is no name of organization", {
    expect_error(get_list_org_teams(base_url = base_url, api_key = api_key),
                   "Please add a valid name of the organization")
})

test_that("Error putting invalid url for API", {

    mockery::stub(where = get_list_org_teams,
                  what = "tryCatch",
                  how = "Failure")

    expect_error(get_list_org_teams("google.com", api_key, org),
                 "Error consulting the url: ")
})

test_that("The list an organization's teams is read correctly", {

    mockery::stub(where = get_list_org_teams,
                  what = "GET",
                  how = r)

    mockery::stub(where = get_list_org_teams,
                  what = "fromJSON",
                  how = cont_list_an_org_teams)

    test_list_org_teams <- get_list_org_teams(base_url, api_key, org)
    expect_true(exists("test_list_org_teams"))
})

test_that("Obtaining list an organization's teams gives the expected result", {

    mockery::stub(where = get_list_org_teams,
                  what = "GET",
                  how = r)

    mockery::stub(where = get_list_org_teams,
                  what = "fromJSON",
                  how = cont_list_an_org_teams)

    value_list_org_teams <- get_list_org_teams(base_url, api_key, org)

    expect_equal(TRUE, !is.null(value_list_org_teams))
    expect_that(value_list_org_teams, is_a("data.frame"))
})
