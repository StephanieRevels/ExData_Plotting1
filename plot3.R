# Downloads necessary packages for the program #

library(lubridate)


# Creates a folder called "Exploaratory Data Analysis - Project 1" under the working directory, #
# if one does not already exist.                                                                #

if(!file.exists("./Exploratory Data Analysis - Project 1")){
  dir.create("./Exploratory Data Analysis - Project 1")}


# Downloads data file from URL and stores in previously created folder. Then unzips files. #

file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(file_url,destfile="./Exploratory Data Analysis - Project 1/Dataset.zip")
unzip(zipfile="./Exploratory Data Analysis - Project 1/Dataset.zip",exdir="./Project 1 Data")


# Determines size of file in bytes #

file.info(file.path(data_location, "household_power_consumption.txt" ))$size


# Read the data files #

data_file <- file('./Project 1 Data/household_power_consumption.txt')
power_data  <- read.table(text = grep("^[1,2]/2/2007",readLines(data_file),value=TRUE), sep=";", stringsAsFactors=FALSE, na.strings = "?", col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


# Combines two variables Date and Time into a single variable called Date_Time #

power_data$Date <- as.Date(power_data$Date, format = '%d/%m/%Y')
power_data$Date_Time <- as.POSIXct(paste(power_data$Date, power_data$Time))


# Plot 3: Creates line graph of variables Sub_metering_1, Sub_metering_2, and Sub_metering_3 and stores #
# it as  plot3.png in working directory #

png("plot3.png", width = 480, height = 480)
plot(power_data$Date_Time,power_data$Sub_metering_1,  type = "l", ylab = "Energy sub metering", xlab = "")
lines(power_data$Date_Time,power_data$Sub_metering_2,  col = 'Red')
lines(power_data$Date_Time,power_data$Sub_metering_3,  col = 'Blue')
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()