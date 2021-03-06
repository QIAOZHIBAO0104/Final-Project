#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(tidyverse)

# Read the Data
bike <-read.csv("day.csv",header=T)



###data exploration
shinyServer(function(input, output, session) {
  
    getData1 <- reactive({
        newData1 <- bike %>% filter(season == input$season)
    })
    
    #create plot
    output$bikePlot <- renderPlot({
        #get filtered data
        newData1 <- getData1()
        
        #create plot
        g <- ggplot(newData1, aes(x = registered, y = cnt))
        
        if(input$weathersit){
            if(input$workingday){
                g + geom_point(size = input$size, aes(col = weathersit,alpha=workingday))
            }
            else{g + geom_point(size = input$size,aes(col = weathersit))
            }
        }  
        else{g + geom_point(size = input$size)}
        
    })
    #create text info
    output$info <- renderText({
        #get filtered data
        newData1 <- getData1()
        
        paste0("The average count of total rental bikes in ", input$season, " is ", round(mean(newData1$cnt),0), " and the average count of registered users is ", round(mean(newData1$registered),0))
    })
    
    #create output of observations    
    output$table <- renderTable({
        getData1()
    })
   
     ########################################## PCA ###############################################
    
    
    
    
    
    
    
    
})