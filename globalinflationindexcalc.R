#Calculating Global Inflation Index
setwd("/Users/ryanwang/Dropbox/My Mac (Ryan’s MacBook Pro)/Desktop/global-inflation-index")
library(openxlsx)

main <- read.xlsx("maindata.xlsx")
inflation <- read.xlsx("inflation.xlsx")
gdp <- main[,-c(3:628)]

#No 2022 gdp data, using 2021 instead
gdp <- cbind(gdp, gdp$"2021")
colnames(gdp)[65] <- "2022"

gii <- c()

for(t in 3:616){
        sum <- 0
        weight_sum <- 0
        year <- floor(as.numeric(colnames(inflation)[t])/100)
        
        for(c in 1:183){
                if(is.na(inflation[c, t]) | is.na(gdp[c, year-1957])){
                        next
                }
                
                sum <- sum + (inflation[c, t])*(as.numeric(gdp[c, year-1957]))
                weight_sum <- weight_sum + as.numeric(gdp[c, year-1957])
        }
        
        gii <- append(gii, sum/weight_sum)
}

x_axis <- seq(1971+(1/12), 2022+(1/6), (1/12))
plot(x_axis, gii, type="l", main="Global Inflation from 1971 to 2022", xlab="Year", ylab="Global Inflation Index")

