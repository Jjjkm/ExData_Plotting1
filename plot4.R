##download the dat
filename<-"coursera_exploratorydatanalysis_ass1.zip"

if (!file.exists(filename)){
        fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl,filename)
}

unzip(filename)

library(tidyverse)

dat<-read.table("household_power_consumption.txt",header = T,sep=';', 
                na.strings = "?")


## convert the Date and Time variables to Date/Time classes 
dat$Date<-as.Date(dat$Date,"%d/%m/%Y")


##extract only the dates 2007-02-01 and 2007-02-02
## or feb<-rbind(dat[dat$Date=='2007-02-01',],dat[dat$Date=='2007-02-02',])
feb<-subset(dat, dat$Date>='2007-02-01' & dat$Date<="2007-02-02")

##add a new column called Datetime
feb$Datetime<-paste(as.Date(feb$Date),feb$Time)
feb$Datetime<-as.POSIXct(feb$Datetime)

##generate the plot4
##set the layout
par(mfrow=c(2,2))
par(mar=c(5.1, 4.1, 4.1, 2.1))
par(oma=c(0,0,0,0))


##plot4.1
plot(feb$Datetime,feb$Global_active_power,type='l',
     ylab="Global Active Power",xlab="",xaxt="n",
     lwd=1)
axis(1,at=c(feb$Datetime[1],feb$Datetime[1441],feb$Datetime[2880]),
     labels=c("Thu","Fri","Sat"))

##plot4.2
plot(feb$Datetime,feb$Global_reactive_power,type='l',
     xlab="datetime",xaxt="n",ylab='Voltage',
     lwd=1)
axis(1,at=c(feb$Datetime[1],feb$Datetime[1441],feb$Datetime[2880]),
     labels=c("Thu","Fri","Sat"))

##plot 4.3
##generate the plot 3
plot(feb$Datetime,feb$Sub_metering_1,type='l',ylab="Energy sub metering",xlab='',xaxt="n")
lines(feb$Datetime,feb$Sub_metering_2,col='red')
lines(feb$Datetime,feb$Sub_metering_3,col='blue')
legend("topright",c('Sub_metering_1','Sub_metering_2',
                    'Sub_metering_3'),lty=1,bty='n',
       col=c("black","red","blue"),cex=0.5)

axis(1,at=c(feb$Datetime[1],feb$Datetime[1441],feb$Datetime[2880]),
     labels=c("Thu","Fri","Sat"))

##plot 4.4
plot(feb$Datetime,feb$Global_reactive_power,
     type='l',xlab='datetime',ylab='Global_reactive_power',xaxt="n")
axis(1,at=c(feb$Datetime[1],feb$Datetime[1441],feb$Datetime[2880]),
     labels=c("Thu","Fri","Sat"))

dev.copy(png,file='Plot4.png',width=480,height=480)
dev.off()


