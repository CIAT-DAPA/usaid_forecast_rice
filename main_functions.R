

load_climate <- function(dir_climate){
  
  require(tidyverse)
  require(lubridate)
  
  climate_list <- list.files(dir_climate, pattern = 'escenario', full.names = T)

  climate_list_df <- lapply(climate_list, read_csv) 
  
  return(climate_list_df)
  
}


## data <- climate[[1]]

tidy_climate <- function(data){
  
  options(warn = -1)
  
  current_year <- Sys.Date() %>%
    year()  
  
  init_frcast <- ydm(paste(current_year, data$day[1], data$month[1], sep = "-"))
  end_frcast <- ymd(init_frcast) + ddays(dim(data)[1] - 1)
  
  frcast_date <- seq(init_frcast,
                     end_frcast, by = '1 day')
  
  data <-  tbl_df(data.frame(data, frcast_date)) %>%
    mutate(identifier = rep(1, length(day)), 
           julian_day = yday(frcast_date), 
           year_2 =year(frcast_date), 
           sol_rad = sol_rad * 1000, 
           x = rep(-99 , length(day)))
  
  
  return(data)
  
}


