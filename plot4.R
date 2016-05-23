## This script show how emissions from coal combustion-related sources 
## have changed from 1999–2008

library(ggplot2)
## Create NEI & SCC data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## Filter combustion related NEI data
combustion_data<- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal_data <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
data <- (combustion_data& coal_data)
combustion_data2 <- SCC[data,]$SCC
combustion_data3<- NEI[NEI$SCC %in% combustion_data2,]
## Create a png file
png("plot4.png",width=480,height=480)
chart <- ggplot(combustion_data3,aes(factor(year),Emissions/10^3)) +
  geom_bar(stat="identity") + 
  labs(x="year", y=expression("Total PM2.5 Emission (in Thousand)")) + 
  labs(title=expression("USA PM2.5 Coal Combustion Source Emissions"))
print(chart)
dev.off()