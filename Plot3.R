Plot3<-function()
{
  columns <- read.table("household_power_consumption.txt",nrows=1,sep=";",stringsAsFactors = FALSE)
  fh<-file("household_power_consumption.txt")
  #Reading the files with the mentioned date range
  filteredDs <- read.table(text = grep("^[1,2]/2/2007",readLines(fh),value=TRUE) ,skip=1,col.names = columns,sep=";",stringsAsFactors = FALSE)
  close.connection(fh)
  #Plot1
  #converting into as.Date the date column and binding it again
  datecolumn <- as.Date(filteredDs[,1],"%d/%m/%Y")
  filteredDs$ModifiedDt <- datecolumn
  datetime <- paste(as.Date(filteredDs$ModifiedDt), filteredDs$Time)
  filteredDs$Datetime <- as.POSIXct(datetime)
  # Create Plot 3
  with(filteredDs, {
    plot(Sub_metering_1~Datetime, type="l",
         ylab="Energy Sub Metering", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
  })
  legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1),
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  ## Save file and close device
  dev.copy(png,"plot3.png", width=480, height=480)
  dev.off()
}