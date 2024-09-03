# time_data_formatter <- function(){
#
#   # library(googlesheets4)
#   library(plyr)
#   library(dplyr)
#   library(readxl)
#   library(lubridate)
#   library(googlesheets4)
#
#   dList <-
#     lapply(2:13,
#            function(x)
#              read_xlsx('./app_data/time_data/2024 Patient Care Time Tracker.xlsx',
#                        sheet = x, col_types = c('text')))
#   dList <- dList[which(!sapply(dList, is.null))]
#   dList <- dList[sapply(dList, nrow) > 0]
#   month_adjuster <- function(df){
#     mo_year <-as.Date(as.numeric(colnames(df)[1]), origin = "1899-12-30")
#     print(mo_year)
#     strtind <- which(apply(df, 2, function(x)sum(as.numeric(x),na.rm = TRUE)>0))
#     cnames <- c('patient', 'chart_start', 'chart_end', 'chart_total', 'patient_start',
#                 'patient_end', 'patient_total', 'dict_start', 'dict_end', 'dict_total',
#                 'bill_start', 'bill_end', 'bill_total', 'total_perpatient')
#     df1 <-  bind_rows(
#       df[,strtind[1]:(strtind[1]+13)] %>% setNames(cnames),
#       df[,strtind[2]:(strtind[2]+13)] %>% setNames(cnames),
#       df[,strtind[3]:(strtind[3]+13)] %>% setNames(cnames))
#     cs <- which(as.numeric(df1[[1]])==1)-3
#     cs <- c(cs, cs[length(cs)]+19)
#     brList <- split(df1, cumsum(1:nrow(df1) %in% cs))
#     brList <- brList[sapply(brList, nrow) < 30]
#
#
#     add_dates <- function(x, mo_year){
#       x$mo_year <- mo_year
#       x$date <-  as.Date(as.numeric(x$chart_start[1]), origin = "1899-12-30")
#       x
#     }
#     dfOut <- ldply(brList, add_dates, mo_year)
#
#     dfOut <- dfOut %>%
#       select(-.id)
#     dfOut <- dfOut %>%
#       filter(!is.na(as.numeric(dfOut[[1]])),
#              !is.na(chart_start))
#     dfOut
#   }
#
#   df <- ldply(dList, month_adjuster)
#   df <-
#     df %>%
#     mutate(mo_year = ym(format(date, format = "%Y-%m")))
#   write.csv(df, './app_data/time_data/time.csv')
#
#   write_sheet(df, 'https://docs.google.com/spreadsheets/d/1I923v-a0BmSvYUzbs-ZSyYyB-KZweWHmcEvz7dqrYMw/edit#gid=0',
#               sheet = 1)
# }
# # time_data_formatter()
