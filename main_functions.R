

load_climate <- function(dir_climate){
  
  require(tidyverse)
  require(lubridate)
  
  climate_list <- list.files(dir_climate, pattern = 'escenario', full.names = T)

  climate_list_df <- lapply(climate_list, read_csv) 
  
  return(climate_list_df)
  
}



tidy_climate <- function(data, scenario){
  
  options(warn = -1)
  
  require(tidyverse)
  require(lubridate)
  
  current_year <- Sys.Date() %>%
    year()  
  
  init_frcast <- ydm(paste(current_year, data$day[1], data$month[1], sep = "-"))
  end_frcast <- ymd(init_frcast) + ddays(dim(data)[1] - 1)
  
  frcast_date <- seq(init_frcast,
                     end_frcast, by = '1 day')
  
  data <-  tbl_df(data.frame(data, frcast_date)) %>%
    mutate(scenario = rep(scenario, length(day)),
           julian_day = yday(frcast_date), 
           year_2 =year(frcast_date), 
           sol_rad = sol_rad * 1000, 
           x = rep(-99 , length(day)))
  
  
  return(data)
  
}


load_all_climate <- function(dir_climate){
  
  number_scenarios <- 1:length(list.files(dir_climate))
  
  climate <- load_climate(dir_climate) %>%
    Map('tidy_climate', .,number_scenarios)
  
  return(climate)

}

## maybe filename USAID
## filename <- 'USAID'
make_mult_weather <- function(scenarios, dir_run, filename, long, lat, elev){
  
  # filename <- 'D:/CIAT/USAID/Oryza/usaid_forecast_rice/Prueba/'
 
  number_scenarios <- 1:length(scenarios)
  
  names <- paste0(dir_run, 'USAID', number_scenarios, '.clim')
  
  invisible(Map('make_weather', climate, names, long, lat, elev, number_scenarios))
  
  
}


