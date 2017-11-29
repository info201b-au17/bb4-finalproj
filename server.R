# Import libraries
library(shiny)
library(dplyr)
library(leaflet)
library(shinydashboard)
library(graphics)
library(googleVis)

library(ggplot2)

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

shinyServer(function(input, output) {
  output$CountryMap <- renderLeaflet({
    leaflet() %>% addTiles() %>% addProviderTiles("Esri.WorldStreetMap") %>%
      setView(lng = startLongitude, lat = startLatitude, zoom = startZoom) %>%
      addCircles(lng = as.numeric(bikeRackData$LONGITUDE), 
                 lat = as.numeric(bikeRackData$LATITUDE), 
                 weight = weightOfCircles, 
                 radius = radiusOfCircles, 
                 popup = paste0("<strong>Danger Level: ",bikeRackData$SAFETY_RATING,"</strong><br />
                                <progress value='",
                                bikeRackData$THEFTCOUNT,
                                "' max='",
                                max(bikeRackData$THEFTCOUNT),
                                "'></progress>"), 
                 color = paste(bikeRackData$DOT_COLOR), 
                 fillOpacity = 1.0)
  })
  
  
})
