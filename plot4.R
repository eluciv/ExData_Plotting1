Sys.setlocale(category = "LC_ALL", locale = "english")

# Function that downloads, unzips and filters data
getData <- function() {
  if (!dir.exists("./ExData_Plotting1")) {
    dir.create("./ExData_Plotting1")
  }
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./ExData_Plotting1/household_power_consumption.zip")
  unzip("./ExData_Plotting1/household_power_consumption.zip", exdir = "./ExData_Plotting1")
  fullData <- read.csv2("./ExData_Plotting1/household_power_consumption.txt", header = TRUE, dec = ".",
                    na.strings = "?", stringsAsFactors = FALSE, 
                    colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

  data <- subset(fullData, Date == "1/2/2007" | Date == "2/2/2007")
  
  data <- cbind(data, DateTime = paste(data$Date, data$Time))
  data$DateTime <- strptime(data$DateTime, format = "%d/%m/%Y %H:%M:%S")

  data
}

data <- getData()

# Open PGN device
png(width = 480, height = 480, file = "plot4.png", bg = "transparent")

# Set 2 rows and 2 columns for canvas
par(mfrow = c(2,2))

# Draw plot 1
plot(data$DateTime, data$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

# Draw plot 2
plot(data$DateTime, data$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

# Draw plot 3
plot(data$DateTime, data$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), bty = "n")
with(data, plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime"))

# Close the device
dev.off()