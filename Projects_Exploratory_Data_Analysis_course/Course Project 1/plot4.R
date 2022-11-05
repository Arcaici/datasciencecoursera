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

  #removing NA values from Sub_metering 
bad_dub_metering_1 <- is.na(data$Sub_metering_1)
data <- data[!bad_dub_metering_1, ]

bad_dub_metering_2 <- is.na(data$Sub_metering_2)
data <- data[!bad_dub_metering_2, ]

bad_dub_metering_3 <- is.na(data$Sub_metering_3)
data <- data[!bad_dub_metering_3, ]

  #converting Date in as.Date for plotting purpose
data$Date <- as.Date(data$Date, "%d/%m/%Y")

#function for plotting the four graph required as assigment
drawgraphs <- function(data){
  
  #preparing figure
  par(mfrow = c(2,2))
  
  #plotting data (1,1)
  plot(data$DateTime, data$Global_active_power,  type = "l" , ylab = "Global Active Power", xlab = "" )
  
  #plotting data (1,2)
  plot(data$DateTime, data$Voltage,  type = "l" , ylab = "Voltage", xlab = "datetime" )
  
  #plotting data (2,1)
  plot(data$DateTime, data$Sub_metering_1,  type = "l" , ylab = "Energy sub metering", xlab = "" )
  lines(data$DateTime, data$Sub_metering_2, col = "red",  type = "l" )
  lines(data$DateTime, data$Sub_metering_3, col = "blue",  type = "l" )
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n")
  
  #plotting data, (2,2)
  plot(data$DateTime, data$Global_reactive_power,  type = "l" , ylab = "Global_reactive_power", xlab = "datetime" )
}


  #producing png image
png(file = "plot4.png", width = 480, height = 480, units = "px")
drawgraphs(data)
dev.off()

#---------------END---------------#