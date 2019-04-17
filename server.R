
#Data Visualization Assignment2
#Name:Anushree MAhajan
#Student_id:28948203

source("datasource.R")
library(shiny)
library(shinythemes)
library(dplyr)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  
  ####Page1:HomePage#####
  
  ####Page2############
  #####reactive part of the code######
  graph_donut <-reactive({
    plot_data %>%
      filter(
        year==input$yr
      )%>%
      group_by(country)%>%
      summarize(count1 = n()) 
  })
  line_prod<-plot_data %>%
    group_by(year)%>%
    summarize(count_yr = n()) 
  ##########Generating graph for donut########
  output$Donut_plotly<-renderPlotly(graph_donut()%>%
                                      plot_ly(labels = ~country, values = ~count1) %>%
                                      add_pie(hole = 0.6) %>%
                                      layout(title = "Movie Production by Country",  showlegend = T,
                                             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                                             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
                                    
  ) 
  
  #########Generating Line Plot summarizing Movie Information#############
  
  output$Line_Rev<-renderPlotly(plot_ly(line_prod, x = ~year, y = ~count_yr, name = '#Movies', type = 'scatter', mode = 'lines') %>%
                                  layout(title = "Number of movies released over the years",
                                         xaxis = list(title = "Number of Movies"),
                                         yaxis = list (title = "Year")))
  
  
  
  #############Page3:Genre##################################
  second_pg <-reactive({
    plot_data %>%
      filter(
        genre1==input$genre
      ) 
  })
  
  gen_num<-reactive({
    plot_data%>%
      filter(
        genre1==input$genre 
      )%>%group_by(year_range)%>%summarize(count_yr = n())
  })
  
  
  output$gen <-renderPlotly({
    plot_ly(second_pg(), x = ~year_range, y = ~budget, type = 'bar', 
            name = 'Budget',marker = list(color = 'rgb(0, 153, 255)')) %>%
      add_trace(y = ~revenue, name = 'Revenue',marker = list(color = 'rgb(255, 80, 80)')) %>%
      layout(title='Budget and Revenue collection of Movies',yaxis = list(title = '$'), barmode = 'group')
  })
  
  output$num <-renderPlotly({plot_ly(gen_num(), x = ~year_range, y = ~count_yr, type = 'bar', 
          name = 'Budget',marker = list(color = 'rgb(0, 255, 153)'))%>%
    layout(title = "Number of movies released over the years")})
  
 
#########Page4: Detailed Analysis#############################
  cal_heatmap <-reactive({
    third_pg %>%
      filter(
        year_range==input$YearRange
      ) 
  })
  

  #####Plot for Calendar Heatmap#########
  output$cal<-renderPlot({ggplot(cal_heatmap(), aes(monthweek, wday, fill = count_num)) + 
    geom_tile(colour = "white") + 
    facet_wrap(~monthf,ncol=4) + 
    scale_fill_gradient(low="red", high="green") +
    labs(x="Week of Month",
         y="",
         title = "Time-Series Calendar Heatmap highlighting number of movies released per week in the selected year range.", 
         subtitle="", 
         fill="#Movies")})
  

  
  
  ########Page5:Movie Info################
  #####reactive part of the code######
  graph_scatter <-reactive({
    plot_data %>%
      filter(
        year==input$Yr4
      ) 
  })
  output$scatter <- renderPlotly({plot_ly(graph_scatter(), x = ~imdb_score, y = ~movie_facebook_likes, z = ~revenue, type="scatter3d", mode="markers",
                                          color = ~genre1,colors = "Spectral",
                                          text = ~paste('movie:', title, '<br>Director:', director_name, '<br>Actor:', actor_1_name)
  )%>%
      layout(title = 'Revenue vs. Imdb score, Movie Fb_Likes',
             scene = list(xaxis = list(title = 'Imdb score',
                                       gridcolor = 'rgb(255, 255, 255)',
                                       zerolinewidth = 1,
                                       ticklen = 5,
                                       gridwidth = 2),
                          yaxis = list(title = 'Movie Fb_Likes',
                                       gridcolor = 'rgb(255, 255, 255)',
                                       zerolinewidth = 1,
                                       ticklen = 5,
                                       gridwith = 2),
                          zaxis = list(title = 'Revenue',
                                       gridcolor = 'rgb(255, 255, 255)',
                                       zerolinewidth = 1,
                                       ticklen = 5,
                                       gridwith = 2)),
             paper_bgcolor = 'rgb(243, 243, 243)',
             plot_bgcolor = 'rgb(243, 243, 243)')})
  
  
})
