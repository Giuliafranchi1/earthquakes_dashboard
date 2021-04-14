dt <- read.csv("~/Desktop/shiny_app/dt.csv")


##  function p_load of 'pacman' to check if a package is installed, 
# if not it attempts to install it and then loads it

if(!require('pacman'))install.packages('pacman')
  pacman::p_load(dplyr,maps,ggplot2,tidyr,shiny,shinythemes,shinyWidgets,plotly,leaflet)



dt$Depth.Error<-NULL
dt$Depth.Seismic.Stations<-NULL
dt$Magnitude.Error<-NULL
dt$Magnitude.Seismic.Stations<-NULL
dt$Azimuthal.Gap<-NULL
dt$Horizontal.Distance<-NULL
dt$Horizontal.Error<-NULL
dt$Root.Mean.Square<-NULL

dt$Date <- as.Date(dt$Date, "%m/%d/%Y")

quakes <- dt %>%
  # Split date into components 
  separate(col = Date, into = c("Year", "Month", "Day"), convert = TRUE) %>%
  filter(!(Year %in% c('13T02', '23T02', '28T02'))) %>%
  mutate(Magnitude_rounded = round(Magnitude,0)) %>%
  # Determine Decade from Year
  mutate(Decade = as.integer(as.integer(Year)/10)*10) 

count_by_year <- quakes %>%
  group_by(Year) %>%
  summarize(count=n()) %>%
  filter(count>1)

unique(dt$Type)


eq <- filter(dt, Type=="Earthquakes")


