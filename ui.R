library(shiny)
library(shinydashboard)
library(leaflet)
library(graphics)
library(googleVis)
library(shinyjs)

# UI
shinyUI(fluidPage(
  # Starts up shinyjs
  useShinyjs(),
  
  # Adds CSS to specified elements
  inlineCSS("#loading_page { 
                  width: 100vw;
                  text-align:center; 
                  margin-top: 40vh; 
                  padding:0px;
                  background: none;
                  position: absolute;
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
                  padding-bottom: 5px;
            }
            .container-fluid {
                  padding:0px;
            }"),
  
  # Creates a div that displays the string inside the h1 tag below
  div(
    id = "loading_page",
    h1("Loading data, please allow 10 seconds for startup...")
  ),
  
  # Initially hidden tags
  hidden(
    
    # Creates a div that displays the map inside it
    div(
      id = "main_content",
      leafletOutput("CountryMap", width = "100vw", height = "100vh")
    ),
    
    # Creates a div that makes the title, subtext, and update button appear.
    div(
      id = "titlePanel",
      h1("Seattle SafeCycle"),
      h5("Select a bike rack near you to see how safe it is."),
      actionButton("updateDataButton", "Update/Refresh Data (allow time to update)"),
      textOutput("consoleMessage")
    )
  )
   
))
