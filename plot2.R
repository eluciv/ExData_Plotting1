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
png(width = 480, height = 480, file = "plot2.png", bg = "transparent")

# Draw plot
plot(data$DateTime, data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

# Close the device
dev.off()