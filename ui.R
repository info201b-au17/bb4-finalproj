library(shiny)
library(shinydashboard)
library(leaflet)
library(graphics)
library(googleVis)
library(shinyjs)

shinyUI(fluidPage(
  useShinyjs(),
  div(
    id = "loading_page",
    h1("Loading data, please wait...")
  ),
  hidden(
    div(
      id = "main_content",
      mainPanel(
        leafletOutput("CountryMap", width = "90vw", height = "90vh")
      )
    )
  )
   
))
