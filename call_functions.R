# Librerias Necesarias

library(lubridate)
library(tidyverse)



dir_climate <- "D:/CIAT/USAID/Oryza/Escenarios_update_csv/"

climate <- load_all_climate(dir_climate)  ## carga todos los escenarios climaticos, organiza los valores para ORYZa y añade la fecha del pronostico















#############################################


# crear el source functions
source('make_reruns.R')   # Directorio donde se encuentran el archivo make_reruns.R

# Fechas de Simulacion

# ydays  TRUE or FALSE
# xdate inicio de fecha de simulacion (año-mes-dia)
# ydate final de fecha de simulacion (año-mes-dia) o se puede ingresar el numero de dias
# y_days si ingresa cuantos dias deseas simular
# by_days saltos de cada cuantos dias se desea simular


xdate <- '2016-08-20' 
ydate <-  45
y_days <- TRUE
by_days <- 1

# Informacion reruns

file_name <- 'reruns.rer'                               # Nombre del archivo reruns a generar 
FILEIT = 'experimental.exp'                                         # Archivo(s) Experimental

## en ORYZA los archivos de suelos son independientes cada .sol contiene solo un tipo de suelo
FILEI2 = 'MRCO.sol'	                                        # Archivo(s) Suelo

## cada cultivar es un unico archivo
FILEI1 = c('F733.crp', 'F2000.crp') 			                  # Archivo(s) de Cultivo

## es el codigo del weather
CNTR = 'DOCO'								                                # Nombre(s) de la estacion

n_scenarios = 99		                                        # Numero de simulaciones


date_reruns_df <- date_reruns(xdate, ydate, y_days, by_days)
combinations_df <- combinations(date_reruns_df, n_scenarios, FILEIT, FILEI1, FILEI2, CNTR)
make_reruns(combinations_df, file_name)






