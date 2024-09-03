
app_server <- function(input, output, session) {
  # pins::board_register() # connect to pin board if needed
  require(data.table)
  require(janitor)
  require(rlist)
  require(ggplot2)
  require(tidyr)
  require(stringr)
  require(shinydashboardPlus)
  require(highcharter)
  require(shinycssloaders)
  require(plotly)

  datapull()
  callModule(mod_timing_data_server, "timing_data_ui_1")
  callModule(mod_dashboard_server, "dashboard_ui_1")
  callModule(mod_long_survey_server, "long_survey_ui_1")
}
