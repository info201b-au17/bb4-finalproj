# This file loads in data and writes the data to a local csv file so there's only one calculation

updateData <- function() {
  # Load in bike data
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
      filter(abs(Latitude-(latIn)) < radiusSensitivity & 
               abs(Longitude-longIn) < radiusSensitivity & 
               Year >= yearThreshold) %>% 
      nrow()
    return(returnCount)
  }
  bikeRackData$THEFTCOUNT <- NA
  for(i in 1:nrow(bikeRackData)) {
    bikeRackData$THEFTCOUNT[i] <- getTheftCount(bikeRackData$LATITUDE[i], bikeRackData$LONGITUDE[i])
  }
  
  getColor <- function(value, maxTheft) {
    RED <- floor(value/maxTheft * 255)
    GREEN <- 255-RED
    BLUE <- 0
    return(rgb(RED,GREEN,BLUE, maxColorValue=255))
  }
  maxTheft <- max(bikeRackData$THEFTCOUNT)
  bikeRackData$DOT_COLOR <- NA
  for(i in 1:nrow(bikeRackData)) {
    bikeRackData$DOT_COLOR[i] <- getColor(bikeRackData$THEFTCOUNT[i], maxTheft)
  }
  
  write.csv(bikeRackData, file="data/testDatasets/bike_racks.csv")
}