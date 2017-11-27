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

# Get CSV data (Offline testing)
bikeTheftData <- read.csv("data/testDatasets/stolen_bikes.csv") %>% select(Latitude, Longitude, Year)
bikeRackData <- read.csv("data/testDatasets/bike_racks.csv") %>% select(LATITUDE, LONGITUDE, CONDITION)

# Constants
radiusSensitivity <- 0.004 # Radius of bike thefts that will be considered for a bike rack, in units of lat/long


shinyServer(function(input, output) {
   
  
  
})
