library(shiny)
library(shinydashboard)
library(leaflet)
library(graphics)
library(googleVis)

shinyUI(fluidPage(
  
  sidebarLayout(
    sidebarPanel(
      
    ),
    
    mainPanel(
      leafletOutput("CountryMap", width = "100%", height = "500px")
    )
  )
))
