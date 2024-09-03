body <- function() {
  dashboardBody(
    theme_dashboard(),
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css"),
      tags$script(src = "custom.js")
    ),
    tabItems(
      #Add ui module here (e.g., uiOne("one"))
      mod_dashboard_ui("dashboard_ui_1"),
      mod_timing_data_ui("timing_data_ui_1"),
      mod_long_survey_ui("long_survey_ui_1")
    )
  )
}
