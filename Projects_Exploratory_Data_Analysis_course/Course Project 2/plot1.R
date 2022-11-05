#Loading data

NEI <- readRDS("./data/summarySCC_PM25.rds")

#sum total emissions
total_em <- aggregate(Emissions ~ year, NEI, sum)

#plotting
barplot(total_em$Emissions/10^6, names.arg = total_em$year, 
        xlab = "year", ylab ="Emissions (divide by 10^6)" , main = "PM 2.5 Emissions by years", 
        col = brewer.pal(n=4, name = "Set1"))

#saving PNG file
png(file = "./Course Project 2/plot1.png", width = 480, height = 480, units = "px")
barplot(total_em$Emissions/10^6, names.arg = total_em$year, 
        xlab = "year", ylab ="Emissions (divide by 10^6)" , main = "PM 2.5 Emissions by years", 
        col = brewer.pal(n=4, name = "Set1"))
dev.off()