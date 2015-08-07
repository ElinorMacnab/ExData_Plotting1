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

# create PNG file
png(filename = "plot1.png")

# plot graph
hist(data$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")

# close PNG file
dev.off()