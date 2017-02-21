## make a file control.dat necessary to run ORYZA v.3

# out_file <-  'D:/CIAT/USAID/Oryza/usaid_forecast_rice/Prueba/'

## final_run is if you need turn on ENDRUN

# information <- settings_head('CONTROL', 1, 1)
# proof <- write_head(out_file, information)


write_head <- function(out_file, information, final_run = FALSE){
  
  CONTROLFILE <- information$CONTROLFILE 
  STRUN <- information$STRUN
  ENDRUN <- information$ENDRUN
  
  name_control <- paste0(out_file, CONTROLFILE, '.DAT')
  
  if(final_run == FALSE){
    
    sink(name_control, append = F)
    
    cat(paste('*CONTROLFILE =',  CONTROLFILE, '.DAT'), sep = '\n')
    cat(paste('STRUN =', STRUN), sep = '\n')
    cat(paste('*ENDRUN =', ENDRUN), sep = '\n')
    
    sink()
    
  } else{
    
    sink(name_control, append = F)
    
    paste('*CONTROLFILE =',  CONTROLFILE, sep = '\n')
    paste('STRUN =', STRUN, sep = '\n')
    paste('ENDRUN =', ENDRUN, sep = '\n')
    
  }
  
  return(name_control)
  
}

# information <- ctrl_params('RES.DAT', 'MODEL.LOG', 'USAID.rer')
# write_ctrl_params(proof, information)

write_ctrl_params <- function(name_control, information){
  
  FILEON <- information$FILEON
  FILEOL <- information$FILEOL
  FILEIR <- information$FILEIR

  sink(name_control, append = T)
  
  cat('*----------------------------------------------------------------------*', sep = '\n')
  cat('* control file for ORYZA2000 model AUTOCOLIBRATION                     *', sep = '\n')
  cat('*----------------------------------------------------------------------*', sep = '\n')
  
  cat(paste0('FILEON = ', "'", FILEON, "'"), sep = '\n')
  cat(paste0('FILEOL = ', "'", FILEOL, "'"), sep = '\n')
  cat(paste('FILEIT =', "' '"), sep = '\n')
  cat(paste('FILEI1 =', "' '"), sep = '\n')
  cat(paste0('FILEIR = ', "'", FILEIR, "'"), sep = '\n')
  cat(paste('FILEI2 =', "' '"), sep = '\n')
  
  sink()
}

  