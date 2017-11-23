# Project Description

For our project, we will be working with two datasets that we found from Seattle's public datasets. We will be using data about the [bike racks](https://data.seattle.gov/Transportation/City-of-Seattle-Bicycle-Racks/vncn-umqp) around the city of Seattle, as well as [bike theft reports](https://data.seattle.gov/widgets/8rw6-mmz7). They are both provided by the Seattle Department of Transportation. 

Unfortunately the world around us isn't entirely moral, so we have to be wary about where we park our bikes. No matter what strong locks we use, our bikes have a good chance of getting itself or its parts stolen. Our primary target audience for this app will be bike riders looking to park their bike somewhere safer. 

The app will be able to tell the audience a few things:

1. Where nearest bike racks may be

1. A heatmap of past bike thefts surrounding a specified area

1. A tip on finding the nearest safer bike rack if a bike rack is flagged as unsafe.

While this software aims to bring safety and security to the people, we mustn't ignore the problem we face with those who may misuse it. A potential danger is that individuals will see which areas are marked as "safe" and start looting bikes from that area. A major focus heading forward is finding a way around this problem that stems from bad human nature.

# Technical Description

The format of our final product will most likely be a Shiny app that uses the [Leaflet](https://rstudio.github.io/leaflet/shiny.html) library, similar to this [population map of Ukraine map](https://olesiakoshyk.shinyapps.io/ukrainemap/)

We will be reading in the data from two .csv files, but the code will be adaptable for a future live API.

For wrangling the data, we will need to be filtering the longitude and latitudes of the bike racks, and taking in all the bike thefts in a reasonable radius, and give each bike rack a "score", which we will depict by color (green to red, good to bad).

We will be likely using a new library called Leaflet, as mentioned earlier. 

We will be solving the questions listed above in the "Product Description" area.

We anticipate that we may find thefts not associated with bike racks, and we'll have to ensure it plays no part in the calculation for weight.