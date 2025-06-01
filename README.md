# 🌤️ Weather Data Analysis App (Berlin)

An interactive Shiny web application that fetches hourly historical weather data for Berlin from the Open-Meteo API and allows users to visualize and analyze temperature, humidity, and wind speed.

📦 Features

📅 Date range filtering for the last 10 days
📈 Line plot visualization of:
Temperature (°C)
Relative Humidity (%)
Wind Speed (m/s)
📊 Statistical summary (mean, standard deviation, min, max)
📖 "About" page supporting an .Rmd file for documentation
🌐 Live Data Source

Data is loaded dynamically from the Open-Meteo API:

https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&past_days=10&hourly=temperature_2m,relative_humidity_2m,wind_speed_10m

💻 App Preview

UI Layout
Sidebar Panel:
Date range selector
Metric selection dropdown
Main Panel:
Weather plot (line chart)
Summary table of selected metric
About Tab:
Includes Markdown-based documentation (e.g., about.Rmd)

📋 How It Works

Data Fetching
load_weather_data <- function() {
  ...
  weather_data <- fromJSON(content)$hourly
  ...
}
Reactive Filtering
filtered_data <- reactive({
  weather_data %>%
    filter(time >= ..., time <= ...)
})
Dynamic Plotting
ggplot(filtered_data(), aes(x = time, y = get(input$metric))) + geom_line()
Statistical Summary
summarise(mean = mean(...), sd = sd(...), min = min(...), max = max(...))

🚀 How to Run

Prerequisites
Install required R packages:

install.packages(c("shiny", "ggplot2", "dplyr", "httr", "jsonlite", "rmarkdown"))
Launch the app
In your R console or RStudio:

shiny::runApp("path_to_app_directory")
Optional: Add about.Rmd
Add an about.Rmd file in the same directory to populate the About tab.

Example content:

# About This App

This app was developed to visualize and analyze historical weather data for Berlin using the Open-Meteo API.
📁 File Structure

.
├── app.R           # Full Shiny app script
├── about.Rmd       # (Optional) About page content in Markdown
├── README.md

✨ Author

Jehyun Sung
Built using R Shiny, Open-Meteo API, and ggplot2.
