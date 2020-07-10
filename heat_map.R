covid <- read.csv("owid-covid-data.csv")
covid$date <- as.Date(covid$date)
recent_covid <- covid[covid$date == as.Date("2020-07-10"), ]
recent_covid <- recent_covid[c("iso_code","total_cases_per_million")]

recent_covid[recent_covid$iso_code=="USA",]

library(rworldmap)
library(classInt)
library(RColorBrewer)

mapped_data <- joinCountryData2Map(recent_covid,joinCode = "ISO3",nameJoinColumn = "iso_code")


classInt <- classIntervals(mapped_data$total_cases_per_million, n=8, style="jenks")
catMethod = classInt$brks
#getting a colour scheme from the RColorBrewer package
colourPalette <- brewer.pal(5,'RdPu')
#calling mapCountryData with the parameters from classInt and RColorBrewer
mapParams <- mapCountryData( mapped_data, nameColumnToPlot="total_cases_per_million", addLegend=FALSE
                             , catMethod = catMethod, colourPalette=colourPalette )
do.call(addMapLegend, c(mapParams
                        ,legendLabels="all"
                        ,legendWidth=0.5
                        ,legendIntervals="data"))