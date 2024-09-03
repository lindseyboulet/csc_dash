sidebar <- function() {
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard",tabName = "dashboard",icon = icon("gauge")),
      menuItem("Time Tracking",tabName = "timing_data",icon = icon("stopwatch")),
      menuItem("Survey Data",tabName = "long_survey",icon = icon("square-poll-vertical"))
    )
  )
}
