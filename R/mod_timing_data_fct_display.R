#' Convert 24
#'
#'
#'
#'

weekdate <- function(date){
  library(lubridate)
  week_no <- week(date)
  year_no <- year(date)
  ymd(paste0(year_no, '-01-01')) + weeks(week_no)
}


#' Load Time Tracking Data
#'
#'
#'
#'
dLoader <- function(){
  df <- data.table::fread('./app_data/time_data/time.csv') |>
    janitor::clean_names() |>
    mutate(chart_start = mdy_hm(paste(date, chart_start)),
        chart_end = mdy_hm(paste(date, chart_end)),
        patient_start = mdy_hm(paste(date, patient_start)),
        patient_end  = mdy_hm(paste(date, patient_end )),
        dict_start  = mdy_hm(paste(date, dict_start )),
        dict_end = mdy_hm(paste(date, dict_end)),
        bill_start = mdy_hm(paste(date, bill_start)),
        bill_end = mdy_hm(paste(date, bill_end)),
        chart_time = as.numeric(difftime(chart_end, chart_start, units = 'mins')),
        patient_time = as.numeric(difftime(patient_end, patient_start, units = 'mins')),
        dict_time = as.numeric(difftime(dict_end, dict_start, units = 'mins')),
        bill_time = as.numeric(difftime(bill_end, bill_start, units = 'mins')),
        admin_time =  chart_time + dict_time + bill_time,
        total_per_patient =  chart_time + dict_time + bill_time + patient_time,
        week = weekdate(mdy(date)),
        date = mdy(date),
        trial = ifelse(date >= ymd('2024-08-12'), 'trial', 'baseline'))

df |>
    group_by(date, trial) |>
    summarise(
      chart_mean = mean(chart_time, na.rm = TRUE),
      patient_mean  = mean(patient_time, na.rm = TRUE),
      dict_mean  = mean(dict_time, na.rm = TRUE),
      bill_mean  = mean(bill_time, na.rm = TRUE),
      admin_mean = mean(admin_time, na.rm = TRUE),
      chart_sum = sum(chart_time, na.rm = TRUE),
      patient_sum  = sum(patient_time, na.rm = TRUE),
      dict_sum  = sum(dict_time, na.rm = TRUE),
      bill_sum  = sum(bill_time, na.rm = TRUE),
      admin_sum = sum(admin_time, na.rm = TRUE),
      grand_sum  = sum(total_per_patient, na.rm = TRUE))

}
#' Color palette for plots
#'
#'
#'

chart_cols <- c("#0F3B99", "#5886E9", "#FFC505", "#FF9705", "#A1D6FC",
                "#37CDC1", "#51CD37", "#FF5005", '#d4bbff')

