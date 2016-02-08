# plot4.R

# 1. downloads and reads the data

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "data/data.zip")

# unzips the .zip file
unzip ("data/data.zip", exdir = "data/")

# reads the unzipped file and saves it as "power.data" data frame 
power.data <- read.table(file = "data/household_power_consumption.txt", 
                         header = TRUE, sep = ";", na.strings=c("?","NA"))

# subsets data to take only records from 2007-02-01 to 2007-02-02

power.data$Date <- as.Date(power.data$Date, format = ("%d/%m/%Y"))
subsetted.power.data <- subset(power.data, power.data$Date >= "2007-02-01" 
                               & power.data$Date <= "2007-02-02")

# adds new column called "Date_Table" 
subsetted.power.data$Date_Time <- with(subsetted.power.data, 
                                       as.POSIXct(paste(Date, Time), 
                                                  format="%Y-%m-%d %H:%M:%S"))

subsetted.power.data$Sub_metering_1 <- as.numeric(subsetted.power.data$Sub_metering_1)
subsetted.power.data$Sub_metering_2 <- as.numeric(subsetted.power.data$Sub_metering_2)
subsetted.power.data$Sub_metering_3 <- as.numeric(subsetted.power.data$Sub_metering_3)

# 2. creates the graph and PNG file
png(file = "plot4.png", width=480, height=480) 
par(mfrow = c(2, 2))

# top-left graph
plot(subsetted.power.data$Date_Time, subsetted.power.data$Global_active_power, type="l", 
     xlab="", ylab="Global Active Power")
# top-right graph     
plot(subsetted.power.data$Date_Time, subsetted.power.data$Voltage, type="l", 
     xlab="datetime", ylab="Voltage")
#bottom-left graph
with(subsetted.power.data, plot(subsetted.power.data$Date_Time, 
                                subsetted.power.data$Sub_metering_1, type="l", 
                                xlab="", ylab="Energy sub metering"))
with(subsetted.power.data, lines(subsetted.power.data$Date_Time, 
                                 subsetted.power.data$Sub_metering_2, 
                                 type="l", col = "red"))
with(subsetted.power.data, lines(subsetted.power.data$Date_Time, 
                                 subsetted.power.data$Sub_metering_3, 
                                 type="l", col = "blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, lwd=2.5, col=c("black", "red", "blue"))
#bottom-right graph
plot(subsetted.power.data$Date_Time, subsetted.power.data$Global_reactive_power, 
     type="l", xlab="datetime", ylab="Voltage")

dev.off()