#Calculating Inflation Rates (1970.1—2022.2)
setwd("/Users/ryanwang/Dropbox/My Mac (Ryan’s MacBook Pro)/Desktop/global-inflation-index")
library(openxlsx)

main <- read.xlsx("maindata.xlsx")
inflation <- data.frame(main$Country.Code, main$Country)

for(m in 15:628){
        col <- c()
        
        for(c in 1:183){
                if(is.na(main[c,m]) | is.na(main[c,m-12])){
                        col <- append(col, NA)
                } else{
                        i <- ((main[c,m]-main[c,m-12])/(main[c,m-12]))*100
                        col <- append(col, i)
                }
        }
        
        inflation <- cbind(inflation, col)
}
rm(m, c, col, i)

month <- 197101
for(i in 3:616){
        colnames(inflation)[i] = month
        if(month%%100==12){
                month <- month+89
        } else{
                month <- month+1
        }
}
rm(i, month)
