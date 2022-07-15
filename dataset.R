#Compiling Inflation & GDP Data
setwd("/Users/ryanwang/Dropbox/My Mac (Ryan’s MacBook Pro)/Desktop/global-inflation-index")
library(ggplot2)
library(xml2)
library(openxlsx)
library(dplyr)

#Import Data from World Bank
raw_gdp <- read.xlsx("gdp.xlsx")
raw_inflation <- read.xlsx("inflation.xlsx")
gdp_names <- raw_gdp[2,]
gdp <- raw_gdp[-c(1:2),]
colnames(gdp) <- gdp_names
rm(gdp_names)

#Eliminate Countries not in Inflation Data
gdp <- gdp[gdp$`Country Code` %>% is.element(raw_inflation$Country.Code),]
inflation <- raw_inflation[raw_inflation$Country.Code!="TWN",]

#Creating Main Dataset
main <- cbind(inflation, gdp)
main <- main[,-c(2, 4, 5, 632:635)]