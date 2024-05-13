url_22 <- 'https://raw.githubusercontent.com/huangxinran1900/final_project/main/raw/WHR_2022.csv'
url_23 <- 'https://raw.githubusercontent.com/huangxinran1900/final_project/main/raw/WHR_2023.csv'
url_24 <- 'https://raw.githubusercontent.com/huangxinran1900/final_project/main/raw/WHR_2024.csv'

whr_22_raw <- readr::read_csv(file = url_22)
whr_23_raw <- readr::read_csv(file = url_23)
whr_24_raw <- readr::read_csv(file = url_24)

# Rename the columns of 2024 (different from other datasets)
whr_24_renamed <- whr_24_raw %>% 
  rename(country = "Country name") %>% 
  rename(happiness_score = "Ladder score") %>% 
  rename(gdp_per_capita = "Explained by: Log GDP per capita") %>% # All columns in these datasets represent log GDP per capita
  rename(social_support = "Explained by: Social support") %>%
  rename(healthy_life_expectancy = "Explained by: Healthy life expectancy") %>%
  rename(freedom_to_make_life_choices = "Explained by: Freedom to make life choices") %>%
  rename(generosity = "Explained by: Generosity") %>%
  rename(perceptions_of_corruption = "Explained by: Perceptions of corruption")

filtered_22 <- filter_na(whr_22_raw)
filtered_23 <- filter_na(whr_23_raw)
filtered_24 <- filter_na(whr_24_renamed)

# Five datasets over 2020-2024 collect data from different number of countries
# Keep the rows with countries including in all five datasets
intersect_country <- intersect(intersect(filtered_22$country,filtered_23$country),
                               filtered_24$country)

filtered_22 <- filter_country(filtered_22, 2022)
filtered_23 <- filter_country(filtered_23, 2023)
filtered_24 <- filter_country(filtered_24, 2024)

# Assign region column to filtered_24
filtered_24 <- filtered_24 %>%
  left_join(filtered_23 %>% 
              select(country, region), by="country")

# Here, merge three datasets together
merged_2224 <- filtered_22 %>%
  bind_rows(filtered_23) %>%
  bind_rows(filtered_24)

# train-test split
set.seed(257)
num_data <- nrow(merged_2224)
train_size <- 0.8*num_data
train_indices <- sample(1:num_data, train_size)
train_set <- merged_2224[train_indices,]
test_set <- merged_2224[-train_indices,]
# delete the year, region and country column
train_set <- subset(train_set, select = -c(year, region, country))
test_set <- subset(test_set, select = -c(year, region, country))