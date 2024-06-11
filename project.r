
install.packages("RMySQL")


library(RMySQL)
mydb=dbConnect(MySQL(),user = 'root',password = 'akaash',host = 'localhost',
dbname = 'r_prog')
dbListTables(mydb)


sleeper<-50
A3<-50
A2<-50
AC1<-50


print("=================RAILWAY TICKET BOOKING SYSTEM=====================")
i=1
while(i<=1){
  num1<-round(runif(1, min=1, max=999))
  num2<-round(runif(1, min=1, max=9999999))
  pnr<-paste(num1,"-",num2)
  mydb_list <- list()
  mydb_list<-append(mydb_list,pnr)
  names<-readline(prompt = "Enter passenger name:")
  mydb_list<-append(mydb_list,names)
  age<-as.integer(readline(prompt = "Enter passenger age:"))
  mydb_list<- append(mydb_list,age)
  gender<-readline(prompt = "Enter passenger gender:")
  mydb_list <-append(mydb_list,gender)

  begin<-readline(prompt = "Enter the source place:")
  end<-readline(prompt = "Enter the destination place:")
  cat("The Following Trains Are Available.....\n")
  cat("1. Rajdhani Express.......10:00a.m........Sealdah Station\n")
  cat("2. Satabdi Express..........05:00p.m........Howrah Station\n")
  cat("3. Humsafar Express..........11:00p.m........Kolkata Chitpur Station\n")
  cat("4. Garib-Rath Express.........05:00p.m........Sealdah Station\n")
  cat("5. Duronto Express............07:00a.m.........Santraganchi Station\n")
  choice<-as.integer(readline(prompt = "Enter your choice:"))
  train<-switch(
    choice,
    "Rajdhani Express Sealdah Station 10:00am",
    "Satabdi Express Howrah Station 10:00am",
    "Humsafar Express Kolkata Chitpur Station 10:00am",
    "Garib-Rath Express Sealdah Station 10:00am",
    "Duronto Express Santraganchi Station 10:00am",
  )
  mydb_list <-append(mydb_list,train)
  print(paste("The train chosen: ",train))
  cat("Enter Your Choice......\n")
  cat("1. Sleeper Class....\n")
 
  print(paste("seats available in: sleeper class",sleeper))
  print("cost of 1 seat in sleeper class is 1000rs")
  cat("2. 3A Class....\n")

  print(paste("seats available in 3A clas:",A3))
  print("cost of 1 seat in 3A class is 2500rs")
  cat("3. 2A Class....\n")

  print(paste("seats available in 2A class:",A2))
  print("cost of 1 seat in 2A class is 5000rs")
  cat("4. 1st Class A.C.....\n")

  print(paste("seats available in 1st class AC:",AC1))
  print("cost of 1 seat in 1st class AC is 10000rs")
  choice1<-as.integer(readline(prompt = "Enter your class:"))
  number<-1
  cost<-switch (
    choice1,
    number*1000,
    number*2500,
    number*5000,
    number*10000
  )
  if(choice==1)
  {
    sleeper=sleeper-1
    mydb_list <-append(mydb_list,"sleeper class")
  }else if(choice==2)
  {
    mydb_list <-append(mydb_list,"3rd class")
    A3=A3-1
  }else if(choice==3)
  {
    mydb_list <-append(mydb_list,"2nd class")
    A2=A2-1
  }else if(choice==4)
  {
    mydb_list <-append(mydb_list,"1st class AC")
    AC1=AC1-1
  }
  print("The cost of the journey is:")
  print(cost)
  mydb_list <-append(mydb_list,cost)
  print("Payment options are:")
  cat("1.credit card\n2.visa card\n3.GPAY")
  pay<-as.integer(readline(prompt = "Enter payment method:"))
  if(pay==1)
  {
    mydb_list <-append(mydb_list,"credit card")
    info<-readline(prompt = "Enter credit card number:")
  }else if(pay==2){
    mydb_list <-append(mydb_list,"visa card")
    info<-readline(prompt = "Enter visa card number:")
  }else if(pay==3){
    mydb_list <-append(mydb_list,"gpay")
    info<-readline(prompt = "Enter UPI ID:")
  }
  print("Thank You,Have a nice journey")
  i=i+1
  query<-paste("insert into rail values(null,'",mydb_list[1], "','",
               mydb_list[2], "',", mydb_list[3],",'",mydb_list[4],"','",
               mydb_list[5],"','",mydb_list[6],"',",mydb_list[7],",'",
               mydb_list[8],"');")
  dbSendQuery(mydb, query)
}
