# UKCrimeAnalysis
An analysis in R of regional UK crime data using data from the ONS and UK Government. 

# Overview
This project aims to explore regional crime statistics in order to look for trends over time as well as regional trends. Data was collected for years ending September 2015-2024.

# Data sources
Crime data was downloaded from the Office for National Statistics (https://www.ons.gov.uk/peoplepopulationandcommunity/crimeandjustice/bulletins/crimeinenglandandwales/previousReleases?page=1)
Distance driven data was downloaded from the UK Government (https://www.gov.uk/government/statistical-data-sets/road-traffic-statistics-tra#traffic-by-local-authority-tra89)
Population data was downloaded from the Office for National Statistics (https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationestimates/datasets/estimatesofthepopulationforenglandandwales)

# Data cleaning
The columns in the crime dataset for 2015 were ordered differently to other years, so were manually changed. Some regions needed renaming as they were different in different datasets, e.g. "City of London" and "London, City of", or "Devon and Cornwall", and "Devon & Cornwall". Regions within the population dataset were split up into unitary authorities, metropolitan counties, and metropolitan districts, whereas only the unitary authorities and metropolitan districts were required; these were manually appended to the crime dataset using Excel.

# Exploratory analysis
Exploring the data involved looking for trends over time within and between regions. For a fair comparison of regions, values were divided by the population in that area.

Values across all regions were also compared to identify any regional trends.

The data for the count of homicides in Yorkshire and The Humber in 2016 is a potential outlier, and has been replaced with the mean value of homicides in years 2015, 2017-2024
