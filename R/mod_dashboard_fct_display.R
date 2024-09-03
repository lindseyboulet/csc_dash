#' Sparks plotting function
#'
#'
#'
#'
sparks <- function(hc1, pls){
  hc1 %>%
    hc_size(height = 100, width = 250) %>%
    hc_xAxis(title = list(text = ""),
             visible = FALSE) %>%
    hc_yAxis(title = list(text = ""),
             labels = list(enabled = FALSE),
             plotLines = list(list(value = round(pls,1),
                                   color = "black", width = 2,
                                   dashStyle = "shortdash")))
}

#' Custom value box
#'
#'
#'
#'
valueBox3 <- function(value, title, sparkobj = NULL, subtitle, icon = NULL,
                      color = "aqua", width = 4, href = NULL){
  shinydashboard:::validateColor(color)

  if (!is.null(icon))
    shinydashboard:::tagAssert(icon, type = "i")

  boxContent <- div(
    class = paste0("small-box bg-", color),
    div(
      class = "inner",
      # tags$h4(title),
      h4(tags$p(title, style = "color: white;")),
      div(class = "icon-large", icon, style = "z-index; 0"),
      h3(value),
      if (!is.null(sparkobj)) sparkobj,
      p(subtitle)
    ),
    # if (!is.null(icon)) div(class = "icon-large", icon, style = "z-index; 0")
  )

  if (!is.null(href))
    boxContent <- a(href = href, boxContent)

  div(
    class = if (!is.null(width)) paste0("col-sm-", width),
    boxContent
  )
}
