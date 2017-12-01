# [Link to our project!](wkwok16.shinyapps.io/bb4-finalproj/)

# Project Description

Unfortunately, the world around us isn't entirely moral, so we have to be wary about where we park out bikes. No matter what strong locks we use, our bikes have a good chance of getting itself or its parts stolen. Our solution: A tool that allows **bike riders** to find the best parking space nearby for their bike.

For our project, we worked with two datasets provided by the Seattle Department of Transportation:

* A list of all [bike racks](https://data.seattle.gov/Transportation/City-of-Seattle-Bicycle-Racks/vncn-umqp) in or around Seattle
* A list of all reported [bike thefts](https://data.seattle.gov/widgets/8rw6-mmz7) in or around Seattle.

### What we did

![app landing page](/readmePictures/landingPage.png)

We created a map based on the last two years of bike theft data that shows which bike racks were Unsafe to Safe on a gradient.

![clicking on a point](/readmePictures/clickOnPoint.png)

A user can click on any point and look at data about that bike rack. They can see a quick statistic about its danger level, and they can click on a link to redirect them to a Google Maps view in a new tab.

This implementation is open-source and adaptable for places other than Seattle as long as they have some sort of dataset available for bike racks and bike thefts.

This tool is in a **functional beta state** that can be improved on in the future. The possibilities for new features are <strong style="color:#7033a1">boundless</strong>.

# Ethical Concerns

While this software aims to bring safety and security to the people, we must not ignore the problem we face with those who may misuse it. A potential danger is that certain individuals will see which areas are marked as "safe" and start looting bikes from that area, because they will see that people might start putting their bikes there more. A major focus we have looking forward is finding a way around this problem that stems from bad human nature.

# Analysis

![analysis](/readmePictures/analysis.png)

### Overview

From a quick glance, it can be seen that near downtown Seattle (around the Westlake Link Station) is where bike thefts are most common. The highest amount of bike thefts reported within the last two years was in this area, 179!

Meanwhile, the least amount of thefts was 0 in areas far outside of downtown Seattle.

This data implies that your bike has a more likely chance of being stolen in the areas with a stronger shade of red. However, there are a few faults to this method of calculation.

### Faults

1. There is a higher population in downtown Seattle compared to an area like the University of Washington, so naturally there will be a higher population of bikers, and as a result a higher amount of bike thefts.

1. College students may be more likely to have cheap used bikes bought from a Goodwill. If their bike gets stolen, it may not be a huge deal to them, if they bought it for cheap. Therefore the area around University of Washington may be affected by this.

1. The radius of calculation may be too large, and not representative of specific bike racks. Perhaps there may be a bike rack where there were no thefts but at a nearby bike rack the theft count is very high.



# Technical Description

### Data wrangling

* Most of the data wrangling was done in `loadData.R`
* We read in raw bike theft data and bike rack data as CSV files and then filtered certain columns. From there, we calculated amounts of thefts reported from the past two years in a certain radius of a selected bike rack (0.003° Latitude/Longitude). This is calculated for **every single** bike rack, so it takes around 10 seconds of computation time
* We calculated what color on a scale of <strong style="color:#FF0000">red</strong> to <strong style="color:#00FF00">green</strong> what the color of each point should be
* Based on theft count compared to theft of the highest crime rate bike rack, we assigned a safety rating to each bike rack as follows:
  * count < 5% of highest theft count: "Very Safe"
  * 5% ≤ count < 15% of highest theft count: "Safe"
  * 15% ≤ count < 50% of highest theft count: "Pretty safe"
  * 50% ≤ count < 75% of highest theft count: "Pretty unsafe"
  * 75% of highest theft count ≤ count: "Unsafe!"
* We then overwrote the bike rack data file with this new dataset
* Future plans: Calculate suggestions for a safer nearby bike rack

### Server side processing

* Loads data from a CSV file into a leaflet map
  * Leaflet map has a bunch of starting parameters based on data from the dataset
* Creates functionality for updating data

### Client side UI

* Uses shinyjs to add inline CSS to generated output
* Generates UI

### Libraries utilized

* [shiny](https://shiny.rstudio.com/)
* [dplyr](http://dplyr.tidyverse.org/)
* [leaflet for R](https://rstudio.github.io/leaflet/)
* [shinydashboard](https://rstudio.github.io/shinydashboard/)
* [graphics](https://stat.ethz.ch/R-manual/R-devel/library/graphics/html/00Index.html)
* [googleVis](https://cran.r-project.org/web/packages/googleVis/index.html)
* [shinyjs](https://deanattali.com/shinyjs/)

# Major problems we encountered, persistent problems, and future plans

### Problem 1: Rendering the leafletOutput in ShinyUI

* **Description**: It was not rendering correctly with this code: `leafletOutput("CountryMap", width = "100%", height = "100%")`
* **How we solved it**: We used different syntax: `leafletOutput("CountryMap", width = "100vw", height = "100vh")`
* **Why it works**: Using `%` for **width** works, but for some reason not **height**. This caused a problem that just made it not run correctly. **Height** can be in pixels or view height, we found.

### Problem 2: Loading of leaflet takes a very long time

* **Description**: When loading the page on the online version, the data had to load in and then the leaflet map had to be generated. This process takes around 8 seconds on the server side.
* **Persistent problem**: We attempted to solve this by including a loading screen that disappears when the content loads in. While the loading screen notifies the user that the data loading in will take time, it doesn't appear correctly. It freezes the program's loading because it uses `Sys.sleep()`, which also seems to pause the processing of the dataset and generation of the leaflet.

### Problem 3: Updating data button

* **Description**: Because of the asynchronous nature of the shiny server, certain messages aren't appearing when they should be. Only once data loads in will the user be notified. The user has no **feedback** when they click the button, and it just seems like nothing happens for 10 seconds, and then the map refreshes suddenly.
* **Persistent problem**: We took the easy way out and just told users that it would take a while. Obviously this solution is not ideal. Especially because this button doesn't do anything. (See next problem). We will need to learn more about how Shiny does calculations, which is beyond the scope of this class.

### Problem 4: Using JSON API from Seattle Department of Transportation

* **Description**: From the start, we used a downloaded CSV file from those two datasets listed earlier. We wanted to use CSV files as a start for testing, and eventually integrate the applet with the API provided by the SDoT.
* **Persistent problem**: When integrating, while the data was fetched properly, it did not run correctly in the code. This is because httr::GET seems to be asynchronous in our implementation with the Shiny server, while we want it to **act** as a synchronous function. What this means is that the program crashes because it goes on to the next step without grabbing the data first. Future plans are to look into GET Promises in R.
