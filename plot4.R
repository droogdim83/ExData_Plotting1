##                      Exploratory Data Analysis
##                            Weston Carloss

##                            Plot 4                       

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
##        and February 2, 2007.  Also we can remove the column 
##        "Global_intensity" which isn't required for any of the 4 plots.  
##        Time is needed to keep the data in chronological order.
subsetPowerData <- fullPowerData[fullPowerData$Date %in% c("1/2/2007", "2/2/2007"), 
                                 c(-6)]

##        Free up memory by deleting the original, large data set.
rm(fullPowerData)

##        Combine the "Date" and "Time" columns and convert the result 
##        from a String vector to a Date vector
library(lubridate)
formattedDateTime <- strptime(paste(subsetPowerData$Date, 
                                    subsetPowerData$Time, sep = " "), 
                              "%d/%m/%Y %H:%M:%S")


##        Store subsetPowerData$Global_active_power in variable for easier 
##        referencing
activePower <- subsetPowerData$Global_active_power

##        Store subsetPowerData$Sub_metering_1, subsetPowerData$Sub_metering_2,
##        and subsetPowerData$Sub_metering_3 in variables for easier 
##        referencing
Sub_metering_1 <- subsetPowerData$Sub_metering_1
Sub_metering_2 <- subsetPowerData$Sub_metering_2
Sub_metering_3 <- subsetPowerData$Sub_metering_3

##        Store subsetPowerData$Voltage in variable for easier referencing
voltage <- subsetPowerData$Voltage

##        Store subsetPowerData$Global_reactive_power in variable for easier 
##        referencing
reactivePower <- subsetPowerData$Global_reactive_power


##        Setup a 2x2 plot area where the plots will be filled by column
dev.off()
par(mfcol = c(2, 2))

##        Make a line plot of the Global Reactive Power vs Time
plot(x = formattedDateTime, y = activePower, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")

##        Create the blank plot area for the Sub Metering vs Time line plots, 
##        add the lines, and add the legend
plot(x = formattedDateTime, y = Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(x = formattedDateTime, y = Sub_metering_1, type = "l", col = "black")
lines(x = formattedDateTime, y = Sub_metering_2, type = "l", col = "red")
lines(x = formattedDateTime, y = Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1, 1), col = c("black", "red", "blue"))

##        Make a line plot of the Voltage vs Time
plot(x = formattedDateTime, y = voltage, type = "l", xlab = "datetime", 
     ylab = "Voltage")

##        Make a line plot of Global_reactive_power vs Time
##        Make a line plot of the Voltage vs Time
plot(x = formattedDateTime, y = reactivePower, type = "l", xlab = "datetime", 
     ylab = "Global_reactive_power")



##        Once again, it's safest to recreate all the plots within the png 
##        display device to avoid any copy errors.
png(filename = "plot4.png", width = 480, height = 480, units = "px")

##        Setup a 2x2 plot area where the plots will be filled by column
par(mfcol = c(2, 2))

##        Make a line plot of the Global Reactive Power vs Time
plot(x = formattedDateTime, y = activePower, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")

##        Create the blank plot area for the Sub Metering vs Time line plots, 
##        add the lines, and add the legend
plot(x = formattedDateTime, y = Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(x = formattedDateTime, y = Sub_metering_1, type = "l", col = "black")
lines(x = formattedDateTime, y = Sub_metering_2, type = "l", col = "red")
lines(x = formattedDateTime, y = Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1, 1), col = c("black", "red", "blue"))

##        Make a line plot of the Voltage vs Time
plot(x = formattedDateTime, y = voltage, type = "l", xlab = "datetime", 
     ylab = "Voltage")

##        Make a line plot of Global_reactive_power vs Time
##        Make a line plot of the Voltage vs Time
plot(x = formattedDateTime, y = reactivePower, type = "l", xlab = "datetime", 
     ylab = "Global_reactive_power")
dev.off()