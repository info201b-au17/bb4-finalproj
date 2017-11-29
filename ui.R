library(shiny)
library(shinydashboard)
library(leaflet)
library(graphics)
library(googleVis)
library(shinyjs)

shinyUI(fluidPage(
  useShinyjs(),
  inlineCSS("#loading_page { 
                  margin-left:50 wv; 
                  text-align:center; 
                  margin-top: 50vh; 
                  padding:0px}
            #main_content { 
                  padding:0px;
            }
            .container-fluid {
                  padding:0px;
            }"),
  div(
    id = "loading_page",
    h1("Loading data, please wait...")
  ),
  hidden(
    div(
      id = "main_content",
      leafletOutput("CountryMap", width = "100vw", height = "100vh")
    )
  )
   
))
