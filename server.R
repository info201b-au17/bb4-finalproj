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

shinyServer(function(input, output) {
  output$CountryMap <- renderLeaflet({
    leaflet() %>% addTiles() %>% addProviderTiles("Esri.WorldStreetMap") %>%
      setView(lng = -122.3129, lat = 47.6563, zoom = 17) %>%
      addCircles(lng = as.numeric(bikeRackData$LONGITUDE), 
                 lat = as.numeric(bikeRackData$LATITUDE), 
                 weight = 1, 
                 radius = 6, 
                 popup = paste(bikeRackData$THEFTCOUNT, " ", bikeRackData$LATITUDE, " ", bikeRackData$LONGITUDE), 
                 color = paste(bikeRackData$DOT_COLOR), 
                 fillOpacity = 1.0)
  })
  
  
})
