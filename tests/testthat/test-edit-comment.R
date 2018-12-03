context("edit a comment")

# edit_comment
test_that("The connection to the test url gets a response", {
    skip_on_cran()
    
    base_url <- sub("/$", "", base_url)
    gitea_url <- file.path(base_url, "api/v1", sub("^/", "", "/repos"),
                           owner,repo,"issues/comments",id_comment)
    
    authorization <- paste("token", api_key)
    
    request_body <- as.list(data.frame(body = body))
    
    r <- PATCH(gitea_url, add_headers(Authorization = authorization),
               content_type_json(), encode = "json", body = request_body)
    
    expect_true(r$status_code %in% c(200, 403, 500))
})

test_that("We geta warning when there is no url", {
    expect_warning(edit_comment(api_key = api_key, owner = owner, repo = repo, 
                                id_comment = id_comment, body = body),
                   "Please add a valid URL")
})

test_that("We geta warning when there is no api_key", {
    expect_warning(edit_comment(base_url = base_url, owner = owner, repo = repo,
                                id_comment = id_comment, body = body),
                   "Please add a valid API token")
})

test_that("We geta warning when there is no owner", {
    expect_warning(edit_comment(base_url = base_url, api_key = api_key,
                                repo = repo, id_comment = id_comment,
                                body = body),
                   "Please add a valid owner")
})

test_that("We geta warning when there is no repository", {
    expect_warning(edit_comment(base_url = base_url, api_key = api_key,
                                owner = owner, id_comment = id_comment,
                                body = body),
                   "Please add a valid repository")
})

test_that("We geta warning when there is no id comment", {
    expect_warning(edit_comment(base_url = base_url, api_key = api_key,
                                owner = owner, repo = repo, body = body), 
                   "Please add a id of the comment")
})

test_that("We geta warning when there is no body", {
    expect_warning(edit_comment(base_url = base_url, api_key = api_key,
                                owner = owner, repo = repo,
                                id_comment = id_comment), 
                   "Please add a valid body")
})

test_that("The add tracked times issues is read correctly", {
    test_edit_comment <- edit_comment(base_url, api_key, owner, repo,
                                      id_comment, body)
    expect_true(exists("test_edit_comment"))
})

test_that("Edit a comment gives the expected result", {
    value_edit_comment <- edit_comment(base_url, api_key, owner, repo,
                                       id_comment, body)
    class(value_edit_comment)
    expect_equal(TRUE, !is.null(value_edit_comment))
    expect_that(value_edit_comment, is_a("list"))
})