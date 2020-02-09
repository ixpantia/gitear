
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gitear <a href="url"><img src="img/gitear.png" align="right" width="30%"></a>

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
library(gitear)

## Credentials
api_token <- "gfdsgfd8ba18a866bsdfgsdfgs3a2dc9303453b0c92dcfb19"
url_ixpantia <- "https://secure.ixpantia.com"

## Example function use:
issues <- get_issues(base_url = url_ixpantia,
                       api_key = api_token,
                       owner = "ixpantia",
                       repo = "ixmandash")
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
                     owner = "ixpantia",
                     repo = "lacrmr")

# Check the output
glimpse(issues)
#> Observations: 4
#> Variables: 9
#> $ number       <int> 38, 26, 24, 15
#> $ title        <chr> "lacrmr dejó de funcionar porque llave está deshabilitad…
#> $ created_date <chr> "2020-01-25", "2019-05-03", "2019-05-03", "2019-02-07"
#> $ created_time <chr> "00:45:48", "22:28:41", "21:28:00", "19:55:19"
#> $ updated_date <chr> "2020-01-25", "2020-01-24", "2019-05-03", "2020-01-24"
#> $ updated_time <chr> "00:45:52", "22:03:13", "21:28:14", "22:03:23"
#> $ due_date     <lgl> NA, NA, NA, NA
#> $ author       <chr> "ronny", "ronny", "ronny", "ronny"
#> $ assignee     <chr> "ronny", "ronny", "ronny", "ronny"
```
