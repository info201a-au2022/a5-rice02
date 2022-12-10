library("shiny")
library("ggplot2")
library("plotly")
library("dplyr")
library("tidyverse")

dataset <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")
# filter the dataset to only include the United States, Canada, Mexico, China, Japan, Korea, Russia, India, England, and France

dataset <- dataset %>% 
        filter(country %in% c("United States", "Canada", "Mexico", "China", "Japan", "Korea", "Russia", "India", "England", "France"))

# get average value of co2 emissions for all countries in 2021 and round to 2 decimal places, then pull the value out of the data frame to use in the summary tab, ignore NA values

average_co2 <- dataset %>% 
        filter(year == 2021) %>% 
        summarise(co2 = round(mean(co2, na.rm = TRUE), 2)) %>% 
        pull()
        

# get the country name of the highest co2 emissions in 2021

highest_co2 <- dataset %>% 
        filter(year == 2021) %>% 
        filter(co2 == max(co2)) %>% 
        select(country) %>% 
        pull()



# get the max co2 value of highest co2 emissions in 2021

max_co2 <- dataset %>% 
        filter(year == 2021) %>% 
        filter(co2 == max(co2)) %>% 
        select(co2) %>% 
        pull()

# get the country name of the lowest co2 emissions in 2021

lowest_co2 <- dataset %>% 
        filter(year == 2021) %>% 
        filter(co2 == min(co2)) %>% 
        select(country) %>% 
        pull()

# get the min co2 value of lowest co2 emissions in 2021

min_co2 <- dataset %>% 
        filter(year == 2021) %>% 
        filter(co2 == min(co2)) %>% 
        select(co2) %>% 
        pull()

# get the average change in co2 emissions from 2020 to 2021 for all countries

change_co2 <- dataset %>% 
        filter(year == 2020 | year == 2021) %>% 
        group_by(country) %>% 
        summarise(co2 = diff(co2)) %>% 
        summarise(co2 = round(mean(co2, na.rm = TRUE), 2)) %>% 
        pull()

# output a scatter plot of co2 emissions for input country and input slider year, color by year
server <- function(input, output){
output$scatter_plot <- renderPlotly({
    plot <- dataset %>% 
        filter(country == input$country) %>% 
        filter(year >= input$year[1] & year <= input$year[2]) %>% 
        ggplot(aes(x = year, y = co2, color = year)) + 
        geom_point() + 
        labs(title = "CO2 Emissions", 
             x = "Year", 
             y = "CO2 Emissions (metric tons per capita)") + 
        theme(plot.title = element_text(hjust = 0.5))

        return(plot)
})



}

