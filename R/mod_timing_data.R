# Module UI

#' @title mod_timing_data_ui and mod_timing_data_server
#' @description A shiny module.

mod_timing_data_ui <- function(id) {
  require(plotly)
	ns <- NS(id)
	tabItem(
		tabName = "timing_data",
		fluidRow(
		  plotly::plotlyOutput(ns('stack_time'))
		)
	)
}

# Module Server

mod_timing_data_server <- function(input, output, session) {
	ns <- session$ns

	timing_data <- reactive({
	  dLoader()
	})

	output$stack_time <-
	    renderPlotly({
	    df <- timing_data()

	     p1 <- df %>%
	       ungroup() |>
	      select(date, contains('sum'), -grand_sum, -admin_sum) %>%
	      mutate(id = as.numeric(rownames(.))) %>%
	      select(-date) %>%
	      pivot_longer(-id) %>%
	      mutate(value = value/60,
	             name = gsub('_sum', '', name),
	             name = str_to_title(name)) %>%
	      ggplot(aes(fill=name , y=value, x=id)) +
	      geom_bar(position="stack", stat="identity") +
	      labs(y = 'Time (h)', x = 'Consecutive Day',
	           title = "Daily Time Allocation") +
	      theme_bw(base_size = 20) +
	      theme(legend.title = element_blank(),
	            plot.background = element_rect(fill = "#F8F8F8", color = "#F8F8F8"),
	            panel.background = element_rect(fill = "#F8F8F8", color = "#F8F8F8"),
	            panel.border = element_blank(),
	            legend.background = element_rect(fill = "#F8F8F8", color = "#F8F8F8")) +
	      scale_fill_manual(values = chart_cols[4:1])

	     dfPlot2 <- df%>%
	       ungroup |>
	       select(date, contains('sum'), -grand_sum, -admin_sum) %>%
	       mutate(id = as.numeric(rownames(.)))

	     dfPlot2 %>%
	       select(-date) %>%
	       pivot_longer(-id) %>%
	       mutate(value = round(value/60, 2),
	              name = gsub('_sum', '', name),
	              name = str_to_title(name)) %>%
	       left_join(dfPlot2 %>% select(id, date), by = 'id') %>%
	       plot_ly(x = ~id, y = ~value, color = ~name, colors = chart_cols[4:1],
	               text = ~date,
	              hovertemplate = paste(
	                "<b>Date:</b> %{text}<br>",
	                "<b>Consecutive Day:</b> %{x}<br>",
	                "<b>%{fullData.name}:</b> %{y} hours<br>"
	              )) %>%
	       add_bars() %>%
	       layout(barmode = "stack",
	              yaxis = list(title = 'Time (h)'),
	              xaxis = list(title = 'Consecutive Day'),
	              title = "Daily Time Allocation",
	              paper_bgcolor='transparent',
	              plot_bgcolor='rgb(248 248 248)',
	              margin = list(
	                l = 50,
	                r = 50,
	                b = 25,
	                t = 50,
	                pad = 4
	              ),
	              font=list(
	                size=18  # Set the font size here
	              ))
	  })
}

## copy to body.R
# mod_timing_data_ui("timing_data_ui_1")

## copy to app_server.R
# callModule(mod_timing_data_server, "timing_data_ui_1")

## copy to sidebar.R
# menuItem("displayName",tabName = "timing_data",icon = icon("user"))

