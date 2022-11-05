#Loading data

NEI <- readRDS("./data/summarySCC_PM25.rds")

#baltimore selection
baltimore_NEI <- NEI[NEI$fips=="24510",]

#sum total emissions in baltimore
total_em_ba <- aggregate(Emissions ~ year, baltimore_NEI, sum)

#plotting
ggplot(baltimore_NEI, aes(factor(year), Emissions, fill=type)) + geom_bar(stat = "identity") + facet_grid(. ~ type, scales = "free", space = "free") +labs(y = expression("Total PM"[2.5]*"Emission"), x = "year") + labs(title = expression("Total PM"[2.5]*"Emission, valtimore City 1999-2008 by Source Type"))


#saving PNG file
png(file = "./Course Project 2/plot3.png", width = 480, height = 480, units = "px")
ggplot(baltimore_NEI, aes(factor(year), Emissions, fill=type)) + geom_bar(stat = "identity") + facet_grid(. ~ type, scales = "free", space = "free") +labs(y = expression("Total PM"[2.5]*"Emission"), x = "year") + labs(title = expression("Total PM"[2.5]*"Emission, valtimore City 1999-2008 by Source Type"))
dev.off()
