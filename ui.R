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
                  position: absolute;
            }
            #titlePanel {
                  background-color: white;
                  border: 2px solid;
                  border-radius: 5px;
                  position: absolute;
                  margin-left: 6vw;
                  margin-top: 1.5vh;
                  padding-left: 10px;
                  padding-right: 10px;
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
    ),
    div(
      id = "titlePanel",
      h1("SafeCycle"),
      h5("Select a bike rack near you to see how safe it is.")
    )
  )
   
))
