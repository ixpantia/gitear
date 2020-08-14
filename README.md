
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gitear <a href="https://ixpantia.github.io/gitear/"><img src="man/figures/gitear.png" align="right" width="30%"></a>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/gitear)](https://cran.r-project.org/package=gitear)
[![Travis build
status](https://travis-ci.org/ixpantia/gitear.svg?branch=master)](https://travis-ci.org/ixpantia/gitear)
[![Codecov test
coverage](https://codecov.io/gh/ixpantia/gitear/branch/master/graph/badge.svg)](https://codecov.io/gh/ixpantia/gitear?branch=master)
<!-- badges: end -->

The goal of gitear is to request your self-hosted Git service data and
import it to R in a tidy data frame.

`gitear` is a package that communicates with the
[gitea](https://gitea.io/en-us/) API.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("ixpantia/gitear")
```

## Usage

First go to your gitea self hosted service and grab your API Token. Then
you should be able to the following:

``` r
# Credentials

api_token <- "gfdsgfd8ba18a866bsdfgsdfgs3a2dc9303453b0c92dcfb19"
url_ixpantia <- "https://prueba.com"

# Example function use

issues <- get_issues(base_url = url_ixpantia,
                     api_key = api_token,
                     owner = "empresa",
                     repo = "repo_prueba")


issues
#>   number                      title created_date created_time updated_date
#> 1      3 Primer tiquete para prueba   2020-07-15     23:43:42   2020-07-24
#> 2      2 Primer tiquete para prueba   2020-07-15     23:12:37   2020-07-24
#>   updated_time             due_date author assignee
#> 1     14:41:47 2020-07-31T23:59:59Z   juan     juan
#> 2     14:41:37 2020-07-31T23:59:59Z   juan     juan
```

## **Environmental variables:**

In order to work with environmental variables to make your scripts safer
from somebody getting your credentials, you can follow the next
workflow:

1.  Create an .Renviron file with your credentials
2.  Restart your R session
3.  Store your credentials in an object for using it in your script

Your script could look something like this:

``` r
# Storing credentials in an object

example_key <- Sys.getenv("example_key")
example_url <- Sys.getenv("example_url")

# Using a function from gitear

issues <- get_issues(base_url = example_url,
                     api_key = example_key,
                     owner = "empresa",
                     repo = "repo_prueba")

# Check the output

glimpse(issues)
#> Rows: 2
#> Columns: 9
#> $ number       <int> 3, 2
#> $ title        <chr> "Primer tiquete para prueba", "Primer tiquete para pru...
#> $ created_date <chr> "2020-07-15", "2020-07-15"
#> $ created_time <chr> "23:43:42", "23:12:37"
#> $ updated_date <chr> "2020-07-24", "2020-07-24"
#> $ updated_time <chr> "14:41:47", "14:41:37"
#> $ due_date     <chr> "2020-07-31T23:59:59Z", "2020-07-31T23:59:59Z"
#> $ author       <chr> "juan", "juan"
#> $ assignee     <chr> "juan", "juan"
```
