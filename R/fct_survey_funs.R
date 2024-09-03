#' survey_funs
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd

survey_data_formatter <- function(){
  options(
    # whenever there is one account token found, use the cached token
    gargle_oauth_email = TRUE,
    # specify auth tokens should be stored in a hidden directory ".secrets"
    gargle_oauth_cache = "./app_data/.secrets"
  )
  library(googlesheets4)
  library(plyr)
  library(dplyr)
  read_sheet('https://docs.google.com/spreadsheets/d/1V1b6-7YElXFuvsTR5kf58gtDCCXNNy0b-OII86-bs50/edit?gid=0#gid=0',
             sheet = 1, col_types = c('c'))
}

room_layout_sentiment <- function(df){
  library(SentimentAnalysis)
  sentiment <- analyzeSentiment(df$room_layout)

  # Extract dictionary-based sentiment according to the QDAP dictionary
  sentiment$SentimentQDAP
  df$room_sent<- convertToDirection(sentiment$SentimentQDAP)
  ggplot(df) + geom_bar(aes(x = room_sent))
}

room_layout_wordcloud <- function(df){
  library("quanteda")
  library("quanteda.textplots")

  dfmat_inaug <- corpus_subset(corpus(df$room_layout)) |>
    tokens(remove_punct = TRUE) |>
    tokens_remove(pattern = stopwords('english')) |>
    dfm() |>
    dfm_trim(min_termfreq = 1, verbose = FALSE)
  cols <- as.numeric(df$room_sent)
  cols[cols == 1] <- 'red'
  cols[cols == 2] <- 'grey'
  cols[cols == 3] <- 'green'
  textplot_wordcloud(dfmat_inaug, max_size = 45, color = cols)
}


