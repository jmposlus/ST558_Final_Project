library(plumber)
library(dplyr)
library(caret)

#Reading in and cleaning the data
main<- read.csv("C:/Users/James P/Downloads/diabetes_binary_health_indicators_BRFSS2015.csv")
library(caret)
library(dplyr) #Need to clean this up a bit
main[,-5]<- lapply(main[,-5], factor)

#Best model
control<- trainControl(method = "repeatedCV", number = 5, repeats = 1)
logit2<- train(Diabetes_binary ~ HvyAlcoholConsump, data = main,
               method = "glm",
               trControl = control,
               metric = "logLoss")

#Info
#* @get /info
function(){
  "https://jmposlus.github.io/ST558_Final_Project/"
}

#http://localhost:PORT/info

#Pred
#* @get /pred
function(alcohol = 0){
  return(predict(logit2, alcohol))
}

#http://localhost:PORT/pred