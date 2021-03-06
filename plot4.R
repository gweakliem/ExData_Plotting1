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

# #4 multiple plots
png("plot4.png", width=480, height = 480)
par(mfrow=c(2,2))
plot(p$Date, p$Global_active_power,  
     type = "l", 
     main = "Global Active Power", 
     ylab = "Global Active Power (kilowatts)", 
     xlab = "")
plot(p$Date, p$Voltage, type="l", ylab = "Voltage", xlab = "datetime")

plot(p$Date, p$Sub_metering_1, type="l", col = "black", ylab = "Energy sub metering", xlab = "")
lines(p$Date, p$Sub_metering_2, type="l", col = "red", ylab = "Energy sub metering")
lines(p$Date, p$Sub_metering_3, type="l", col = "blue", ylab = "Energy sub metering")
legend("topright", lty = 1, 
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
plot(p$Date, p$Global_reactive_power, type="l", col = "black",xlab = "datetime")
dev.off()
