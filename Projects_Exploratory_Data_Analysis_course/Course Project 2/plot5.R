#Loading data

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#baltimore selection
baltimore_NEI <- NEI[NEI$fips=="24510",]

#motor vehicle
motorVehicle <- grep("Motorcycle", SCC$SCC.Level.Three, ignore.case = TRUE)

motorCycleSCC <- SCC[motorVehicle,]$SCC
motorCycleNEI <- baltimore_NEI[baltimore_NEI$SCC %in% motorCycleSCC,]

#plot
ggplot(motorCycleNEI, aes(factor(year), Emissions/10^5)) + geom_bar(stat = "identity", fill = "red", width = 0.5) + coord_flip() +labs(y = expression("Total PM"[2.5]*" Emission 10^5 from MOtorCychle"), x = "year") + labs(title = expression("Total PM"[2.5]*" motorCycle Source Emission, Baltimore City 1999-2008"))

#saving PNG file
png(file = "./Course Project 2/plot5.png", width = 480, height = 480, units = "px")
ggplot(motorCycleNEI, aes(factor(year), Emissions/10^5)) + geom_bar(stat = "identity", fill = "red", width = 0.5) + coord_flip() +labs(y = expression("Total PM"[2.5]*" Emission 10^5 from MOtorCychle"), x = "year") + labs(title = expression("Total PM"[2.5]*" motorCycle Source Emission, Baltimore City 1999-2008"))
dev.off()