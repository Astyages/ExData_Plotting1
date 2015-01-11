library(dplyr)

# Downloading and Reading
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "Electric power consumption.zip", mode = "wb")
file <- unzip("Electric power consumption.zip")
dt.all <- read.table(file, header=T, sep=";")

# Filtering Data
dt.all$Date <- as.character(dt.all$Date)
dt.all$Date <- as.Date(dt.all$Date, format = "%d/%m/%Y")
dt <- filter(dt.all, Date=="2007-02-01" | Date=="2007-02-02")

#Fixing Factors
dt$Global_active_power <- as.numeric(as.character(dt$Global_active_power))

# Creating plot 1
png("plot1.png", 480, 480)
hist(
  as.numeric(as.character(dt$Global_active_power)), 
  col = "red", 
  main = "Global Active Power", 
  xlab = "Global Active Power (kilowatts)")
dev.off()