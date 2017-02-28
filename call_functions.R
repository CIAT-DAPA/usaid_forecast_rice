# Librerias Necesarias

library(lubridate)
library(tidyverse)
library(rebus)   ## for backslas

source("write_control.R")
source("settings_control.R")
source("main_functions.R")
source("make_weather.R")
source("write_reruns.R")

dir_climate <- "D:/CIAT/USAID/Oryza/Escenarios_update_csv/"
dir_run <- 'D:/CIAT/USAID/Oryza/usaid_forecast_rice/Prueba/'
filename <- 'USAID'
dir_oryza <- 'C:/Program Files (x86)/ORYZA(v3)/'  ## necesario crear una carpeta en esta direccion con los cultivares y archivos experimentales para cada region
region <- "Saldaña"
# cultivar <- 'D:/CIAT/USAID/Oryza/usaid_forecast_rice/Experimental_Cultivar_Files/'
cultivar <- "fedearroz2000"
day <- 1 ## dia a correr a partir del pronostico climatico generado


## add source functions

climate <- load_all_climate(dir_climate)  ## carga todos los escenarios climaticos, organiza los valores para ORYZa y añade la fecha del pronostico

lat <- 8.84
long <- -75.8
elev <- 84


## is necessary to add lat, long, elev ? or is possible to put -99 for this variables 


run_oryza <- function(dir_run, region, cultivar){
  
  
  make_id_run(dir_run, region, cultivar, day)
  ## make id run 
  
  make_id_run(dir_run, region, cultivar, day)
  
  
  make_mult_weather(climate, dir_run, filename, long, lat, elev)
  make_control(dir_run)
 
  # parametros re runs
  # reruns_params <- list()
  # reruns_params$ISTN <-  1 # escenario climatico
  # reruns_params$IYEAR <- 2017  ## año simulacion
  # reruns_params$STTIME <- 32 ## simulation date
  # reruns_params$EMD <- 32 # emergence date
  
  data <- settins_reruns(region = "Saldaña", reruns_params, dir_run)
  make_reruns(data, dir_run)
  files_oryza(dir_oryza, dir_run)
  add_exp_cul(dir_files, region, dir_run)
  
  

  execute_oryza()
  
  
}







