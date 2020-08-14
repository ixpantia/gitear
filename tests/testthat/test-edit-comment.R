context("edit a comment")


test_that("We get a error when there is no url", {
    expect_error(edit_comment(api_key = api_key, owner = owner, repo = repo,
                                id_comment = id_comment, body = body),
                   "Please add a valid URL")
})

test_that("We get a error when there is no api_key", {
    expect_error(edit_comment(base_url = base_url, owner = owner, repo = repo,
                                id_comment = id_comment, body = body),
                   "Please add a valid API token")
})

test_that("We get a error when there is no owner", {
    expect_error(edit_comment(base_url = base_url, api_key = api_key,
                                repo = repo, id_comment = id_comment,
                                body = body),
                   "Please add a valid owner")
})

test_that("We get a error when there is no repository", {
    expect_error(edit_comment(base_url = base_url, api_key = api_key,
                                owner = owner, id_comment = id_comment,
                                body = body),
                   "Please add a valid repository")
})

test_that("We get a error when there is no id comment", {
    expect_error(edit_comment(base_url = base_url, api_key = api_key,
                                owner = owner, repo = repo, body = body),
                   "Please add a id of the comment")
})

test_that("We get a error when there is no body", {
    expect_error(edit_comment(base_url = base_url, api_key = api_key,
                                owner = owner, repo = repo,
                                id_comment = id_comment),
                   "Please add a valid body")
})

test_that("Error putting invalid url for API", {

    mockery::stub(where = edit_comment,
                  what = "tryCatch",
                  how = "Failure")

    expect_error(edit_comment("google.com", api_key, owner, repo,
                              id_comment, body),
                 "Error consulting the url: ")
})

test_that("The add tracked times issues is read correctly", {

    mockery::stub(where = edit_comment,
                  what = "PATCH",
                  how = r)

    mockery::stub(where = edit_comment,
                  what = "fromJSON",
                  how = content_edited_comment)

    test_edit_comment <- edit_comment(base_url, api_key, owner, repo,
                                      id_comment, body)
    expect_true(exists("test_edit_comment"))
})

test_that("Edit a comment gives the expected result", {

    mockery::stub(where = edit_comment,
                  what = "PATCH",
                  how = r)

    mockery::stub(where = edit_comment,
                  what = "fromJSON",
                  how = content_edited_comment)

    value_edit_comment <- edit_comment(base_url, api_key, owner, repo,
                                       id_comment, body)

    expect_equal(TRUE, !is.null(value_edit_comment))
    expect_that(value_edit_comment, is_a("list"))
})
