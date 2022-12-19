# proj init & usethis utilties

## Create Common Files ----
## See ?usethis for more information
usethis::use_gpl3_license() # You can set another license here
usethis::use_readme_rmd(open = FALSE)
usethis::use_package_doc()

# Note that `contact` is required since usethis version 2.1.5
# If your {usethis} version is older, you can remove that param
# usethis::use_code_of_conduct(contact = "Su Na")
usethis::use_lifecycle_badge("Experimental")
usethis::use_news_md(open = FALSE)

## Use git ----
usethis::use_git()

## Init Testing Infrastructure ----
## Create a template for tests
usethis::use_testthat(3)
