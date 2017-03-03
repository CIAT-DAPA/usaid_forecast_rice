# Librerias Necesarias

library(lubridate)
library(tidyverse)
library(rebus)   ## for backslash
library(lubridate)
library(magrittr)
library(stringr)
library(foreach)



source("write_control.R")
source("settings_control.R")
source("main_functions.R")
source("make_weather.R")
source("write_reruns.R")
source("settings_reruns.R")
source("run_oryza.R")

dir_climate <- "D:/CIAT/USAID/Oryza/Escenarios_update_csv/"
dir_run <- 'D:/CIAT/USAID/Oryza/usaid_forecast_rice/'
filename <- 'USAID'
dir_oryza <- 'C:/Program Files (x86)/ORYZA(v3)/'  ## necesario crear una carpeta en esta direccion con los cultivares y archivos experimentales para cada region
region <- "Saldaña"
# cultivar <- 'D:/CIAT/USAID/Oryza/usaid_forecast_rice/Experimental_Cultivar_Files/'
cultivar <- "fedearroz2000"
day <- 2 ## dia a correr a partir del pronostico climatico generado
number_days <- 2 ## numero de dias a simular 45
dir_files <- 'D:/CIAT/USAID/Oryza/usaid_forecast_rice/Experimental_Cultivar_Files/'   ## directorio donde se encuentran los archivos experimentales y cultivares


## add source functions

climate <- tidy_climate(dir_climate, number_days) ## carga todos los escenarios climaticos, organiza los valores para ORYZa y añade la fecha del pronostico ademas de añadir planting date and simulation date

## function to do this, depend by region?

location <- list()            
location$lat <- 8.84
location$long <- -75.8
location$elev <- 84


## is necessary to add lat, long, elev ? or is possible to put -99 for this variables 

# run_oryza(dir_run, dir_files, region, cultivar, climate$climate_scenarios, climate$input_dates, location, day)

name_csv <- "prueba.csv" 

run_mult_oryza(dir_run,
               dir_files,
               region,
               cultivar,
               climate$climate_scenarios,
               climate$input_dates,
               location,
               day,
               number_days,
               out_csv)


