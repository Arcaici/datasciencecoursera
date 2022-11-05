#preparing data

  #Loading Data
setwd("./Course Project 1")
data <- read.table("./data/household_power_consumption.txt", na.strings = '?', header = TRUE, sep = ";")

  #concatenation of Date and Time column
data$DateTime <- paste( data$Date, data$Time)

  #convert DateTime from char to POSIX
data$DateTime <-  strptime(data$DateTime, format = "%d/%m/%Y %H:%M:%S")

  #subsetting with dateTime == 2007
data <- data[data$DateTime >= "2007-02-01" & data$DateTime < "2007-02-03" ,]

  #removing NA values from Global_active_power 
bad <- is.na(data$Global_active_power)
data <- data[!bad, ]

  #converting Date in as.Date for plotting purpose
data$Date <- as.Date(data$Date, "%d/%m/%Y")

#plotting line graph about Global activity power through day

  #plotting data
plot(data$DateTime, data$Global_active_power,  type = "l" , ylab = "Global Active Power (kilowatts)", xlab = "" )


  #producing png image
png(file = "plot2.png", width = 480, height = 480, units = "px")
plot(data$DateTime, data$Global_active_power,  type = "l" , ylab = "Global Active Power (kilowatts)", xlab = "" )
dev.off()

#---------------END---------------#
