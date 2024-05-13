# math70076-assessment-2 Explorations on the Levels of Happiness across Countries
## Introduction
This report analyzes the World Happiness Report data from 2022 to 2024 to explore how various factors influence happiness scores across different countries. Using data science methodologies, we aim to provide insights into policy-making and international organization work assessment from the life satisfaction of people.

## Data Source
The data is derived from the Gallup World Poll and includes six social and economic factors from 2022 to 2024. The data structure is the same for 2022 and 2023 datasets and some preprocessing steps are made to adjust the dataset of 2024.

### Data Description
- **Social Support**: Measures the extent of social support available to an individual.
- **Perceptions of Corruption**: Levels of perceived corruption
- **Healthy Life Expectancy**: Expectancy of healthy living.
- **Generosity**: Measure of altruistic behavior in the population.
- **GDP per Capita**: Economic health of a country.
- **Freedom to Make Life Choices**: Degree of personal freedom in daily life experienced by individuals.

# Respository
```bash

|- data/
|  |- raw
|  |  |-WHR_2022.csv
|  |  |-WHR_2023.csv
|  |  |-WHR_2024.csv
|  |- derived
|     |-filter_22.csv
|     |-filter_23.csv
|     |-filter_24.csv
|     |-merged_2224.csv
|
|- src/
|  |- data-cleaning
|  |  |- data-cleaning.R
|  |- helper-function
|     |- filter_country.R
|     |- filter_na.R
| 
|- analyses/
|  |- model-analysis.R
|  |- prediction-plots.R
|  |- variable-importance.R
|
|- outputs/
|  |- figures
|     |- region-plot.png
|     |- cor-plot.png
|     |- variable-importance.png
|     |- predictions.png
|
|- report/
|  |- 02433236-math70076-assessment-2.pdf
|  |- 02433236-math70076-assessment-2.Rmd
|  |- 02433236-math70076-assessment-2-summary.pdf
|
|- README.md
```
