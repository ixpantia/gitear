% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create-comment-issue.R
\name{create_comment_issue}
\alias{create_comment_issue}
\title{Add a comment to an issue}
\usage{
create_comment_issue(base_url, api_key, owner, repo, id_issue, body)
}
\arguments{
\item{base_url}{The base URL for your gitea server (no trailing '/')}

\item{api_key}{The user's API token key for the gitea service}

\item{owner}{The owner of the repository}

\item{repo}{The name of the repository}

\item{id_issue}{Index of the issue to create a comment}

\item{body}{The text that is added as a comment to the issue}
}
\description{
Add a comment to an issue in a gitea server
}
\examples{
\dontrun{
create_comment_issue(base_url = "https://example.gitea.service.com",
                     api_key = "ccaf5c9a22e854856d0c5b1b96c81e851bafb288",
                     owner = "company",
                     repo = "test_repo",
                     id_issue = 2,
                     body = "my first comment on this issue")
}
}
