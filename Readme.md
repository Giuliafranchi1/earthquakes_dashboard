Midterm exam: create a Shiny app
================

## Significant Earthquakes from 1965 to 2016

This project refers to the course on R of *Coding for Data Science*. 
The aim is to create a **Shiny App** that allows the user to interface in an interactive way the dataset analysis. 
This is an open dataset provided by the National Earthquake Information Center (NEIC), a part of the Department of the Interior, U.S. Geological Survey. One purpose of NEIC is to determine the location and size of all significant earthquakes that occur worldwide. Collecting and providing data to scientists and to the public in order to improve the ability to locate earthquakes and to understand the earthquake mechanism.

## Content of Dataset

This dataset includes a record of *data*, *time*, *location*, *depth*, *magnitude*, and *source* (*Type*) of every earthquake with a reported magnitude 5.5 or greater since 1965.


## The App

The Shiny App is divided into 2 main tabs.

![](Readme_files/figure-gfm/menubar.png)

The first section refers to Plot Analysis in which there are three main plots: 
- Number of Earthquakes since 1965:this first plot describes the number of earthquakes during the different years. As you interact with the slider input you can notice as in the year 2011 there were 712 earthquakes, the highest valued in the period considered.
- Density function of Magnitude: the second plot is  a density plot for Magnitude variable in order to show the probability density function, estimated on kernel density. Thanks to the checkbox the user can interact with it according the different causes of seismic waves, given by the variable Type. 
- Density function of Depth: the last plot of this section provides as the previous one a density function plot of Depth variable.

The second section provides two worldwide maps: 
- Nuclear Explosions around the World 1965-2016: the first one is about trend of nuclear explosion around the world. The user can interact with the slider input choosing the years of interest in order to see when there was the most intensive nuclear activity.
- Earthquakes around the World 1965-2016: this last map provides the trend of earthquakes around the world. Also in this case the user can interact with the slider input choosing which years prefer.


## How to run the Application

Use the command 'runGitHub ("Giuliafranchi1/earthquakes_dashboard")


## References
- https://www.kaggle.com/usgs/earthquake-database
- https://www.usgs.gov/natural-hazards/earthquake-hazards/national-earthquake-information-center-neic?qt-science_support_page_related_con=3#qt-science_support_page_related_con
- https://www.kaggle.com/donyoe/exploring-earthquakes/comments





