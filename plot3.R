#
#	Download and extract from zip file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
df_power<- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep=";", na.strings = "?")
unlink(temp)
#
#	Convert to POSIX date / time format
df_power$ObsDate<-strptime(paste(df_power$Date, df_power$Time), format = "%d/%m/%Y %T")
#
#	Filter out the required dates and remove NA values
#
df_power1<-df_power[df_power$ObsDate >= "2007/02/01" & df_power$ObsDate < "2007/02/03",]
df_power1<-df_power1[complete.cases(df_power1$Date),]
#
#	Draw plot 3 and save it to PNG file
#

plot(df_power1$ObsDate, df_power1$Sub_metering_1, xlab = "", ylab="Energy sub metering", type="l")
lines(df_power1$ObsDate, df_power1$Sub_metering_2, type="l", col="firebrick2")
lines(df_power1$ObsDate, df_power1$Sub_metering_3, type="l", col="blue")
dev.copy(png, filename="plot3.png")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c("black","firebrick2","blue"))

dev.off()
