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

  #removing NA values from Sub_metering 
bad_dub_metering_1 <- is.na(data$Sub_metering_1)
data <- data[!bad_dub_metering_1, ]

bad_dub_metering_2 <- is.na(data$Sub_metering_2)
data <- data[!bad_dub_metering_2, ]

bad_dub_metering_3 <- is.na(data$Sub_metering_3)
data <- data[!bad_dub_metering_3, ]

  #converting Date in as.Date for plotting purpose
data$Date <- as.Date(data$Date, "%d/%m/%Y")

#plotting line graph about Global activity power through day

  #plotting data
plot(data$DateTime, data$Sub_metering_1,  type = "l" , ylab = "Energy sub metering", xlab = "" )
lines(data$DateTime, data$Sub_metering_2, col = "red",  type = "l" )
lines(data$DateTime, data$Sub_metering_3, col = "blue",  type = "l" )
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

  #producing png image
png(file = "plot3.png", width = 480, height = 480, units = "px")
plot(data$DateTime, data$Sub_metering_1,  type = "l" , ylab = "Energy sub metering", xlab = "" )
lines(data$DateTime, data$Sub_metering_2, col = "red",  type = "l" )
lines(data$DateTime, data$Sub_metering_3, col = "blue",  type = "l" )
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
dev.off()

#---------------END---------------#