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

# convert Date column to POSIXlt
p$Date <- dmy_hms(paste(p$Date, p$Time))

# Plot #1 Global Active Power as a histogram
png("plot1.png", width=480, height = 480)
hist(p$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency")
dev.off()


