## This script compare emissions from motor vehicle sources 
## in Baltimore City with emissions from motor vehicle sources 
## in Los Angeles County, California to show which city has 
## seen greater changes over time in motor vehicle emissions.

library(ggplot2)
## Create NEI & SCC data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## Filter NEI reletaed to cars
cars <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
cars_data <- SCC[cars,]$SCC
cars_data2 <- NEI[NEI$SCC %in% cars_data,]
## Filter Baltomore data 
blt_cars_data2 <- cars_data2[cars_data2$fips=="24510",]
blt_cars_data2$city <- "Baltimore City"
## FilterLos Angeles data 
la_cars_data2 <- cars_data2[cars_data2$fips=="06037",]
la_cars_data2$city <- "Los Angeles County"
# Merging the data into one data frame
all_car <- rbind(blt_cars_data2,la_cars_data2)
## Create a png file
png("plot6.png",width=480,height=480)
chart <- ggplot(all_car, aes(x=factor(year), y=Emissions)) +
  geom_bar(stat="identity") +facet_grid( .~city) +
  labs(x="year", y=expression("Total PM2.5 Emission (Thousand)")) + 
  labs(title=expression("PM2.5 Motor Vehicle Source Emissions(Baltomore VS Los Angeles)"))
print(chart)
dev.off()