## This script show how emissions from motor vehicle sources
## have changed from 1999–2008 in Baltimore City.

library(ggplot2)
## Create NEI & SCC data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## Filter NEI data related to cars
cars <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
cars_data <- SCC[cars,]$SCC
cars_data2 <- NEI[NEI$SCC %in% cars_data,]
## Filter cars NEI data to Baltimore
blt_cars_data2 <- cars_data2[cars_data2$fips=="24510",]
## Create a png file
png("plot5.png",width=480,height=480)
chart <- ggplot(blt_cars_data2,aes(factor(year),Emissions/10^3)) +
  geom_bar(stat="identity") +
  labs(x="year", y=expression("Total PM2.5 Emission (in Thousand)")) + 
  labs(title=expression("Baltimore PM2.5 Motor Vehicle Source Emissions"))
print(chart)
dev.off()