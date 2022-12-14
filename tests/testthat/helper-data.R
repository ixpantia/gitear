base_url <- "https://prueba.com"
api_key <- "chd36492irfhsn9474"
owner <- "empresa"
repo <- "repo_prueba"
org <- "empresa"
id_org <- 8
id_hook <- 1
id_issue <- 2
title <- "Primer tiquete para prueba"
body <- "Este es el cuerpo del tiquete"
state <- "open"
time <- 12
id_comment <- 851

# response example

r <- readRDS(system.file("helper_data/response_example.RDS",
                              package = "gitear"))

# add tracked time issue

content_tracked_time <- jsonlite::fromJSON(system.file("helper_data/tracked_time.json",
                                   package = "gitear"))

# create comment issue

add_comment_issue <- jsonlite::fromJSON(system.file("helper_data/comment_issue.json",
                                             package = "gitear"))

# create issue

content_create_issue <- jsonlite::fromJSON(system.file("helper_data/create_issue.json",
                                          package = "gitear"))

# edit comment

content_edited_comment <- jsonlite::fromJSON(system.file("helper_data/edit_comment.json",
                                             package = "gitear"))

# edit issue

content_edit_issue <- jsonlite::fromJSON(system.file("helper_data/edit_issue.json",
                                           package = "gitear"))

# get an organization


content_an_organization <- jsonlite::fromJSON(system.file("helper_data/get_an_org.json",
                                                package = "gitear"))

# get branches

content_branches <- jsonlite::fromJSON(system.file("helper_data/get_branches.json",
                                         package = "gitear"))

#get commits

content_commits <- jsonlite::fromJSON(system.file("helper_data/get_commits.json",
                                        package = "gitear"))

# get forks

content_forks <- jsonlite::fromJSON(system.file("helper_data/get_forks.json",
                                      package = "gitear"))

# get issues

content_issues <- jsonlite::fromJSON(system.file("helper_data/get_issues.json",
                                      package = "gitear"))

# get label issues

content_label_issue <- jsonlite::fromJSON(system.file("helper_data/get_label_issue.json",
                                            package = "gitear"))

# organization teams

cont_list_an_org_teams <- jsonlite::fromJSON(system.file("helper_data/get_org_teams.json",
                                               package = "gitear"))

# comments issues

content_list_comments_issue <- jsonlite::fromJSON(system.file("helper_data/get_comments_issue.json",
                                                    package = "gitear"))

# comments repository

list_com_repository <- jsonlite::fromJSON(system.file("helper_data/get_comments_repo.json",
                                             package = "gitear"))

# organization members

content_list_org_members <- jsonlite::fromJSON(system.file("helper_data/get_org_members.json",
                                                 package = "gitear"))

# repositories of a organization

content_list_repos_org <- jsonlite::fromJSON(system.file("helper_data/get_repos_org.json",
                                               package = "gitear"))

# list users

content_list_users <- jsonlite::fromJSON(system.file("helper_data/get_users.json",
                                           package = "gitear"))

# milestones

content_milestones <- jsonlite::fromJSON(system.file("helper_data/get_milestones.json",
                                           package = "gitear"))

# organizations

content_organizations <- jsonlite::fromJSON(system.file("helper_data/get_organizations.json",
                                              package = "gitear"))

# pull requests

content_pull_req <- jsonlite::fromJSON(system.file("helper_data/get_pull_request.json",
                                         package = "gitear"))

# releases

content_releases <- jsonlite::fromJSON(system.file("helper_data/get_releases.json",
                                         package = "gitear"))

# repositories

content_repositories <- jsonlite::fromJSON(system.file("helper_data/get_repositories.json",
                                             package = "gitear"))

# issue times

content_issue_times <- jsonlite::fromJSON(system.file("helper_data/get_issue_times.json",
                                            package = "gitear"))

# version gitea

content_version <- jsonlite::fromJSON(system.file("helper_data/get_version.json",
                                        package = "gitear"))

