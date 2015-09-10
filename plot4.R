## First we read the data stored in our local storage
direct <- getwd()
file <- "household_power_consumption.txt"
workon <- paste(direct,file,sep="/")
outcome <- read.table(workon, header = TRUE, sep=";",na.strings="?",stringsAsFactors=FALSE)
## We will use as.Date() function to concert char type Date info to Date format
outcome$Date <- as.Date(outcome$Date,format="%d/%m/%Y")
##And now we can subset dataset with defined boundries
outcome_ltd <- subset(outcome,subset=(Date >= "2007-02-01" & Date <="2007-02-02"))
## We need to convert Date and Time information as Date/Time 
datetime <- paste(as.Date(outcome_ltd$Date), outcome_ltd$Time)
outcome_ltd$datetime <- as.POSIXct(datetime)
##Plotting time
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(outcome_ltd, {
  plot(Global_active_power~datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~datetime,col='Red')
  lines(Sub_metering_3~datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()