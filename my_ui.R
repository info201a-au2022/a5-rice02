library("tidyverse")
library("plotly")
source("my_server.R")

dataset <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

# Intro tab and tabPanel includes a title, description, image on the right side of the page

ui <- fluidPage(
    titlePanel("CO2 Emissions"),
    tabsetPanel(
        tabPanel("Intro", 
                 h3("CO2 Emissions", bold = TRUE ),
                 p("Carbon dioxide emissions are a serious environmental issue of concern to the world.
                    This data set mainly focuses on carbon dioxide emissions in the following ten countries 
                    (United States, Canada, Mexico, China, Japan, Korea, Russia, India, England, and France) 
                    emissions. And through calculation and comparison, the average emissions of these countries 
                    in recent years, the regions with the highest emissions, the regions with the lowest emissions, 
                    and the changes in recent years ", width = 12, height = 12, color = "#3b3737"),
                 img(src = "https://grist.org/wp-content/uploads/2015/12/emissions.jpg", 
                     width = "100%", 
                     height = "100%"),
                 h3("Summary", bold = TRUE),
                    p("The average CO2 emissions per capita in 2021 was ", average_co2, " metric tons. 
                    The country with the highest CO2 emissions per capita in 2021 was ", highest_co2, " with ", max_co2, " metric tons. 
                    The country with the lowest CO2 emissions per capita in 2021 was ", lowest_co2, " with ", min_co2, " metric tons. 
                    The average change in CO2 emissions per capita from 2020 to 2021 was ", change_co2, " metric tons.", width = 12, height = 12, color = "#3b3737")
        ),
        
        # Plot tab and tabPanel includes a scatter plot of the data set
        
        tabPanel("Plot", 
                 h3("CO2 Emissions"),
                 p("Select a country and year to view the CO2 emissions."),
                 sidebarLayout(
                     sidebarPanel(
                         selectInput("country", "Country", 
                                     choices = unique(dataset$country), 
                                     selected = "United States"),
                         sliderInput("year", "Year", 
                                     min = 1751, 
                                     max = 2021, 
                                     value = c(1751, 2021))
                     ),
                     mainPanel(
                         plotlyOutput("scatter_plot")
                     )
                 )
        )

    )
)









