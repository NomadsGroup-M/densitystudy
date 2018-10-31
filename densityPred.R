

library("ggplot2")
library("forecast")
load("data/dataSample.Rdata")

#################################################################
#################################################################
#it takes training, testing data, and the prediction period. 
#Return the prediction errors for all the 4 seasonal models. 
#################################################################

PredictionsResult<-function(train,test,period){
  Models<-c("Seasonal-Naive","Holt-Winter","TBATS","auto.ARIMA")
    avg<-mean(test)
    ##Seasonal Naive
    sv<-snaive(train,h=period);sv1<-sv$mean; sv1[sv1<0]<-0
    sv.a<-accuracy(sv1,test)[3]/avg
    ##Holt-Winter
    Hw<-forecast(hw(train, seasonal="additive",h=period));Hw<-Hw$mean; Hw[Hw<0]<-0
    hw.a<-accuracy(Hw,test)[3]/avg
    ##TBATS
    tbt<-forecast(tbats(train),h=period)$mean;tbt[tbt<0]<-0;
    tbt.a<-accuracy(tbt,test)[3]/avg
    ##auto.ARIMA
    Arm<-forecast(auto.arima(train),h=period)$mean;Arm[Arm<0]<-0;
    arm.a<-accuracy(Arm,test)[3]/avg
    error=c(sv.a,hw.a,tbt.a,arm.a)
    print(paste("Seasonal Naive Normalized MAE::",round(sv.a,4)))
    print(paste("Holt-Winter Normalized MAE::",round(hw.a,4)))
    print(paste("TBATS Normalized MAE::",round(tbt.a,4)))
    print(paste("auto.ARIMA Normalized MAE::",round(arm.a,4)))
    ##################
    print("----------------------------------------------")
    Result<-cbind(Semester=rep("Fall",4),NMAE=error,Model=Models)
    return(Result)
}




#################################################################
##It uses five weeks of data to predict one week.
#################################################################

HourlyPrediction.5.1<-function()
{  
    data<-dataSample[[1]]$mac
    train<-ts(data[1:300],freq=12, start=1) 
    test<-ts(data[301:360],freq=12, start=26)
    print("Building (1):")
    pred<-PredictionsResult(train,test,60)
    for(i in 2:length(dataSample)){
      print(paste("Building (",i,"):",sep = ""))
        data<-dataSample[[i]]$mac
        train<-ts(data[1:300],freq=12, start=1) 
        test<-ts(data[301:360],freq=12, start=26)
        pred<-data.frame(rbind(pred,PredictionsResult(train,test,60)))
    }
    pred$NMAE=as.numeric(as.character(pred$NMAE))
    pred$Model<-factor(pred$Model,level=c("Seasonal-Naive","Holt-Winter","TBATS","auto.ARIMA"))
    qplot(Semester, NMAE, fill=Model, data=pred, geom="boxplot",ylim = c(0,1))+theme_bw()
}

#################################################################
##It uses one week of data to predict five weeks.
#################################################################
HourlyPrediction.1.5<-function()
{
   
    data<-dataSample[[1]]$mac
    print("Building (1):")
    train<-ts(data[1:60],freq=12, start=1) 
    test<-ts(data[61:360],freq=12, start=6)
    pred<-PredictionsResult(train,test,300)
    for(i in 2:length(dataSample)){
        print(paste("Building (",i,"):",sep = ""))
        data<-dataSample[[i]]$mac
        train<-ts(data[1:60],freq=12, start=1) 
        test<-ts(data[61:360],freq=12, start=6)
        pred<-data.frame(rbind(pred,PredictionsResult(train,test,300)))
    }
    pred$NMAE=as.numeric(as.character(pred$NMAE))
    pred$Model<-factor(pred$Model,level=c("Seasonal-Naive","Holt-Winter","TBATS","auto.ARIMA"))

    qplot(Semester, NMAE, fill=Model, data=pred, geom="boxplot",ylim=c(0,1))+theme_bw()
    #return(pred)
    #print(c1)
}

#################################################################

