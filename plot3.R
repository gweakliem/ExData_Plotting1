library(dplyr)
library(lubridate)

# read table into memory
if (!file.exists("./household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                "./household_power_consumption.zip", "auto")
  unzip("./household_power_consumption.zip")
}

p <- read.table("./household_power_consumption.txt", 
                sep = ";", 
                na.strings = "?", 
                colClasses = c("character", "character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"), 
                header = TRUE)

# subset to just the dates we need. strftime is really slow so this is a good optimization.
p <- subset(p, dmy(Date) %within% interval('2007-01-31','2007-02-02'))
p$Date <- dmy_hms(paste(p$Date, p$Time))

# plot #3 Energy Submetering over time
png("plot3.png", width=480, height = 480)
plot(p$Date, p$Sub_metering_1, type="l", col = "black", ylab = "Energy sub metering", xlab = "")
lines(p$Date, p$Sub_metering_2, type="l", col = "red", ylab = "Energy sub metering")
lines(p$Date, p$Sub_metering_3, type="l", col = "blue", ylab = "Energy sub metering")
legend("topright", lty = 1, 
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
dev.off()
