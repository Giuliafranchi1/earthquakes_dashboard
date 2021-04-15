############################################################
##### Shiny App: significant earthquakes from 1965 to 2016  ####
##########################################################


## Load Packages
#library(dplyr)
#library(maps)
#library(ggplot2)
#library(tidyr)
#library(plotly)
#library(shiny)
#library(shinythemes)
#library(shinyWidgets)
#library(leaflet)

source("helpers.R")

ui <-fluidPage(theme=shinytheme("paper"),
               navbarPage(
                 "Shiny App: Significant Earthquakes 1965-2016 ",
                 navbarMenu("Plot Analysis",
                            tabPanel("Number of Earthquakes",
                                     #Sidebar panel for inputs
                                     sidebarLayout(
                                       sidebarPanel(
                                       h3("Number of significant Earthquakes"),
                                       p("This table provides the first plot that shows the number of significant earthquakes (Magnitude >5.5) from 1965 to 2016.
                                    As you interact with the slider input you can notice as in the year 2011 there were 712 earthquakes, the highest value in the period considered.",
                                         style = "font-family: 'Arial'; font-si16pt"),
                                       
                                       #Input:slider for range of Years
                                       sliderInput("year1", label = h4("Years of Interest"), min = 1965, 
                                                   max = 2016, 
                                                   value = c(1997,2006),
                                                   sep=""),#endslider
                                    
                                    #endp
                                       
                                       width=3
                                       
                                    
                                       
                                       ),#endsidebarPanel1
                                       
                                       
                                       #Main panel for displaying outputs
                                       mainPanel(
                                         plotlyOutput(outputId = "Plot1"),
                                         p('')
                                       )#endMainpanel1
                                     )#endsidebarlayout
                            ),#endtabPanel1
                            ####EndNavbar1
                            
                            tabPanel("Magnitude Density Plot", #Navbar2
                                     sidebarPanel(
                                       h3("Density function of Magnitude"),
                                       p("In this table I used a density plot for the numeric variable of Magnitude in order to show the probability density function, estimated on kernel density. 
                                         Thanks to the checkbox the user can interact with it according the different causes of seismic waves, given by the variable Type. **Rock Burst has only one observation with Magnitude 6.20.", style = "font-family: 'Arial'; font-si16pt"),
                                       
                                       #Input: checkboxgroup
                                       checkboxGroupInput("checkGroup1", label = h4("Type Multiple Selection"), 
                                                          choices = c("Earthquake", "Explosion", "Nuclear Explosion","Rock Burst"),
                                                          selected = "Earthquake"),#endinput2
                                       
                                       width=3
                                       
                                       ), #endsidebarPanel2
                                    
                                      mainPanel(
                                       plotlyOutput(outputId = "Plot2"),
                                       p('')
                                     ) #endmainpanel2
                            ), #endtabpanel2
                            
                            tabPanel("Depth Density Plot", #Navbar3
                                     sidebarPanel(
                                       h3("Density function of Depth"),
                                       p("As the previous plot the last one shows the density function of the numeric variable Depth.
                                         In the same way the user can interact with the checkbox according to the different causes of seismic waves, given by the variable Type. **Rock Burst has only one observation with Depth 1.00", style = "font-family: 'Arial'; font-si16pt"),
                                       
                                       #Input:
                                       checkboxGroupInput("checkGroup2", label = h4("Choose the Type:"), 
                                                          choices = c("Earthquake", "Explosion", "Nuclear Explosion","Rock Burst"),
                                                          selected = "Earthquake"), #endlinput3
                                       ), #endsidebarPanel3
                                     
                                     
                            mainPanel(
                              plotlyOutput(outputId = "Plot3"),
                              p('')
                            )#endmainpanel3
                            ) #endtabpanel3
                            ),#endnavbarmenu1
                            
                 
                 
                 navbarMenu("Maps", #NavBar 2.1
                            tabPanel("Nuclear Explosions World Map", 
                                     
                                     sidebarPanel( 
                                       h3("Nuclear Explosions around the World 1965-2016"),
                                       p("This section of Shiny App provides the trend of nuclear explosion around the world. The user can interact with the slider input choosing the years of interest in order to see when there was the most intensive nuclear activity.",
                                         style = "font-family: 'Arial'; font-si16pt"), #endp
                         
                                       #Input:slider for range of Years
                                       sliderInput("year2", label = h4("Years of Interest"), min = 1965, 
                                                   max = 2016, 
                                                   value = c(1975,1991),
                                                   sep=""),#endsliderinput 2.1
                                       width = 3
                                       
                                       
                                       
                                     ), #endsiderpanel 2.1
                                     
                                     mainPanel(
                                       plotOutput(outputId = "NuclearMap", height = 600)
                                     ) #endmainPanel 2.1
                            ), #endtabpanel 2.1
                            
                            tabPanel("Earthquakes World Map", #navBar 2.2
                                       
                                     sidebarPanel(
                                       h3("Earthquakes around the World 1965-2016"),
                                       p("This last table provides the trend of earthquakes around the world. Also in this case the user can interact with the slider input choosing which years prefer and the rsnge of magnitude.",
                                         style = "font-family: 'Arial'; font-si16pt"),
                                       
                                         #Input:slider for range of Years
                                         sliderInput("year3", label = h4("Years of Interest"), min = 1965, 
                                                     max = 2016, 
                                                     value = c(1997,2006),
                                                     sep=""), #endsliderinput 2.2
                                       
                                       sliderInput("magnitude", label = h4("Range of Magnitude"), min = 5.5, 
                                                   max = 9.1, 
                                                   value = c(6.0,8.0),
                                                   sep=""),
                                         width = 3
                                         
                                         
                                         ), #endsidebarPanel 2.2
                                     
                                     mainPanel(
                                       plotOutput(outputId = "EqMap", height=600)
                                     )#endmainpanel 2.2
                                     

                            )#endtabpanel 2.2
                            
                            
               

               )#endnavbarmenu2
               )#endnavbarpage
)#endfluidpage
               

               
server <- function(input, output) { 
  
  output$Plot1 <- renderPlotly({
    
    interactive <- subset(count_by_year, (count_by_year$Year>input$year1[1] & count_by_year$Year<input$year1[2]))#endcountbyyear
    
    plotly <- ggplot(interactive , aes(x=Year, y=count, group = 1)) +
      geom_line() + geom_smooth() +
      theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
      geom_text(label = interactive$count, size=3, nudge_y = 5, check_overlap = TRUE) +
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
            axis.title.y=element_blank(), axis.text.y = element_blank()) +
      ggtitle("Number of Significant Earthquakes since 1965")
    
    ggplotly(plotly)
    
  })#endrenderPlotly1

  
  output$Plot2 <- renderPlotly({
    
    sel_type <- subset(dt, dt$Type %in% input$checkGroup1)
  
  plotlymag <- ggplot(sel_type, aes(x=Magnitude, color=Type))+
    geom_density() + theme_classic()
  ggplotly(plotlymag)
})#endrenderPlot3

output$Plot3<- renderPlotly({
  
  sel_type1 <- subset(dt, dt$Type %in% input$checkGroup2)

  plotlydep <- ggplot(sel_type1, aes(x=Depth, color=Type))+
  geom_density()+ scale_x_continuous(limits = c(0, 100))+theme_classic()
  ggplotly(plotlydep)
  
  #scale_x_continuous(limits = c(2, 6))
  #scale_x_log10(breaks = seq.int(from = -10,to = 400,by = 20))
  
})#endrenderPlot3

output$NuclearMap <- renderPlot({
  
  nuclear <- filter(quakes, Type=="Nuclear Explosion")
  
  interactive_nuc <- subset(nuclear, (nuclear$Year>input$year2[1] & nuclear$Year<input$year2[2]))
  
  map <- borders("world", colour="black", fill="grey81") 
  nuclear_map <- ggplot(interactive_nuc) + map 
  nuclear_map + geom_point(aes(x=Longitude, y=Latitude,color=Type),shape=25) +
    theme(legend.position = "top")+
    ggtitle("Nuclear Explosions")
})#endrenderPlot2.1

output$EqMap<-renderPlot({
  
  earthquake<-filter(quakes, Type=="Earthquake")
  
  interactive_eq<- subset(earthquake, ((earthquake$Year>input$year3[1] & earthquake$Year<input$year3[2]) & (earthquake$Magnitude>input$magnitude[1] & earthquake$Magnitude<input$magnitude[2])))

  
  map <- borders("world", colour="black", fill="gray81") 
  earthquakes_map <- ggplot(interactive_eq) + map 
  earthquakes_map + geom_point(aes(x=Longitude, y=Latitude,color=Magnitude),shape=25) +
    scale_color_gradient(low="orange", high="red") +
    theme(legend.position = "top")+
    ggtitle("Earthquakes")
  
})#endrenderPlot2.2


  }#endfunctionserver            


shinyApp(ui = ui, server = server)
               




               
