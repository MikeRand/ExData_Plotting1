setwd("~/Projects/eda/ExData_Plotting1")

get.data <- function() {
  # Download file, unzip it, process date/time fields, and filter on dates.
  
  if (!file.exists("../data")) {
    dir.create("../data")
  }
  if (!file.exists("../data/power.zip")) {
    file.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(file.url, destfile="../data/power.zip", method="curl")
    unzip("../data/power.zip", exdir="../data")    
  }
  data <- read.csv("../data/household_power_consumption.txt",
                   sep=";",
                   colClasses=c("character", "character", "numeric",
                                "numeric", "numeric","numeric",
                                "numeric", "numeric", "numeric"),
                   na.strings="?",
                   as.is = TRUE)
  data$DateTime <- as.POSIXct(paste(data[,1], data[,2]),
                              format="%d/%m/%Y %H:%M:%S")
  start <- as.POSIXct("2007/02/01", format="%Y/%m/%d")
  end <- as.POSIXct("2007/02/03", format="%Y/%m/%d")
  rows <- data$DateTime < end & data$DateTime >= start
  data <- data[rows,]
  data
}

data <-get.data()

# Set up grid
par(mfrow = c(2, 2))

# Plot 1
plot(data$DateTime, data$Global_active_power,
     ylab="Global Active Power",
     xlab="",
     col = "black",
     type = "l")

# Plot 2
plot(data$DateTime, data$Voltage,
     ylab="Voltage",
     xlab="datetime",
     col = "black",
     type = "l")

# Plot 3
plot(data$DateTime, data$Sub_metering_1,
     ylab="Energy sub metering",
     xlab="",
     col = "black",
     type = "l")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1),
       col=c("black","blue","red"),
       bty="n",
       text.font=0)

# Plot 4
plot(data$DateTime, data$Global_reactive_power,
     ylab="Global_reactive_power",
     xlab="datetime",
     col = "black",
     type = "l")

dev.copy(png, file="plot4.png")
dev.off()