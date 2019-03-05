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
| edit_comment | |
| edit_issue | |
| get_an_issue | |
| get_an_organization | |
| get_issues_closed_state | |
| get_issues_open_state | |
| get_label_issue | |
| get_list_org_teams | |
| get_list_comments_issue | |
| get_list_comments_repository | |
| get_list_org_members | |
| get_list_repos_org | |
| get_org_hook | |
| get_org_list_hooks | |
| get_organizations | | 
| get_repositories | |  
| get_times_issue | |
| get_version | |
| get_commits | |

## Getting help


