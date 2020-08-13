## Used library
library(lubridate)

## Getting the file

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists('./Power Consumption.zip')){
  download.file(fileUrl,'./Power Consumption.zip', mode = 'wb')
  unzip("Power Consumption.zip", exdir = getwd())
}

## Loading the data in "household_power_consumption.txt" file and naming the columns properly

data <- read.table("household_power_consumption.txt", skip = 1, header = TRUE, sep = ';')
colnam <- read.table("household_power_consumption.txt",nrows = 1, sep = ';')
names(data) <- colnam  

## Creating a date&time column, and adding it to the data frame 
dateTime <- dmy_hms(paste0(data$Date, data$Time))
names(dateTime) <- "DateTime"
data <- cbind(dateTime, data)

## Converting Date and Time variables to Date/Time classes
data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)

## Selecting the subset of interest

dataInt <- subset(data, Date >=as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Making the plots

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(dataInt, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global_reactive_power",xlab="datetime")
})

## Copying the plot

dev.copy(png, file = "plot4.png")
dev.off()