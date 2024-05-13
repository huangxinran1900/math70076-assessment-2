# function for filter country in common
filter_country <- function(df, year){df %>%
    filter(country %in% intersect_country) %>%
    mutate(year = year)
}