#Data source for different visualization which would help out in creating different dataframes needed for different visualizations

library(plotly)
library(scales)
library(zoo)
library(readr)
library(sqldf)
library(raster)

scatter<-read.csv('movies.csv')
#############Scatter Plot 3D######################################################
# To be used for filtering out the data
genre_list<-c('Adventure','Animation','Comedy','Drama','Science Fiction','Thriller','Horror')
plot_data<-subset(scatter,(genre1 %in% genre_list) )
plot_data<-subset(plot_data,(revenue!=0))
plot_data<-subset(plot_data,(budget!=0))
colors1 <- c('#4AC6B7', '#1972A4', '#965F8A','#E332d3', '#FF7070', '#C61951')

##############Bar Plot############################################################

plot_data$year_range[plot_data$year>=1915 & plot_data$year<=1929]<-'1915-29'
plot_data$year_range[plot_data$year>=1930 & plot_data$year<=1939]<-'1930-39'
plot_data$year_range[plot_data$year>=1940 & plot_data$year<=1949]<-'1940-49'
plot_data$year_range[plot_data$year>=1950 & plot_data$year<=1959]<-'1950-59'
plot_data$year_range[plot_data$year>=1960 & plot_data$year<=1969]<-'1960-69'
plot_data$year_range[plot_data$year>=1970 & plot_data$year<=1979]<-'1970-79'
plot_data$year_range[plot_data$year>=1980 & plot_data$year<=1989]<-'1980-89'
plot_data$year_range[plot_data$year>=1990 & plot_data$year<=1999]<-'1990-99'
plot_data$year_range[plot_data$year>=2000 & plot_data$year<=2009]<-'2000-09'
plot_data$year_range[plot_data$year>=2010]<-'2010-17 '

library(dplyr)
second_pg<-plot_data %>%
  group_by(year_range)%>%
  summarize(count_yr = n())
#########Preparing dataset for Calendar Heatmap############################################


 
third_pg<-plot_data %>%
  group_by(release_date)%>%
  summarize(count_num = n())

third_pg$release_date <- as.Date(third_pg$release_date, format = "%m/%d/%Y")
third_pg$weeknum<-as.numeric(format(third_pg$release_date,"%U"))+1
third_pg$yearmonth <- factor(as.yearmon(third_pg$release_date))
library(plyr)
third_pg <- ddply(third_pg,.(yearmonth), transform, monthweek=1+weeknum-min(weeknum))
third_pg$wday <- weekdays(as.Date(third_pg$release_date))
third_pg$monthf<-months(third_pg$release_date)
third_pg$year <-format(as.Date(third_pg$release_date, format="%m/%d/%Y"),"%Y")

third_pg$year_range[third_pg$year>=1915 & third_pg$year<=1949]<-'1915-49'
third_pg$year_range[third_pg$year>=1950 & third_pg$year<=1975]<-'1950-75'
third_pg$year_range[third_pg$year>=1976 & third_pg$year<=1990]<-'1976-89'
third_pg$year_range[third_pg$year>=1990 & third_pg$year<=1999]<-'1990-99'
third_pg$year_range[third_pg$year>=2000 & third_pg$year<=2009]<-'2000-09'
third_pg$year_range[third_pg$year>=2010]<-'2010-17'
detach("package:plyr", unload=TRUE)

prod_data=plot_data
prod_data$year_range[prod_data$year>=1915 & prod_data$year<=1949]<-'1915-49'
prod_data$year_range[prod_data$year>=1950 & prod_data$year<=1975]<-'1950-75'
prod_data$year_range[prod_data$year>=1976 & prod_data$year<=1990]<-'1976-89'
prod_data$year_range[prod_data$year>=1990 & prod_data$year<=1999]<-'1990-99'
prod_data$year_range[prod_data$year>=2000 & prod_data$year<=2009]<-'2000-09'
prod_data$year_range[prod_data$year>=2010]<-'2010-17'

prod_data1<-plot_data%>%
  group_by(production_companies_1)%>%
  summarize(Revenue = sum(revenue)) 

prod_df<-head(arrange(prod_data1,desc(Revenue)), n = 10)
