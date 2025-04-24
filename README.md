# UKCrimeAnalysis
An analysis in R of regional UK crime data using data from the ONS and UK Government. 

# Overview
This project aims to explore regional crime statistics in order to look for trends over time as well as regional trends. Data was collected for years ending September 2015-2024.

# Data sources
Crime data was downloaded from the Office for National Statistics. Data was used for years ending September, as this was the latest available in 2024 at the time of creating this.(https://www.ons.gov.uk/peoplepopulationandcommunity/crimeandjustice/bulletins/crimeinenglandandwales/previousReleases?page=1)

Distance driven data was downloaded from the UK Government (https://www.gov.uk/government/statistical-data-sets/road-traffic-statistics-tra#traffic-by-local-authority-tra89)

Population data was downloaded from the Office for National Statistics (https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationestimates/datasets/estimatesofthepopulationforenglandandwales)

# Data cleaning
The columns in the crime dataset for 2015 were ordered differently to other years, so were manually changed. Some regions needed renaming as they were different in different datasets, e.g. "City of London" and "London, City of", or "Devon and Cornwall", and "Devon & Cornwall". Regions within the population dataset were split up into unitary authorities, metropolitan counties, and metropolitan districts, whereas only the unitary authorities and metropolitan districts were required; these were manually appended to the crime dataset using Excel.

# Exploratory analysis
Exploring the data involved looking for trends over time within and between regions. For a fair comparison of regions, values were divided by the population in that area. 

Values across all regions were also compared to identify any regional trends/regions of interest.

# Visualisations
3 types of plots were generated, each allowing multiple variables to be explored.

## 1 variable, multiple areas

![burglaryCountsOverTime](https://github.com/user-attachments/assets/a3d91781-b72f-4773-87ed-c39bd728f2c9)
(Note: Data is missing for Greater Manchester in 2019, hence the lower than expected count for the North West in 2019)

From this, we can see that, since 2015, there has been a general downwards trend in the number of burglaries.

## Multiple variables, 1 area

![SWBurgTheftRob](https://github.com/user-attachments/assets/41530d16-16bb-44ee-bdab-2c56017294c2)

This shows the counts of burglaries, thefts, and robberies in the South West region over time. To see trends between variables, we can normalise the counts.

![SWBurgTheftRobNorm](https://github.com/user-attachments/assets/776f0162-a3e0-4b23-a124-f86bfbecee4d)

We can now see that, while burglaries and thefts were decreasing between 2015 and 2021, after which they increased, robberies have been increasing since 2015, only dropping in 2021

## Chloropleth map of 1 variable

![violenceAgainstPerson2021](https://github.com/user-attachments/assets/9da13a44-5834-4b98-94e9-16b7691c4a8f)

The police force areas with the 3 highest counts of violence against the person are:
- Metropolitan Police
- Greater Manchester
- West Yorkshire

With all of these plots, other variables can be explored.

# Tools used
To build and clean the data, I used Excel.

To merge the population and distance driven datasets with the crime datasets, I used Python.

To analyse and plot the data, I used RStudio. To manipulate the data, I used dplyr, and to visualise it, I used ggplot2.
