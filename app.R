library(shiny)
library(ggplot2)
library(dplyr)
library(httr)
library(jsonlite)
library(rmarkdown)


# Function to load data from the API
load_weather_data <- function() {
  url <- "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&past_days=10&hourly=temperature_2m,relative_humidity_2m,wind_speed_10m"
  response <- GET(url)
  content <- content(response, as = "text")
  weather_data <- fromJSON(content)$hourly
  
  data.frame(
    time = as.POSIXct(weather_data$time),
    temperature_2m = weather_data$temperature_2m,
    relative_humidity_2m = weather_data$relative_humidity_2m,
    wind_speed_10m = weather_data$wind_speed_10m
  )
}
weather_data <- load_weather_data()

# Define UI
ui <- navbarPage(
  "Weather Data Analysis App",
  tabPanel("Main",
           sidebarLayout(
             sidebarPanel(
               dateRangeInput("date_range", "Select Date Range:",
                              start = min(weather_data$time), end = max(weather_data$time)),
               selectInput("metric", "Select Metric:", choices = c("temperature_2m", "relative_humidity_2m", "wind_speed_10m"))
             ),
             mainPanel(
               plotOutput("weather_plot"),
               tableOutput("weather_stats")
             )
           )
  ),
  tabPanel("About", includeMarkdown("about.Rmd"))
)

# Define server logic
server <- function(input, output, session) {
  filtered_data <- reactive({
    weather_data %>%
      filter(time >= as.POSIXct(input$date_range[1]), time <= as.POSIXct(input$date_range[2]))
  })
  
  output$weather_plot <- renderPlot({
    ggplot(filtered_data(), aes(x = time, y = get(input$metric))) +
      geom_line() +
      labs(title = paste("Weather Data for Berlin"),
           x = "Time", y = "Value")
  })
  
  output$weather_stats <- renderTable({
    filtered_data() %>%
      filter(!is.na(get(input$metric))) %>%
      summarise(mean = mean(get(input$metric), na.rm = TRUE),
                sd = sd(get(input$metric), na.rm = TRUE),
                min = min(get(input$metric), na.rm = TRUE),
                max = max(get(input$metric), na.rm = TRUE))
  })
}

# Run the application
shinyApp(ui = ui, server = server)


