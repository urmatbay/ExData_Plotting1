# plot1.R

# 1. downloads and reads the data

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "data/data.zip")

# unzips the .zip file
unzip ("data/data.zip", exdir = "data/")

# reads the unzipped file and saves it as "power.data" data frame 
power.data <- read.table(file = "data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings=c("?","NA"))

# subsets data to take only records from 2007-02-01 to 2007-02-02

power.data$Date <- as.Date(power.data$Date, format = ("%d/%m/%Y"))
subsetted.power.data <- subset(power.data, power.data$Date >= "2007-02-01" & power.data$Date <= "2007-02-02")

# 2. creates the graph

hist(subsetted.power.data$Global_active_power, breaks = 12, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# 3. creates PNG file

dev.copy(png, file = "plot1.png", width=480, height=480)
dev.off()