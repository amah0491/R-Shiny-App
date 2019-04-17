#Data Visualization Assignment2
#Name:Anushree Mahajan
#Student_id:28948203
#install.packages("shinythemes")
#install.packages("plotly")
library(shiny)
library(shinythemes)
library(dplyr)
library(plotly)
shinyUI(
  navbarPage(
    theme=shinytheme('slate'),
    "Movies",
####################UI for First page#############
    tabPanel("Home",
             tags$head(
               tags$style(HTML(".my_style_1{ margin-top: -20px; margin-left: -15px; margin-right: -15px;
                               background-image: url(http://watishetdoelvanonderwijs.nl/wp-content/uploads/2015/11/fergregory-fotolia-cinema-e1448547430181.jpg);
                               background-size: 100% auto;background-repeat: no-repeat
                               }"))),
             class="my_style_1",
             fluidPage(
               fluidRow(
                 column(1,
                        "" ),
                 column(4,
                        br(),
                        br(),
                        br(),
                        h1("Another Story of a Film"),br(),
                        h4("Movies have and will continue to entertain us. It plays a huge impact on our lives by showcasing wide range of films which addresses the socio political issues to some light hearted ones which make us laugh."),
                        h4("Film industry has evolved a  lot since its inception and it continue to grow every year by incorporating high end technologies to provide audience with new form of entertainment."),
                        h4("Let us begin our analysis by finding out what are the different factors that affect the cinematic world. "),
                        h4("Lights...Camera...Action..."),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br()
                 )))),
                 
####################UI for Second page#############
    tabPanel("Market Overview",
             fluidPage(
               fluidRow(
                 column(8,br(),h1("World movies distribution")) 
               ),
               fluidRow(
                 column(5,
                        plotlyOutput('Donut_plotly',height=350,width = 700)),
                 column(5,offset=2,h4('The adjoining donut plot gives us an overview about the movie production of different countries in different years.')),
                 column(5,offset=2,h4('The donut plot changes dynamically as the year progresses from 1930 to 2017 and we can see a drastic increase in film production throughout the world.')),
                 column(5,offset=2,h4('With a push of play button we can view the changes in the Movie market over the globe.')),
                 column(5,offset=2,
                        plotlyOutput('Line_Rev',height = 200, width=500))
                 
                           ),
                 fluidRow(
                   column(4,
                          # Animated Sidebar with a slider input
                          sliderInput("yr", "Years:",
                                      min = 1915, max = 2017,
                                      value = 2013, step = 1,
                                      animate =animationOptions(interval = 1000, loop = TRUE))) 
                 )
               
             )),
####################UI for Third page#############

    tabPanel("Genre",
             sidebarLayout(
               sidebarPanel(
                 selectInput("genre", "Select Genre", 
                             choices=c('Adventure','Animation','Comedy','Drama','Science Fiction','Thriller','Horror')),
                 hr(),
                 helpText("Data from IMDB and TMDB website of movies relesed from year 1915.")
                 
                 
               ),
               mainPanel(
                 tabsetPanel(
                   tabPanel("Revenue and Budget Summary",
                            plotlyOutput("gen",height=500,width=800) ),
                   tabPanel("#Movies Released",
                            plotlyOutput("num",height=500,width=800))
                 )
               )
             )
             
             ),
####################UI for Fourth page#############
    tabPanel("Movie Timeline",
             sidebarLayout(
               sidebarPanel(
                 selectInput("YearRange", "Select Year Range", 
                             choices=c('2010-17','2000-09','1990-99','1976-89','1950-75','1915-49')),
                 hr(),
                 helpText("Data from IMDB and TMDB website of movies relesed from year 1915.")
                 
                 
               ),
               mainPanel(
                 tabsetPanel(
                   tabPanel("Calendar Heatmap",
                            plotOutput("cal",height=500,width=800) 
                             )

                 )
               )
             )),
####################UI for Fifth page#############
tabPanel("Movie Metadata",
         
         fluidRow(
           column(4,h1("Movies Performance"),br())),
         fluidRow(
           column(7,plotlyOutput('scatter',height=500,width=700)),
           column(5,h4("Interactive Movie plot highlighting revenue comparison with Imdb score and movie's facebook likes"),br()),
           column(5,h4("Plot gives us information about Movie performance, genres, actor's and director's detailed information."),br()),
           column(5,h5("Note: The plot takes time to load and if you click on any scatter point the movie metadata is displayed.Hover the mouse over the plot if it is not visible."),br()),
           ##Slider input for years
           column(5,br(),br(),br(),br(),
                  # Input: Simple integer interval ----
                  sliderInput("Yr4", "Year:",
                              min = 1915, max = 2017,
                              value = 2014)
                  
                  )
           
           )
         
    
         
         
)
)
  
)
