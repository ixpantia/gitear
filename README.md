# gitear

<a href="url"><img src="gitear.png" align="right" width="30%"></a>

# Overview

gitear is a package that communicates with the [gitea](https://gitea.io/en-us/) API. 
It makes posible to request your self-hosted Git service data and import it to R in a tidy data frame. 

## Installation

For the installation of the development version, you can install gitear from github:

```
devtools::install_github("ixpantia/gitear")
```

## Usage

With gitear you have a set of functions to request your data from the gitea API and also to edit issues.

| Function | Output |
| -------- | ------ |
| add_tracked_time_issue | |
| create_comment_issue | A table with the columns: id, html_url, pull_request_url, issue_url, user.id, user.login, user.full_name, user.email, user.avatar_url, user.language, user.username, body, created_at, updated_at|
| create_issue | A list with $id, $url, $number, $user, $title, $body, $labels, $milestone, $assignee, $assignees, $state, $comments, $created_at, $updated_at, $closed_at, $due_date, $pull_request|
| edit_comment | A list containing $id, $html_url, $pull_request_url, $issue_url, $user, $body, $created_at, $updated_at |
| edit_issue | A list containing $id, $url, $number, $user, $title, $body, $labels, $milestone, $assignee, $assignees, $state, $comments, $created_at, $updated_at, $closed_at, $due_date, $pull_request |
| get_an_issue | |
| get_an_organization | A dataframe with the variables id, username, full_name, avatar_url, description, website, location|
| get_issues_closed_state | A dataframe containing id, url, number, title, body, labels, milestones, assignees, state, comments, created_at, updated_at, closed_at, due_date, pull_request, user.id, user.login, user.full_name, user.email, user.avatar_url, user.language, user.username, assignee.id, assignee.login, assignee.full_name, asignee.email, assignee.avatar_url, assignee.language, assignee.username |
| get_issues_open_state | A dataframe containing id, url, number, title, body, labels, milestones, assignees, state, comments, created_at, updated_at, closed_at, due_date, pull_request, user.id, user.login, user.full_name, user.email, user.avatar_url, user.language, user.username, assignee.id, assignee.login, assignee.full_name, asignee.email, assignee.avatar_url, assignee.language, assignee.username|
| get_label_issue | A dataframe with one variable: content_label_issue |
| get_list_org_teams | Dataframe with id, name, description, permission and units |
| get_list_comments_issue | A dataframe containing id, html_url, pull_request_url, issue_url, user, body, created_at, updated_at |
| get_list_comments_repository | A dataframe containing id, html_url, pull_request_url, issue_url, user, body, created_at, updated_at |
| get_list_org_members | A dataframe with id, login, full_name, email, avatar_url, language, username |
| get_list_repos_org | |
| get_org_hook | |
| get_org_list_hooks | |
| get_organizations | | 
| get_repositories | |  
| get_times_issue | |
| get_version | |
| get_commits | |

## Getting help


