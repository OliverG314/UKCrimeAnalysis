cat("\f")

library(tidyverse)
library(sf)

windowsFonts(Font = windowsFont("CMU Serif"))

setwd(dirname(parent.frame(2)$ofile))

df <- read.csv("../data/20152024regionalcrimeFull.csv")

titleW = 50

####Column renaming and titles####
renameCol <- function(df, oldCol, newCol){
  names(df)[names(df) == oldCol] <- newCol
  
  df
}

df <- df %>%
  renameCol("Year.ending.September", "year") %>%
  renameCol("Area.name", "area") %>%
  renameCol("Total.recorded.crime..excluding.fraud.", "totalCrimeExFraud") %>%
  renameCol("Violence.against.the.person", "violenceAgainstPerson") %>%
  renameCol("Homicide", "homicide") %>%
  renameCol("Death.or.serious.injury...unlawful.driving", "deathInjuryDriving") %>%
  renameCol("Violence.with.injury", "violenceWithInjury") %>%
  renameCol("Violence.without.injury", "violenceWithoutInjury") %>%
  renameCol("Stalking.and.harassment", "stalkingHarassment") %>%
  renameCol("Sexual.offences", "sexualOffences") %>%
  renameCol("Robbery", "robbery") %>%
  renameCol("Theft.offences", "theft") %>%
  renameCol("Burglary", "burglary") %>%
  renameCol("Residential.burglary", "residentialBurglary") %>%
  renameCol("Non.residential.burglary", "nonResidentialBurglary") %>%
  renameCol("Vehicle.offences", "vehicleOffences") %>%
  renameCol("Theft.from.the.person", "theftFromPerson") %>%
  renameCol("Bicycle.theft", "bicycleTheft") %>%
  renameCol("Shoplifting", "shoplifting") %>%
  renameCol("Other.theft.offences", "otherTheftOffences") %>%
  renameCol("Criminal.damage.and.arson", "criminalDamageArson") %>%
  renameCol("Drug.offences", "drugOffences") %>%
  renameCol("Possession.of.weapons.offences", "possOfWeaponsOffences") %>%
  renameCol("Public.order.offences", "publicOrderOffences") %>%
  renameCol("Miscellaneous.crimes", "miscCrimes") %>%
  renameCol("Population.mid.year.estim", "population") %>%
  renameCol("Million.kms.by.car.taxi", "mlnCarTaxiKms") %>%
  renameCol("Million.kms.by.hgvs", "mlnHGVKms") %>%
  renameCol("Million.kms.by.lcvs", "mlnLCVKms")

colNameTitleDf <- data.frame(col = c("year", "area", "totalCrimeExFraud",
                                     "violenceAgainstPerson", "homicide",
                                     "deathInjuryDriving", "violenceWithInjury",
                                     "violenceWithoutInjury", "stalkingHarassment",
                                     "sexualOffences", "robbery", "theft", 
                                     "burglary", "residentialBurglary",
                                     "nonResidentialBurglary", "vehicleOffences",
                                     "theftFromPerson", "bicycleTheft", 
                                     "shoplifting", "otherTheftOffences",
                                     "criminalDamageArson", "drugOffences",
                                     "possOfWeaponsOffences", "publicOrderOffences",
                                     "miscCrimes", "population", "mlnCarTaxiKms",
                                     "mlnLCVKms", "mlnHGVKms"),
                             title = c("Year", "Area", 
                                       "Total crime excluding fraud", 
                                       "Violence against the person", "Homicide",
                                       "Death or serious injury - unlawful driving",
                                       "Violence with injury", 
                                       "Violence without injury", 
                                       "Stalking and harassment", "Sexual offences",
                                       "Robbery", "Theft", "Burglary",
                                       "Residential burglary", 
                                       "Non residential burglary", 
                                       "Vehicle offences", "Theft from the person",
                                       "Bicycle theft", "Shoplifting", 
                                       "Other theft offences", 
                                       "Criminal damage and arson", "Drug offences",
                                       "Possession of weapons offences",
                                       "Public order offences",
                                       "miscellaneous crimes", 
                                       "Mid-year population estimate",
                                       "Million kms driven by car or taxi",
                                       "Million kms driven by HGVs",
                                       "Million kms driven by LCVs"))

####Area size levels####
L1 <- c("ENGLAND AND WALES")
L2 <- c(L1, "ENGLAND", "WALES")
L3 <- c(L2, "North East", "North West", "Yorkshire and The Humber",
        "East Midlands", "West Midlands Region", "East",
        "London", "South East", "South West")
L4 <- c(L3, "City of London", "Metropolitan Police", 
        "British Transport Police")

countries <- c("ENGLAND", "WALES")
regions   <- c("North East", "North West", "Yorkshire and The Humber",
               "East Midlands", "West Midlands Region", "East",
               "London", "South East", "South West")
top10size <- c("Dyfed-Powys", "Devon and Cornwall", "North Yorkshire",
               "West Mercia", "Cumbria", "North Wales", "Lincolnshire",
               "Thames Valley", "Northumbria", "Norfolk")

notL4 <- df$area[! df$area %in% L4]
####Scatter plot for 1 variable for list of areas over time####
plotDataOverTime <- function(column, 
                             areas = regions,
                             divValue = F){
  
  valueTimeDf <- df %>%
    filter(area %in% areas)
  
  value  <- valueTimeDf[[column]]
  
  title <- colNameTitleDf[colNameTitleDf$col == column,]$title
  
  titleText <- str_wrap(paste("Counts of", str_to_lower(title), 
                        "over time"), width=titleW)
  
  if (divValue != F){
    divVal <- valueTimeDf[[divValue]]
    
    valueTimeDf <- valueTimeDf %>%
      filter(!is.na(divVal))
    
    value <- valueTimeDf[[column]]/valueTimeDf[[divValue]]
    
    divText <- colNameTitleDf[colNameTitleDf$col == divValue,]$title
    
    titleText <- str_wrap(paste("Counts of", str_to_lower(title), 
                          "over time, divided by", str_to_lower(divText)), width=titleW)
  }
  
  valueTimePlot <- ggplot(valueTimeDf,
                          aes(x = year, y = value, color=str_wrap(area, width = 20))) +
    geom_point() +
    geom_line() +
    scale_x_discrete(limits = unique(valueTimeDf$year)) +
    scale_color_discrete(name="Area") +
    labs(title = titleText,
         x     = "Year ending September",
         y     = title) +
    theme(text = element_text(family = "Font"))
  
  valueTimePlot
}
####Scatter plot for list of variables for 1 area over time####
plotVarsOverTime <- function(areaValue, 
                             columns = c("totalCrimeExFraud"),
                             divValue = F){
  
  valueTimeDf <- df %>%
    filter(area == areaValue) %>%
    select(c("year", columns)) %>%
    pivot_longer(cols=columns)
  
  titleText <- str_wrap(paste("Counts of variables in", areaValue, 
                              "over time"), width=titleW)
  yLabel    <- "Count"
  
  if (divValue != F){
    valueTimeDf <- df %>%
      filter(area == areaValue) %>%
      select(c("year", columns, divValue)) %>%
      pivot_longer(cols=columns)
    
    divVal <- valueTimeDf[[divValue]]
    
    valueTimeDf <- valueTimeDf %>%
      filter(!is.na(divVal)) %>%
      mutate(value = value/na.omit(divVal))
    
    divText <- colNameTitleDf[colNameTitleDf$col == divValue,]$title
    
    titleText <- str_wrap(paste("Counts of variables, in", 
                                areaValue, "over time, divided by", 
                                divText), width=titleW)
    yLabel    <- divText
  }
  
  valueTimePlot <- ggplot(valueTimeDf,
                          aes(x = year, y = value, color = name)) +
    geom_point() +
    geom_line() +
    scale_x_discrete(limits = unique(valueTimeDf$year)) +
    scale_color_discrete(name="Variable") +
    labs(title = titleText,
         x     = "Year ending September",
         y     = yLabel) +
    theme(text = element_text(family = "Font"))
  
  valueTimePlot
}

####Chloropleth map of 1 variable for all areas####
plotMap <- function(column, yearValue, 
                    divValue=F, londonCityText=F){
  shp <- st_read("../data/pfashp/PFA_DEC_2023_EW_BUC.shp")
  
  shp[shp$PFA23NM == "London, City of",]$PFA23NM <- "City of London"
  shp[shp$PFA23NM == "Devon & Cornwall",]$PFA23NM <- "Devon and Cornwall"
  
  londonCityCentroid <- shp %>% 
    filter(PFA23NM == "City of London") %>%
    st_centroid() %>%
    st_coordinates()
  
  if (londonCityText == T){
    shp <- shp %>% filter(PFA23NM != "City of London")
  }
  
  mapYearData <- df %>%
    filter(year == yearValue)
  
  mapDataDf <- data.frame(area = shp$PFA23NM) %>%
    left_join(mapYearData, by="area")
  
  ldnVal <- mapYearData %>% 
    filter(area == "City of London") %>%
    select(column)
  
  value <- mapDataDf[[column]]
  title <- colNameTitleDf[colNameTitleDf$col == column,]$title
  
  titleText <- paste("Counts of", str_to_lower(title), "in", yearValue, 
                     "across \nEngland and Wales")
  
  scaleName = "Count"
  
  if (divValue != F){
    ldnDiv <- mapYearData %>%
      filter(area == "City of London") %>%
      select(divValue)
    
    div <- mapDataDf[[divValue]]
    
    value  <- value/div
    ldnVal <- ldnVal/ldnDiv
    
    titleDivValue <- colNameTitleDf[colNameTitleDf$col == divValue,]$title
    
    titleText <- paste("Counts of", str_to_lower(title), "in", 
                       yearValue, 
                       "across \nEngland and Wales, divided by",
                       str_to_lower(titleDivValue))
    
    scaleName = paste("Count/", divValue, sep="")
  }
  
  mapPlot <- ggplot(shp) +
    geom_sf(aes(fill=value)) +
    scale_fill_continuous(name=scaleName) +
    labs(title = titleText) +
    theme(text = element_text(family = "Font"),
          plot.margin = margin(t = 10, r = 100, b = 10, l = 0),
          axis.text  = element_blank(),
          axis.ticks = element_blank(),
          axis.title = element_blank(),
          legend.spacing = unit(5, "pt"),
          legend.margin = margin(0, 0, 0, 0, "pt"))
  
  if (londonCityText == T){
    mapPlot <- mapPlot + 
      geom_segment(data = londonCityCentroid,
                   aes(x = X, y = Y, 
                       xend = X + 50000, yend = Y - 125000,
                       color = "City of London"),
                   arrow = arrow(length = unit(0.2, "cm"))) +
      geom_text(data = londonCityCentroid,
                aes(x = X + 50000, y = Y - 150000, 
                    label = round(ldnVal, digits = 4))) +
      scale_color_manual(name = "",
                         values = c("City of London" = "black"))
  }
  
  mapPlot
}
####Save####
saveFile <- T

plt <- plotDataOverTime("totalCrimeExFraud", divValue = "population")

if (saveFile == T){
  filename <- "imgName"
  
  png(paste("../imgs/", filename, ".png", sep=""), 
      width = 568/4, height = 277/4, units='mm', res = 600)
  
  plot(plt)
  
  dev.off()
} else{
  plot(plt)
}