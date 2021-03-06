# download, unzip and read in data
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url=url, destfile = "project1")
unzip("project1")
data <- read.table("household_power_consumption.txt",
                   sep = ";",
                   skip = 66637,
                   nrows = 2880,
                   colClasses = c("character", "character", rep("numeric", 7))
)

# add in column names (for ease of access)
colNames <- read.table("household_power_consumption.txt",
                       sep = ";",
                       nrows = 1,
                       colClasses = rep("character", 9))
colHeads <- as.vector(colNames[1,], mode = "character")
names(data) <- colHeads

# join first two columns and convert to date-time
datesTimes <- vector(mode = "character", length = 2880)
for(i in 1:2880){
  datesTimes[i] <- paste(data$Date[i], data$Time[i])
}
datesTimes <- strptime(datesTimes, format = "%d/%m/%Y %H:%M:%S")

# create new data frame with reformatted dates and times
dataWithDates <- data.frame(datesTimes, data[,3:9], stringsAsFactors = F)

# create PNG file
png(filename = "plot3.png")

# plot graphs
with(dataWithDates, plot(datesTimes, Sub_metering_1,
                         type = "l",
                         xlab = "",
                         ylab = "Energy sub metering"))
with(dataWithDates, lines(datesTimes, Sub_metering_2, col = "red"))
with(dataWithDates, lines(datesTimes, Sub_metering_3, col = "blue"))

# add legend
legend("topright",
       col = c("black", "blue", "red"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty =1)

# close PNG file
dev.off()