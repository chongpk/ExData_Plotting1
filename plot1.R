library("data.table")


#Input data from file then subsets data for specified dates
power <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
                             )

# Avoid  printing in scientific notation
power[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Date Column change to Date Type
power[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Dates filter for 2007-02-01 and 2007-02-02
power <- power[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

## output  plot 1
hist(power[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()