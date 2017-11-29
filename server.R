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

# set constants
startLongitude <- -122.3129
startLatitude <- 47.6563
startZoom <- 17
weightOfCircles <- 1
radiusOfCircles <- 10

# Loading page message function code, sourced from Dean Attali on stack overflow
load_data <- function() {
  show("main_content")
  Sys.sleep(4)
  hide("loading_page")
  show("titlePanel")
}


shinyServer(function(input, output, session) {
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
                                bikeRackData$LONGITUDE,"'>Google Street View</a><br />
                                Latitude: ",bikeRackData$LATITUDE,
                                "<br />Longitude: ",bikeRackData$LONGITUDE,"</p>
                                <p>Reported condition of bike rack: ",bikeRackData$CONDITION,"</p>"), 
                 color = paste(bikeRackData$DOT_COLOR), 
                 fillOpacity = 1.0)
  })
  
  load_data()
  
  
})
