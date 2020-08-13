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

## Converting Date and Time variables to Date/Time classes
data$Date <- dmy(data$Date)

## Selecting the subset of interest

dataInt <- subset(data, Date >=as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Selecting and arranging the column of inters

dataplot <- as.numeric(dataInt$Global_active_power)
dataplot <- dataplot[!is.na(dataplot)]



## Making the plot

hist(dataplot, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

## Copying the plot

dev.copy(png, file = "plot1.png")
dev.off()
