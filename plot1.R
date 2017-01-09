require("dplyr");

load_consumption_data <- function()
{
  consumption_data <- read.csv("household_power_consumption.txt", header=TRUE, sep=";",as.is=TRUE)
  consumption_data <- filter(consumption_data, Global_active_power != "?")
  filtered_data_by_date <- filter(consumption_data, Date=="1/2/2007"| Date=="2/2/2007");
  daba <- mutate(filtered_data_by_date, dt = as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))) 
}

plot1 <- function()
{
  consumption_data <- load_consumption_data();
  png(filename="plot1.png", width = 800, height=600, units="px")
  hist(as.numeric(consumption_data$Global_active_power),
       main="Global Active Power",col="red",
       xlab="Global Active Power (kilowatts)"
  )
  dev.off()
}