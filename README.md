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

# Technical Description

# Major problems we encountered or Persistent problems

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

## Problem 5: 




# Future plans
