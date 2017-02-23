# Librerias Necesarias

library(lubridate)
library(tidyverse)
library(rebus)

source("write_control.R")
source("settings_control.R")
source("main_functions.R")
source("make_weather.R")

dir_climate <- "D:/CIAT/USAID/Oryza/Escenarios_update_csv/"
dir_run <- 'D:/CIAT/USAID/Oryza/usaid_forecast_rice/Prueba/'
filename <- 'USAID'


## add source functions

climate <- load_all_climate(dir_climate)  ## carga todos los escenarios climaticos, organiza los valores para ORYZa y añade la fecha del pronostico

lat <- 8.84
long <- -75.8
elev <- 84


## is necessary to add lat, long, elev ? or is possible to put -99 for this variables 


make_mult_weather(climate, dir_run, filename, long, lat, elev)
make_control(dir_run)
make_reruns(data, dir_run)




