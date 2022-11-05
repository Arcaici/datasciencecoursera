#Loading data

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#baltimore selection
baltimore_LosAngeles_NEI <- subset(NEI, NEI$fips == "24510" | NEI$fips == "06037")

#motor vehicle
motorVehicle <- grep("Motorcycle", SCC$SCC.Level.Three, ignore.case = TRUE)

motorCycleSCC <- SCC[motorVehicle,]$SCC
motorCycleNEI <- baltimore_LosAngeles_NEI[baltimore_LosAngeles_NEI$SCC %in% motorCycleSCC,]

#plot
ggplot(motorCycleNEI, aes(factor(year), Emissions)) + geom_bar(stat = "identity" ,width = 0.5)+ facet_grid(. ~ fips) +labs(y = expression("Total PM"[2.5]*" Emission 10^5 from MOtorCychle"), x = "ftip") + labs(title = expression("Total PM"[2.5]*" motorCycle Source Emission, Baltimore & LA City 1999-2008"))

#saving PNG file
png(file = "./Course Project 2/plot6.png", width = 480, height = 480, units = "px")
ggplot(motorCycleNEI, aes(factor(year), Emissions)) + geom_bar(stat = "identity" ,width = 0.5)+ facet_grid(. ~ fips) +labs(y = expression("Total PM"[2.5]*" Emission 10^5 from MOtorCychle"), x = "ftip") + labs(title = expression("Total PM"[2.5]*" motorCycle Source Emission, Baltimore & LA City 1999-2008"))
dev.off()