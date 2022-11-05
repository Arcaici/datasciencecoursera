#Loading data

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#coal combustion
combustionRelated <- grep("comb", SCC$SCC.Level.One, ignore.case = TRUE)
coalRelated <- grep("coal", SCC$SCC.Level.Four, ignore.case = TRUE)

coalCombustion <- (combustionRelated & coalRelated)

combustionSCC <- SCC[coalCombustion,]$SCC
CombustionNEI <- NEI[NEI$SCC %in% combustionSCC,]

ggplot(combustionNEI, aes(factor(year), Emissions/10^5)) + geom_bar(stat = "identity", fill = "red", width = 0.5) + coord_flip() +labs(y = expression("Total PM"[2.5]*" Emission 10^5"), x = "year") + labs(title = expression("Total PM"[2.5]*" Coal Combustion Source Emission, Baltimore City 1999-2008"))


#saving PNG file
png(file = "./Course Project 2/plot4.png", width = 480, height = 480, units = "px")
ggplot(CombustionNEI, aes(factor(year), Emissions/10^5)) + geom_bar(stat = "identity", fill = "red", width = 0.5) + coord_flip() +labs(y = expression("Total PM"[2.5]*" Emission 10^5"), x = "year") + labs(title = expression("Total PM"[2.5]*" Coal Combustion Source Emission, Baltimore City 1999-2008"))
dev.off()