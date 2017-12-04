# Import libraries
library(shiny)
library(dplyr)
library(leaflet)
library(shinydashboard)
library(graphics)
library(googleVis)
library(shinyjs)

# Get data from API
# source(data/apiLinks.R)
# bikeTheftData <- bikeTheftDataset()
# bikeRackData <- bikeRackDataset()

# Get data updating function
source("loadData.R")
bikeRackData <- read.csv("data/testDatasets/bike_racks.csv")
loadInData <- function() {
  bikeRackData <- read.csv("data/testDatasets/bike_racks.csv")
}

# set up constants to be used later
startLongitude <- -122.329
startLatitude <- 47.6036
startZoom <- 15
weightOfCircles <- 1
radiusOfCircles <- 30

# Loading page message function code, sourced from Dean Attali on stack overflow
# Uses shinyjs library for showing and hiding certain elements
# Hides loading message after everything is shown already
load_data <- function(input, output) {
  show("main_content")
  loadInData()
  # Create the leaflet map, add all bike rack points, add pop up window text.
  output$CountryMap <- renderLeaflet({
    leaflet() %>% addTiles() %>% addProviderTiles("Esri.WorldStreetMap") %>%
      setView(lng = startLongitude, lat = startLatitude, zoom = startZoom) %>%
      addCircles(lng = as.numeric(bikeRackData$LONGITUDE), 
                 lat = as.numeric(bikeRackData$LATITUDE), 
                 weight = weightOfCircles, 
                 radius = radiusOfCircles, 
                 popup = paste0("<strong>Danger Level: ",bikeRackData$SAFETY_RATING,"</strong><br />
                                <progress style='width: 100%' value='",
                                bikeRackData$THEFTCOUNT,
                                "' max='",
                                max(bikeRackData$THEFTCOUNT),
                                "'></progress><br />
                                <p>In the past two years, a total of ", 
                                bikeRackData$THEFTCOUNT, " bicycle thefts have been reported within about 
                                two blocks from this bike rack.</p>
                                <p><a href='https://www.google.com/maps?q=&layer=c&cbll=",bikeRackData$LATITUDE,",",
                                bikeRackData$LONGITUDE,"' target='_blank'>Google Street View</a><br />
                                Latitude: ",bikeRackData$LATITUDE,
                                "<br />Longitude: ",bikeRackData$LONGITUDE,"</p>
                                <p>Reported condition of bike rack: ", bikeRackData$CONDITION, "</p>"), 
                 color = paste(bikeRackData$DOT_COLOR), 
                 fillOpacity = 1.0) 
  })
  hide("loading_page")
  show("titlePanel")
}

# Server scripts
shinyServer(function(input, output, session) {
  
  
  # Loading data message
  load_data(input, output)
  
  # Button to manually update data and then display the message once it is updated.
  observeEvent(input$updateDataButton, {
    output$consoleMessage <- renderText({
      "Updating data. Please wait..."
    })
    updateData()
    loadInData()
    output$consoleMessage <- renderText({
      "Data updated, refreshing page"
    })
    Sys.sleep(2)
    load_data(input, output)
    output$consoleMessage <- renderText({
      "Data updated"
    })
  })
  
  
})
