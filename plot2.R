library("data.table")

#Input data from file and subsets data for specified dates
power <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Avoid Scientific Notation
power[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# a POSIXct date was made to filter and graphed by time of day
power[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Dates filter for 2007-02-01 and 2007-02-02
power <- power[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot2.png", width=480, height=480)

## output Plot 2
plot(x = power[, dateTime]
     , y = power[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()