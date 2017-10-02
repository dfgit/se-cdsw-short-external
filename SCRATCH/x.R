library(tools)
# install / load packages
R.version.string
source("UTILS/env_utils.R")
pkgs <- c("ROCR", "caret", "ggplot2", "randomForest", "e1071", "rpart", "rpart.plot", "glmnet", "biglasso", "sqldf", "teradataR", "Boruta")
cbind(pkgName = pkgs, isInstalled = pkgs %in% installed.packages())

installLoadPkgs(pkgs)

removeDepends <- function(pkgRmList, recursive = FALSE, prompt = TRUE){
  d <- package_dependencies(,installed.packages(), recursive = recursive)
  
  pkgsToRemove <- pkgRmList[(pkgRmList %in% installed.packages()[,"Package"])];
  
  for(pkg in pkgsToRemove) {
    depends <- if(!is.null(d[[pkg]])) d[[pkg]] else character()
      
    needed <- unique(unlist(d[!names(d) %in% c(pkg,depends)]))
      
    toRemove <- depends[!depends %in% needed]
      
    if(length(toRemove)){
#      if(prompt == TRUE) {
#        toRemove <- select.list(c(pkg,sort(toRemove)), multiple = TRUE,
#                                 title = "Select packages to remove")
#      }
      tryCatch( {
        cat("Removing packages: ", toRemove, "\n")
        remove.packages(toRemove)
      }, error=function(e) {
          cat("NOTE: ", conditionMessage(e), "\n")})
    } 
  }
}
removeDepends(pkgs, prompt=TRUE)
    
cbind(pkgName = pkgs, isInstalled = pkgs %in% installed.packages())
    
# note on package not available 
    
pkgVersionCRAN = function(pkg, cran_url="http://cran.r-project.org/web/packages/")
{
  
  # Create URL
  cran_pkg_loc = paste0(cran_url,pkg)
  
  # Try to establish a connection
  suppressWarnings( conn <- try( url(cran_pkg_loc) , silent=TRUE ) )
  
  # If connection, try to parse values, otherwise return NULL
  if ( all( class(conn) != "try-error") ) {
    suppressWarnings( cran_pkg_page <- try( readLines(conn) , silent=TRUE ) )
    close(conn)
  } else {
    return(NULL)
  }
  
  # Extract version info
  version_line = cran_pkg_page[grep("Version:",cran_pkg_page)+1]
  dep <- cran_pkg_page[grep("Depends R (>= ")]
  gsub("<(td|\\/td)>","",version_line)
  version_line = cran_pkg_page
}
    
pkgVersionCRAN("proxy")
    
m <- gregexpr("[[:digit:]].[[:digit:]].[[:digit:]]", "Depends: R (>= 2.4.0)")
regmatches("Depends: R (>= 2.4.0)", m)
as.numeric(unlist(strsplit(unlist(m1), "[.]")))
as.numeric(unlist(strsplit(unlist(m1), "[.]")))[1]
