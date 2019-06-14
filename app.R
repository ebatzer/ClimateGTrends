#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(gtrendsR)
library(ggplot2)
library(tidyverse)
library(viridis)
library(rnoaa)

# https://cran.r-project.org/web/packages/rnoaa/rnoaa.pdf
# NOAA token: vqJkAVQemTfjlifkuPQCAyXgObhEEGsL
# devtools::install_github('PMassicotte/gtrendsR')

location = "US-AK"

trends = gtrends(keyword = c("climate change",
                    "global warming"),
        geo = paste(location),
        time = "2004-06-01 2019-06-01",
        gprop = c("web"),
        onlyInterest = TRUE
        )

trends$interest_over_time$date =
  seq.Date(from = as.Date("2004-06-01"),
           to = as.Date("2019-06-01"),
           by = "month")

sum_table = trends$interest_over_time %>%
  group_by(date) %>%
  summarise(hits = sum(hits),
            keyword = "total interest")

plotdata = bind_rows(trends$interest_over_time, sum_table)

plotdata %>% ggplot(aes(x = date,
                      y = hits,
                      color = keyword)) +
  geom_line()



# Define UI for application that draws a histogram
ui <- fluidPage(
   
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
}

# Run the application 
shinyApp(ui = ui, server = server)

