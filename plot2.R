## This script print the  total emissions from PM2.5 decreased 
## in the Baltimore City, Maryland 
## for each of the years 1999, 2002, 2005, and 2008.

## Create NEI & SCC data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## Filter Data for Baltimore
blt_NEI <- NEI[NEI$fips=="24510",]
## Sum Baltimore emissions by year
sum_blt_NEI <- aggregate(Emissions ~ year, blt_NEI,sum)
## Create a png file
png("plot2.png",width=480,height=480)
barplot(
  sum_blt_NEI$Emissions, names.arg=sum_blt_NEI$year,
  xlab="Year", ylab="PM2.5 Emissions",
  main="Baltimore Total PM2.5 Emissions"
)
dev.off()