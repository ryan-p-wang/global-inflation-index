#Compiling Inflation & GDP Data
setwd("/Users/ryanwang/Dropbox/My Mac (Ryan’s MacBook Pro)/Desktop/global-inflation-index")
library(xml2)
library(openxlsx)
library(dplyr)

#Importing Data from World Bank
raw_gdp <- read.xlsx("gdp.xlsx")
raw_cpi <- read.xlsx("cpi.xlsx")
gdp_names <- raw_gdp[2,]
gdp <- raw_gdp[-c(1:2),]
colnames(gdp) <- gdp_names
rm(gdp_names)

#Eliminating Countries not in Inflation Data
gdp <- gdp[gdp$`Country Code` %>% is.element(raw_cpi$Country.Code),]
cpi <- raw_cpi[raw_cpi$Country.Code!="TWN",]

#Creating Main Dataset
main <- cbind(cpi, gdp)
main <- main[,-c(2, 4, 5, 632:635)]

write.xlsx(main, "/Users/ryanwang/Dropbox/My Mac (Ryan’s MacBook Pro)/Desktop/global-inflation-index/maindata.xlsx"
           , overwrite = TRUE)

