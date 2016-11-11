library("rvest")
#read in table from wikipedia
url <- "https://en.wikipedia.org/wiki/Current_members_of_the_United_States_House_of_Representatives"
congress<- url %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="mw-content-text"]/table[6]') %>%
  html_table(fill=TRUE)

congress<-congress[[1]]
#remove asterisx from year column
congress<-congress[,c(1:8)]
congress<-as.data.frame(congress)
congress$`Assumed Office`<-as.numeric(substr(congress$`Assumed Office`,1,4))

#identify congressmen who would be inelligible to run in 2018.  Those who assumed office in 2007 or earlier
limited<-congress[congress$`Assumed Office`>2007,]
aggregate(Representative~Party.1,data=limited,FUN=length)
