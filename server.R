# Import libraries
library(shiny)
library(dplyr)
library(ggplot2)

# Get data from API
# source(data/apiLinks.R)
# bikeTheftData <- bikeTheftDataset()
# bikeRackData <- bikeRackDataset()

# Get CSV data (Offline testing)
bikeTheftData <- read.csv("data/testDatasets/stolen_bikes.csv")
bikeRackData <- read.csv("data/testDatasets/bike_racks.csv")

shinyServer(function(input, output) {
   
  
  
})
