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

# plot #2, Global Active Power plotted over time
png("plot2.png", width=480, height = 480)
with(p, 
     plot(Date, Global_active_power,  
          type = "l", 
          main = "Global Active Power", 
          ylab = "Global Active Power (kilowatts)", 
          xlab = ""))
dev.off()

