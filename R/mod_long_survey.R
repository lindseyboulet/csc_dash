# Module UI

#' @title mod_long_survey_ui and mod_long_survey_server
#' @description A shiny module.

mod_long_survey_ui <- function(id) {
	ns <- NS(id)
	tabItem(
		tabName = "long_survey",
		fluidRow(
		  box(

		  )

		)
	)
}

# Module Server

mod_long_survey_server <- function(input, output, session) {
	ns <- session$ns
}

## copy to body.R
# mod_long_survey_ui("long_survey_ui_1")

## copy to app_server.R
# callModule(mod_long_survey_server, "long_survey_ui_1")

## copy to sidebar.R
# menuItem("displayName",tabName = "long_survey",icon = icon("user"))

