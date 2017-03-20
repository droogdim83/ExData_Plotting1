##                      Exploratory Data Analysis
##                            Weston Carloss

##                            Plot 1                       

##   This data set includes household electrical power consumption for a single
##   household.  The data is sampled at 1 minute intervals for 47 months.
##   The data comes from the UC Irvine Machine Learning Repository.

##   The original dataset contains 9 variables listed below. The variable 
##   descriptions are taken from the UCI web site:
     
#   1.  Date: Date in format dd/mm/yyyy
#   2.  Time: time in format hh:mm:ss
#   3.  Global_active_power: household global minute-averaged active power 
#          (in kilowatts)
#   4.  Global_reactive_power: household global minute-averaged reactive power 
#         (in kilowatts)
#   5.  Voltage: minute-averaged voltage (in volts)
#   6.  Global_intensity: household global minute-averaged current intensity 
#         (in amperes)
#   7.  Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active 
#         energy). It corresponds to the kitchen, containing mainly a 
#         dishwasher, an oven and a microwave (hot plates are not electric but 
#         gas powered).
#   8.  Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active 
#         energy). It corresponds to the laundry room, containing a 
#         washing-machine, a tumble-drier, a refrigerator and a light.
#   9.  Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active 
#         energy). It corresponds to an electric water-heater and an 
#         air-conditioner.

##        Clear out the workspace to reduce memory usage
rm(list = ls())

##        Download the zip file and extract the contents
ZipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("powerConsum.zip")) {
     download.file(ZipUrl, dest="powerConsum.zip") 
}
unzip ("powerConsum.zip")

##        Since there are over 2,000,000 rows and 9 columns of data, we should
##        try to make it read in as quickly as possible by setting column 
##        classes, defining the separator character, and confirming that there's
##        a header row. 
fullPowerData <- read.table("household_power_consumption.txt", sep = ";", 
     header = TRUE, na.strings = c("NA","?"), stringsAsFactors = FALSE,
     colClasses = c("character", "character", "numeric", "numeric", "numeric",
     "numeric", "numeric", "numeric", "numeric"))

##        Subset the data to only include the required dates February 1, 2007
##        and February 2, 2007.  Only need the "Global_active_power" column for
##        this plot.
activePower <- fullPowerData[fullPowerData$Date %in% c("1/2/2007", "2/2/2007"), 
                                 3]

##        Free up memory by deleting the original, large data set.
rm(fullPowerData)

##        Make a histogram of the Global Reactive Power
dev.off()
hist(activePower, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylim = c(0, 1200))

##        Write the plot to a PNG file, Don't forget to close the PNG device
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()