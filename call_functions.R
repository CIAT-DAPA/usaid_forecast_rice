# Librerias Necesarias

library(lubridate)
library(tidyverse)
library(rebus)   ## for backslash
library(lubridate)
library(magrittr)
library(stringr)



source("write_control.R")
source("settings_control.R")
source("main_functions.R")
source("make_weather.R")
source("write_reruns.R")
source("settings_reruns.R")

dir_climate <- "D:/CIAT/USAID/Oryza/Escenarios_update_csv/"
dir_run <- 'D:/CIAT/USAID/Oryza/usaid_forecast_rice/Temporal/'
filename <- 'USAID'
dir_oryza <- 'C:/Program Files (x86)/ORYZA(v3)/'  ## necesario crear una carpeta en esta direccion con los cultivares y archivos experimentales para cada region
region <- "Saldaña"
# cultivar <- 'D:/CIAT/USAID/Oryza/usaid_forecast_rice/Experimental_Cultivar_Files/'
cultivar <- "fedearroz2000"
day <- 1 ## dia a correr a partir del pronostico climatico generado
number_days <- 45 ## numero de dias a simular 
dir_files <- 'D:/CIAT/USAID/Oryza/usaid_forecast_rice/Experimental_Cultivar_Files/'   ## directorio donde se encuentran los archivos experimentales y cultivares


## add source functions

climate <- tidy_climate(dir_climate, number_days) ## carga todos los escenarios climaticos, organiza los valores para ORYZa y añade la fecha del pronostico ademas de añadir planting date and simulation date

## function to do this, depend by region?

location <- list()            
location$lat <- 8.84
location$long <- -75.8
location$elev <- 84


## is necessary to add lat, long, elev ? or is possible to put -99 for this variables 


run_oryza <- function(dir_run, dir_files, region, cultivar, climate_scenarios = climate$climate_scenarios, input_dates = climate$input_dates, location, select_day = day){
  
  lat <- location$lat
  long <- location$elev
  elev <- location$elev
 
  ## make id run 
  
  id_run <- make_id_run(dir_run, region, cultivar, day)
  
  
  make_mult_weather(climate_scenarios, id_run, filename, long, lat, elev)
  make_control(id_run)   ## mirar la funcion para cambiar las especificaciones
 
  
  ## por ahora parece ser que se puede tener todo el vector
  
  PDATE <- input_dates$PDATE[select_day]
  SDATE <- input_dates$SDATE[select_day]
  IYEAR <- input_dates$IYEAR[select_day]
  ISTN <- 1:length(climate_scenarios)
  
  
  parameters_reruns <- settins_reruns(region, PDATE, SDATE, IYEAR, ISTN, id_run)
  
  make_reruns(parameters_reruns, id_run)
  files_oryza(dir_oryza, id_run)
  id_soil <- add_exp_cul(dir_files, region, id_run)  ## controla los parametros por region y retorna el id del suelo
  execute_oryza(id_run)
  
  ## extraer summary
  
  op_dat <- read_op(id_run)
  
  yield <- calc_desc(op_dat, 'WRR14') %>%
    tidy_descriptive(region, id_soil, cultivar, DATE, DATE)
  
  
  
  # yield <- calc_desc(op_dat, "yield_0") %>%
    # tidy_descriptive(region, id_soil, cultivar, DATE, DATE)
  
}







