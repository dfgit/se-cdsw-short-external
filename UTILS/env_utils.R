# environment functions for R
cur_project_home = Sys.getenv("CUR_PROJECT_HOME")
if (nchar(cur_project_home) == 0) {
  cur_project_home = Sys.getenv("HOME")
}

# utility functions
set_app_name <- function( app_name = "R script" ) {
  paste(app_name, 
      Sys.getenv("CDSW_CREATOR"), 
      format( as.POSIXct(Sys.time()), tz="America/Chicago", usetz=TRUE), 
      sep=": ")
}

installLoadPkgs <- function(pkgList)
{
  print(pkgList)
  pkgsToLoad <- pkgList[!(pkgList %in% installed.packages()[,"Package"])];

  if(length(pkgsToLoad)) {
    startTime <- proc.time()
    install.packages(pkgsToLoad, dependencies = TRUE);
    proc.time() - startTime
  }
  
  for(package_name in pkgList) {
    library(package_name, character.only=TRUE, quietly=FALSE);
  }
}
