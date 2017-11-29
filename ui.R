library(shiny)
library(shinydashboard)
library(leaflet)
library(graphics)
library(googleVis)

shinyUI(fluidPage(
  
    mainPanel(
      leafletOutput("CountryMap", width = "90vw", height = "90vh")
    )
))
