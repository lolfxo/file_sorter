# photo_sorter is a function that will group photos based on date
photo_sorter = function(input_dir, output_dir,date1, date2){
  # input_dir: Directory where files to be sorted live.
  # output_dir: Folder in which we sort files according to their creation date
  # date1: start date, format: "YYYY/MM/DD"
  # date2: end date, format: "YYYY/MM/DD"
  
  library(tools)
  
  # set output directory where we will create date folders to which photos will be copied
  if(!dir.exists(output_dir)){
    dir.create(output_dir)
  }
  
  # start date
  d1 = strftime(as.Date(date1),"%d")
  m1 = strftime(as.Date(date1),"%m")
  y1 = strftime(as.Date(date1),"%y")
  
  # end date
  d2 = strftime(as.Date(date2),"%d")
  m2 = strftime(as.Date(date2),"%m")
  y2 = strftime(as.Date(date2),"%y")
  
  # set working directory to where photos live
  setwd(input_dir)
  all_files = list.files()
  
  for (f in all_files){
    finfo = file.info(f)
    
    # extract year, month, date for each file
    day = strftime(finfo$mtime,"%d")
    month = strftime(finfo$mtime,"%m")
    year = strftime(finfo$mtime, "%y")
    
    if (day >= d1 & month >= m1 & year >= y1 & day <= d2 & month <= m2 & year <= y2) {
      # if it does not already exist create directory for that date
      dir_name = paste(output_dir,"/", paste(day, month, year, sep = "-"), sep="")
      if(!dir.exists(dir_name)){
        dir.create(dir_name)
      }
      output = file.rename(paste(input_dir,f,sep="/"), paste(dir_name,f,sep="/"))
    }
  }
}
