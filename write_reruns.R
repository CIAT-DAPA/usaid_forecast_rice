


write_reruns <- function(data, dir_run){
  
  
  file_name <- paste0(dir_run, data$CNTR, '.rer')
  
  # print(file_name)
  if(file.exists(file_name)){
    
    file.remove(file_name)
    
  } 
  
  sink(file = file_name, append = T)
  for(i in 1:nrow(data)){
    
    
    cat('********************', sep = '\n')
    cat(paste("FILEIT = ", "'",  data[i, 'FILEIT'], "'", sep = ""), sep = '\n')
    cat(paste("FILEI2 = ", "'", data[i, 'FILEI2'], "'", sep = ""), sep = '\n')
    cat(paste("FILEI1 = ", "'", data[i, 'FILEI1'], "'", sep = ""), sep = '\n')
    cat(paste("CNTR = ",   "'", data[i, 'CNTR'], "'", sep = ""), sep = '\n')
    cat(paste("ISTN = ", data[i, 'ISTN'], sep = ""), sep = '\n')
    cat(paste("IYEAR =  ",  data[i, 'IYEAR'], sep = ""), sep = '\n')
    cat(paste("STTIME =  ",  data[i, 'STTIME'], ".", sep = ""), sep = '\n')
    cat(paste("EMD =  ", data[i, 'EMD'], sep = ""), sep = '\n')
    cat(paste("EMYR = ", data[i, 'EMYR'], sep = ""), sep = '\n')
    cat(paste("WTRDIR = ", as.character(data[i, 'WTRDIR']), sep = ""), sep = '\n')
    
    
  }
  
  sink()
  
}
