# Building a Prod-Ready, Robust Shiny Application.
#
# README: each step of the dev files is optional, and you don't have to
# fill every dev scripts before getting started.
# 01_start.R should be filled at start.
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
#

# CURRENT FILE: DEV SCRIPT ----

# Engineering ----

## Dependencies ----

# Amend DESCRIPTION with dependencies read from package code parsing
# attachment::att_amend_desc()

usethis::use_package("rlang")
usethis::use_package("stringr")
usethis::use_package("dplyr")
usethis::use_package("tidyselect")
usethis::use_package("ggplot2")
usethis::use_package("tibble")
usethis::use_package("tidyr")
usethis::use_package("readr")
usethis::use_package("stringr")
usethis::use_package("purrr")
usethis::use_package("forcats")
usethis::use_package("vroom")
usethis::use_package("glue")
usethis::use_package("fs")
usethis::use_package("lubridate")

usethis::use_package("tidyjson")
usethis::use_package("furrr")
usethis::use_package("future")

usethis::use_package("rentrez")

## Add global imports

# these #' @importFrom will be in R/pkg-package.R
usethis::use_import_from("magrittr", "%>%")
usethis::use_import_from("rlang", "%||%")
usethis::use_import_from("glue", "glue")

## Add functions ----

# golem::add_fct("merge_fq", with_test = TRUE)
# golem::add_fct("fire_up_cmds", with_test = TRUE)
# golem::add_fct("organize_fastp_json", with_test = TRUE)

## Add internal datasets ----

# If you have data in your package
# usethis::use_data_raw(name = "internal_datasets", open = TRUE)

## Tests ----

# Add one line by test you want to create
# usethis::use_test("app")

# Documentation ----

## Vignette ----

# usethis::use_vignette("shinyAgile2")
# devtools::build_vignettes()

## Code Coverage----

# Set the code coverage service ("codecov" or "coveralls")
# usethis::use_coverage()

# Create a summary readme for the testthat subdirectory
# covrpage::covrpage()

## CI ----

# Use this part of the script if you need to set up a CI
# service for your application
#
# (You'll need GitHub there)
# usethis::use_github()

# GitHub Actions
# usethis::use_github_action()
# Chose one of the three
# See https://usethis.r-lib.org/reference/use_github_action.html
# usethis::use_github_action_check_release()
# usethis::use_github_action_check_standard()
# usethis::use_github_action_check_full()
# Add action for PR
# usethis::use_github_action_pr_commands()

# Travis CI
# usethis::use_travis()
# usethis::use_travis_badge()

# AppVeyor
# usethis::use_appveyor()
# usethis::use_appveyor_badge()

# Circle CI
# usethis::use_circleci()
# usethis::use_circleci_badge()

# Jenkins
# usethis::use_jenkins()

# GitLab CI
# usethis::use_gitlab_ci()
