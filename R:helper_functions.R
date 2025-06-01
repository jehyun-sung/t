# Define a helper function for calculating summary statistics
calculate_summary_stats <- function(data, metric) {
  data %>%
    summarise(mean = mean(get(metric), na.rm = TRUE),
              sd = sd(get(metric), na.rm = TRUE),
              min = min(get(metric), na.rm = TRUE),
              max = max(get(metric), na.rm = TRUE))
}

