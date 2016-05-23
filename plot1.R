## This script Print the total emissions 
## from PM2.5 decreased in the United States
## for each of the years 1999, 2002, 2005, and 2008.

## Create NEI & SCC data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## Sum of emissions by year
sum_year <- aggregate(Emissions ~ year,NEI, sum)
## Create a png files
png("plot1.png",width=480,height=480)
barplot(
  (sum_year$Emissions)/10^6,names.arg=sum_year$year,
  xlab="Year",ylab="PM2.5 Emissions (in Million)",
  main="Total PM2.5 Emissions in the US")
dev.off()
