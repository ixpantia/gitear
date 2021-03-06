% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get-list-organization-members.R
\name{get_list_org_members}
\alias{get_list_org_members}
\title{Returns organization's members}
\usage{
get_list_org_members(base_url, api_key, org)
}
\arguments{
\item{base_url}{The base URL for your gitea server (no trailing '/')}

\item{api_key}{The user's API token key for the gitea service}

\item{org}{Name of the organization}
}
\description{
List an organization's members
}
\examples{
\dontrun{
get_list_org_members(base_url = "https://example.gitea.service.com",
                     api_key = "ccaf5c9a22e854856d0c5b1b96c81e851bafb288",
                     org = "company")
}
}
