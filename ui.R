library(shiny)
library(shinydashboard)

shinyUI(fluidPage(
  
  sidebarLayout(
    sidebarPanel(
      leafletOutput("CountryMap", width = "100%", height = "100%")
    ),
    
    mainPanel(
    
    )
  )
))
