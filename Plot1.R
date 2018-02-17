Plot1<- function()
{
  library(lubridate)
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
  par(mar=c(4,4,2,1))
  hist(filteredDs$Global_active_power,xlab="Global Active Power (Kilowatts)",ylab="Frequency",main = "Global Active Power",col="red")
  ##Save file and close device
  dev.copy(png,"plot1.png", width=480, height=480)
  dev.off()
}