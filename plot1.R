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

  subset(fullData, Date == "1/2/2007" | Date == "2/2/2007")
}

data <- getData()

# Open PGN device
png(width = 480, height = 480, file = "plot1.png", bg = "transparent")

# Draw plot
hist(data$Global_active_power, breaks = 12, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

# Close the device
dev.off()