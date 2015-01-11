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

# Fixing Factors
dt$Sub_metering_1 <- as.numeric(as.character(dt$Sub_metering_1))
dt$Sub_metering_2 <- as.numeric(as.character(dt$Sub_metering_2))
dt$Sub_metering_3 <- as.numeric(as.character(dt$Sub_metering_3))
dt.2 <- mutate(dt, datetime = paste(Date, as.character(Time)))
dt.2$datetime <- strptime(dt.2$datetime, format = "%Y-%m-%d %H:%M:%S")

# Creating plot 3
png("plot3.png", 480, 480)
plot(
  dt.2$datetime, 
  dt$Sub_metering_1, 
  type = "l",
  xlab = "",
  ylab = "Energy sub metering")
lines(dt.2$datetime, dt$Sub_metering_2, col = "red")
lines(dt.2$datetime, dt$Sub_metering_3, col = "blue")
legend(
  "topright", 
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
  lty = 1, 
  col = c("black", "red", "blue"),
  cex = 1)
dev.off()