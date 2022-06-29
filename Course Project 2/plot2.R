#Loading data

NEI <- readRDS("./data/summarySCC_PM25.rds")

#baltimore selection
baltimore_NEI <- NEI[NEI$fips=="24510",]

#sum total emissions in baltimore
total_em_ba <- aggregate(Emissions ~ year, baltimore_NEI, sum)

#plotting
barplot(total_em_ba$Emissions/10^6, names.arg = total_em_ba$year, 
        xlab = "year", ylab ="Emissions (divide by 10^6)" , main = "PM 2.5 Emissions by years in Baltimore", 
        col = brewer.pal(n=4, name = "Set1"))

#saving PNG file
png(file = "./Course Project 2/plot2.png", width = 480, height = 480, units = "px")
barplot(total_em_ba$Emissions/10^6, names.arg = total_em_ba$year, 
        xlab = "year", ylab ="Emissions (divide by 10^6)" , main = "PM 2.5 Emissions by years in Baltimore", 
        col = brewer.pal(n=4, name = "Set1"))
dev.off()
