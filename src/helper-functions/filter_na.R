# missing values and select needed columns (2024 has missing column: region)
filter_na <- function(df){
  col_keep <- c("country", "happiness_score", "gdp_per_capita", "social_support", "healthy_life_expectancy", "freedom_to_make_life_choices", "generosity", "perceptions_of_corruption")
  if("region" %in% names(df)){
    col_keep <- c(col_keep, "region")
  }
  df %>%
    filter(!if_any(everything(), is.na))%>%
    select(col_keep)
}