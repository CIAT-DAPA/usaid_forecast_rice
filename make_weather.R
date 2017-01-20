## make climate file

# libs required
library(tidyverse)

## Path scenarios climate file
path <- '//dapadfs/Workspace_cluster_9/USAID_Project/Product_3_agro-climatic_forecast/crop/Rice/Clima/Escenarios/'

## verify if ORYZA use a head for lat, long, elev, 0,0   (Jeferson Rodriguez said me yes!!!!)
lat <- 8.84
long <- -75.8
elev <- 84


## first question 
## how to generate the name of the file for the weather to run ORYZA v3


## generate a function to load all information from climate 

proof_file <- read_csv(paste0(path, 'escenario_1', '.csv'))

# proof_file
# you need the next variables
# day, month, year, precip, tmax, tmin, srad (m jules) 
# Oryza necesita tener kilo jules eso me dijo Jeferson R

make_weather(proof_file, filename = 'EO1.016', long, lat, elev)



make_weather <- function(climate_df, filename, long, lat, elev){
  
  require(tidyverse)
  
  ## añadir condicional cuando el año es biciesto
  ## que pasa cuando no se tiene toda la informacion para el año, será que se pudrisiñea ORYZA v3?
  ## Probar si genera problemas el numero de decimales
  
  climate_df <- climate_df %>%
                  mutate(identifier = rep(1, length(day)), srad = srad * 1000, x = rep(0 , length(day)), y = rep(0, length(day))) %>%
                  select(identifier, year, day, srad, tmin, tmax, x, y, precip)
 
  sink(file = filename, append = F)
  
  cat(paste0(long, ',', lat, ',', elev, ',', 0, ',', 0))
  cat('\n')
  write.table(climate_df, sep = ",", row.names = F, col.names = F)
  
  sink()
  
}

