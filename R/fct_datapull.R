#' datapull
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd

datapull <- function(){

  options(
    # whenever there is one account token found, use the cached token
    gargle_oauth_email = TRUE,
    # specify auth tokens should be stored in a hidden directory ".secrets"
    gargle_oauth_cache = "./app_data/.secrets"
  )

  googledrive::drive_download('https://docs.google.com/spreadsheets/d/1I923v-a0BmSvYUzbs-ZSyYyB-KZweWHmcEvz7dqrYMw/edit#gid=0',
             './app_data/time_data/time.csv', overwrite = TRUE)
}
