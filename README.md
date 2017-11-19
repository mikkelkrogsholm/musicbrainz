
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/musicbrainz)](http://cran.r-project.org/package=musicbrainz)

musicbrainz
===========

The goal of musicbrainz is to make it easy to call the MusicBrainz api from R.

Installation
------------

You can install musicbrainz from github with:

``` r
# install.packages("devtools")
devtools::install_github("mikkelkrogsholm/musicbrainz")
```

Example
-------

This is a basic example which shows you how to solve a common problem.

Lets find the Prince of Darkness in MusicBrainz

``` r
library(musicbrainz)

ozzy_search <- mb_search("artist", 'artist:"ozzy osbourne"')
```

We can then see Ozzys mbid

``` r
ozzy_search[["artists"]][[1]][["id"]]
#> [1] "8aa5b65a-5b3c-4029-92bf-47a544356934"
```

And if we have a mbid then we can call the lookup function with that id.

``` r
ozzy_lookup <- mb_lookup("artist", "8aa5b65a-5b3c-4029-92bf-47a544356934")
```
