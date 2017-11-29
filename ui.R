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
                  margin-top: 40vh; 
                  padding:0px;
                  background: none;
            }
            #main_content { 
                  padding:0px;
            }
            .container-fluid {
                  padding:0px;
            }"),
  div(
    id = "loading_page",
    h1("Loading data, please allow 10 seconds for startup...")
  ),
  hidden(
    div(
      id = "main_content",
      leafletOutput("CountryMap", width = "100vw", height = "100vh")
    )
  )
   
))
