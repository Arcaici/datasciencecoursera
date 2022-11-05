
library(R.utils)
bunzip2("./data/repdata_data_StormData.csv.bz2", "./data/repdata_data_StormData.csv", remove = FALSE, skip = TRUE)

df <- read.csv("./data/repdata_data_StormData.csv")

print(colnames(df))

summary(df)

print(length(df[is.na(df),]))



#----------------------FIRST QUESTION

print(unique(df$FATALITIES))

print(unique(df$EVTYPE))

#Bar plot x = population failure      y= EVtYPE

sum_fatalites_over_evtype <- aggregate(FATALITIES ~ EVTYPE, df, FUN = sum)

sum_fatalites_over_evtype$know_event <- sapply(sum_fatalites_over_evtype$EVTYPE, function(x){
  
  if(grepl("^Summary*", x)){
    result <- "Unknow Event"
  }else{
    result <- "Know Event"
  }
  return(result)
  
})

print(sum_fatalites_over_evtype[ grep("^Summary*", sum_fatalites_over_evtype$EVTYPE) , ])

summary(sum_fatalites_over_evtype)

sum_fatalites_over_evtype[order(sum_fatalites_over_evtype$FATALITIES , decreasing = TRUE),]



#----------------------FIRST QUESTION



#CROPDAMAGE

print(unique(df$CROPDMG))
print(length(is.na(df$CROPDMG)))

print(unique(df$PROPDMG))
print(length(is.na(df$PROPDMG)))


sum_damage <- aggregate(CROPDMG + PROPDMG ~ EVTYPE, df, sum )

head(sum_damage)

sum_damage$know_event <- sapply(sum_damage$EVTYPE, function(x){
  
  if(grepl("^Summary*", x)){
    result <- "Unknow Event"
  }else{
    result <- "Know Event"
  }
  return(result)
  
})

summary(sum_damage)

sum_damage <- sum_damage[order(sum_damage$`CROPDMG + PROPDMG` , decreasing = TRUE),]
head(sum_damage, 10)
