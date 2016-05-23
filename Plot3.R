## This script show which of these four sourcesv(point, nonpoint, onroad, nonroad)
## variable have seen decreases/increases in emissions from 1999–2008 for Baltimore City
library(ggplot2)
## Create NEI & SCC data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## Filter data for Baltimore
blt_NEI <- NEI[NEI$fips=="24510",]
## Sum Baltimore emissions by year
sum_blt_NEI <- aggregate(Emissions ~ year, blt_NEI,sum)
## Create a png file
png("plot3.png",width=480,height=480)
blt_chart <- ggplot(blt_NEI,aes(factor(year),Emissions)) +
  geom_bar(stat="identity") + facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission")) + 
  labs(title=expression("Baltimore PM"[2.5]*" Emissions by Source Type"))
print(blt_chart)
dev.off()