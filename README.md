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
Exploring the data involved looking for trends over time within and between regions. For a fair comparison of regions, values can be divided by the population in that area. 

Values across all regions were also compared to identify any regional trends/regions of interest.

# Visualisations
3 types of plots were generated, each allowing multiple variables to be explored.

## 1 variable, multiple areas

![burglaryCountsOverTime](https://github.com/user-attachments/assets/a3d91781-b72f-4773-87ed-c39bd728f2c9)
(Note: Data is missing for Greater Manchester in 2019, hence the lower than expected count for the North West in 2019)

From this, we can see that, since 2015, there has been a general downwards trend in the number of burglaries.

## Multiple variables, 1 area

![SWBurgTheftRob](https://github.com/user-attachments/assets/41530d16-16bb-44ee-bdab-2c56017294c2)

This shows the counts of burglaries, thefts, and robberies in the South West region over time. We can see what percentage of crime was made up from these variables by dividing by total crime (excluding fraud)

![SWBurgTheftRobNormTotal](https://github.com/user-attachments/assets/874bcc54-8391-4077-bb8c-cc608d80b5c6)

While the count of theft has been increasing since 2021, the portion of crime that is theft has been increasing much less shaprly.

## Chloropleth map of 1 variable

![violenceAgainstPerson2020](https://github.com/user-attachments/assets/6ea29523-92ef-4e5b-a390-eb450e2071c9)

However, we may want to see which area experienced the most violence against the person per capita.

![violenceAgainstPerson2020divPop](https://github.com/user-attachments/assets/2192a2d4-1cdf-4ad2-a900-135aee77429a)

One drawback of this plot is that the City of London is a very small region, and so is hard to see. For that reason, there is an option to not plot it

![violenceAgainstPerson2020divPopDelLdn](https://github.com/user-attachments/assets/4916b9d6-26c2-45df-8916-60dc0cec6c65)

With all of these plots, other variables can be explored.

# Tools used
To build and clean the data, I used Excel.

To merge the population and distance driven datasets with the crime datasets, I used Python.

To analyse and plot the data, I used RStudio. To manipulate the data, I used dplyr, and to visualise it, I used ggplot2.

# Important notes
Data is missing for Greater Manchester in 2019. 

The homicide count for Yorkshire and The Humber in 2016 is a potential outlier, as it is much larger than expected given the general trend.

Data for "death and serious injury - unlawful driving" and "stalking and harrasment" does not exist for year 2015 and 2016.

Population data for 2024 is missing
