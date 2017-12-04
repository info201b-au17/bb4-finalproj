# This file loads in data and writes the data to a local csv file so there's only one calculation

updateData <- function() {
  # Load in bike data (Can be replaced with API)
  bikeTheftData <- read.csv("data/testDatasets/stolen_bikes.csv") %>% select(Latitude, Longitude, Year)
  bikeRackData <- read.csv("data/testDatasets/bike_racks.csv") %>% select(LATITUDE, LONGITUDE, CONDITION)
  
  # Constants
  radiusSensitivity <- 0.0008 # Radius of bike thefts that will be considered for a bike rack, in units of lat/long
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
  
  # Function for creating RGB color based on value and maximum theft count
  getColor <- function(value, maxTheftIn) {
    RED <- floor(value/maxTheftIn * 255)
    GREEN <- 255-RED
    BLUE <- 0
    return(rgb(RED,GREEN,BLUE, maxColorValue=255))
  }
  
  # set maximum theft count
  maxTheft <- max(bikeRackData$THEFTCOUNT)
  
  # A function to return qualitative safety ratings
  checkSafety <- function(value) {
    if(value < 0.05*maxTheft) {
      return("Very safe")
    } else if(value < 0.15*maxTheft) {
      return("Safe")
    } else if(value < 0.5*maxTheft) {
      return("Pretty safe")  
    } else if(value < 0.75*maxTheft) {
      return("Pretty unsafe")
    } else {
      return("Unsafe!")
    }
  }
  
  # Create dot color column, populate with RGB values from green to red based on theft count
  # Also create an arbitrary safety rating based on the theft count by using checkSafety(theftcount)
  bikeRackData$DOT_COLOR <- NA
  bikeRackData$SAFETY_RATING <- NA
  for(i in 1:nrow(bikeRackData)) {
    bikeRackData$DOT_COLOR[i] <- getColor(bikeRackData$THEFTCOUNT[i], maxTheft)
    bikeRackData$SAFETY_RATING[i] <- checkSafety(bikeRackData$THEFTCOUNT[i])
  }

  # Rewrite imported CSV file  
  write.csv(bikeRackData, file="data/testDatasets/bike_racks.csv")
}