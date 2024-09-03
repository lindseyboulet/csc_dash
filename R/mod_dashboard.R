# Module UI

#' @title mod_dashboard_ui and mod_dashboard_server
#' @description A shiny module.

mod_dashboard_ui <- function(id) {
	ns <- NS(id)
	tabItem(
		tabName = "dashboard",
		fluidRow(
		  uiOutput(ns('outcome_cards')),
		  # %>%
		    # withSpinner(
		      # color="#00e272",
		      # proxy.height = 240
		    # ),
		  style = 'border-bottom: 1px solid; border-bottom-color: #EDEDED;'
		)
	)
}

# Module Server

mod_dashboard_server <- function(input, output, session) {
	ns <- session$ns

	output$outcome_cards <-
	  renderUI({
	    dfOut <- dLoader()
	    dfOut <- dfOut %>%
	      mutate(patient_sum_hrs = round(patient_sum/60,1),
	             chart_sum_hrs = round(chart_sum/60,1),
	             dictation_sum_hrs = round(dict_sum/60,1),
	             billing_sum_hrs = round(bill_sum/60,1),
	             date = ymd(date),
	             patadratio = round(patient_sum/(chart_sum + dict_sum + bill_sum), 2))
	    dfOut <- dfOut %>% ungroup |> dplyr::mutate(Day = rownames(dfOut))

	    sl1 <- mean(dfOut$patient_sum_hrs[dfOut$trial == 'baseline'], na.rm = TRUE)
	    hc1 <- hchart(dfOut, type = 'line',
	                  hcaes(Day, patient_sum_hrs), name = "Time (hours)",
	                  color = chart_cols[1])  %>%
	      sparks(pls = sl1)

	    sl2 <- mean(dfOut$chart_sum[dfOut$trial == 'baseline'], na.rm = TRUE)
	    hc2 <- hchart(dfOut, "line", hcaes(Day, chart_sum), name = "Time (mins)",
	                  color = chart_cols[2])  %>%
	      sparks(pls = sl2)

	    sl3 <- mean(dfOut$dict_sum[dfOut$trial == 'baseline'], na.rm = TRUE)
	    hc3 <- hchart(dfOut, "line", hcaes(Day, dict_sum ), name = "Time (mins)",
	                  color = chart_cols[3])  %>%
	      sparks(pls = sl3)

	    sl4 <- mean(dfOut$bill_sum[dfOut$trial == 'baseline'], na.rm = TRUE)
	    hc4 <- hchart(dfOut, "line", hcaes(Day, bill_sum ), name = "Time (mins)",
	                  color = chart_cols[4])  %>%
	      sparks(pls = sl4)

	    sl5 <- mean(dfOut$patadratio[dfOut$trial == 'baseline'], na.rm = TRUE)
	    hc5 <- hchart(dfOut, "line", hcaes(Day, patadratio ), name = "Time (mins)",
	                  color = chart_cols[7])  %>%
	    sparks(pls = sl5)

	    sl6 <- mean(dfOut$admin_sum[dfOut$trial == 'baseline'], na.rm = TRUE)
	    hc6 <- hchart(dfOut, "line", hcaes(Day, admin_sum ), name = "Time (mins)",
	                  color = chart_cols[9])  %>%
	      sparks(pls = sl6)

	    div(
	      fluidRow(
	      column(width = 4,
	             valueBox3(
	               value = paste0(round(mean(dfOut$patient_sum_hrs[dfOut$trial == 'trial'],na.rm = TRUE), 1), ' hrs'),
	               title = paste0("Daily Patient Time (", round(sl1, 1), " hrs)"),
	               sparkobj = hc1,
	               subtitle = "",
	               icon = icon("hospital-user"),
	               width = 12,
	               color = "blue",
	               href = NULL)
	      ),
	      column(width = 4,
	             valueBox3(
	               value = paste0(round(mean(dfOut$admin_sum[dfOut$trial == 'trial'],na.rm = TRUE), 1), ' mins'),
	               title = paste0("Daily Admin Time (", round(sl6, 1), " mins)"),
	               sparkobj = hc6,
	               subtitle = "",
	               icon = icon("folder-open"),
	               width = 12,
	               color = "purple",
	               href = NULL)
	      ),
	      column(width = 4,
	             valueBox3(
	               value = paste0(round(mean(dfOut$chart_sum[dfOut$trial == 'trial'],na.rm = TRUE), 1), ' mins'),
	               title = paste0("Daily Chart Time (", round(sl2, 1), " mins)"),
	               sparkobj = hc2,
	               subtitle = "",
	               icon = icon("clipboard"),
	               width = 12,
	               color = "aqua",
	               href = NULL)
	      ),
	      column(width = 4,
	             valueBox3(
	               value = paste0(round(mean(dfOut$dict_sum[dfOut$trial == 'trial'],na.rm = TRUE), 1), ' mins'),
	               title = paste0("Daily Dictation Time (", round(sl3, 1), " mins)"),
	               sparkobj = hc3,
	               subtitle = "",
	               icon = icon("comment"),
	               width = 12,
	               color = "yellow",
	               href = NULL)
	      ),
	      column(width = 4,
	             valueBox3(
	               value =  paste0(round(mean(dfOut$bill_sum[dfOut$trial == 'trial'],na.rm = TRUE), 1), ' mins'),
	               title = paste0("Daily Bill Time (", round(sl4, 1), " mins)"),
	               sparkobj = hc4,
	               subtitle = "",
	               icon = icon("file-invoice-dollar"),
	               width = 12,
	               color = "red",
	               href = NULL)
	      ),

	      column(width = 4,
	       valueBox3(
	         value =  paste0(round(mean(dfOut$patadratio[dfOut$trial == 'trial'],na.rm = TRUE), 1)),
	         title = paste0("Patient to Admin Ratio  (", round(sl5, 1), ")"),
	         sparkobj = hc5,
	         subtitle = "",
	         icon = icon("divide"),
	         width = 12,
	         color = "green",
	         href = NULL)
	      )
	      ),
	      fluidRow(
	        column(8, offset = 1,
	               h4("Notes"),
	               h5("Small number by title is baseline average."),
	               h5("Large number is trial average."),
	               h5('Admin time includes chart, dictation and billing time.')
	        )
	      )
	    )
	  })


}

## copy to body.R
# mod_dashboard_ui("dashboard_ui_1")

## copy to app_server.R
# callModule(mod_dashboard_server, "dashboard_ui_1")

## copy to sidebar.R
# menuItem("displayName",tabName = "dashboard",icon = icon("user"))

