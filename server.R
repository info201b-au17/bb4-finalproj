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
yearThreshold <- as.numeric(format(Sys.Date(),'%Y')) - 2 # Gets theft activity from the past two years

# Add count of thefts near bike rack
# VERY SLOW PROCESS! Have to optimize or find a way around looping through entire dataset
# IDEA: Only grab theft data when CLICKING on the point on the map
# IDEA: Calculate nearby theft data as well to determine best spot to park
getTheftCount <- function(latIn, longIn) {
  returnCount <- bikeTheftData %>% 
    filter(abs(Latitude-(latIn)) < 0.004 & abs(Longitude-longIn) < 0.004 & Year >= yearThreshold) %>% 
    nrow()
  return(returnCount)
}
bikeRackData$THEFTCOUNT <- NA
for(i in 1:nrow(bikeRackData)) {
  bikeRackData$THEFTCOUNT[i] <- getTheftCount(bikeRackData$LATITUDE[i], bikeRackData$LONGITUDE[i])
}


shinyServer(function(input, output) {
   
  
  
})
