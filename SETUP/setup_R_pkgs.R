# load required R packages
setupInstallLoadPkgs <- function(pkgList)
{

#  country.code <- 'us'  # use yours
#  url.pattern <- 'http://'  # use https if you want
#  repo.data.frame <- subset(getCRANmirrors(), CountryCode == country.code & grepl(url.pattern, URL))
#  options(repos = c(repo.data.frame$URL, 'https://cran.rstudio.org'))

  print(pkgList)
<<<<<<< HEAD
  pkgsToLoad <- pkgList[!(pkgList %in% installed.packages()[,"Package"])];
=======
  pkgsToLoad <- pkgList[!(pkgList %in% installed.packages(lib.loc='/home/cdsw/R')[,"Package"])];
>>>>>>> 5c0731f89204535ab85049bab1b1437a6e99bb8b

  if(length(pkgsToLoad)) {
    startTime <- proc.time()
    install.packages(pkgsToLoad, dependencies = TRUE,
<<<<<<< HEAD
                      repos=c('http://cran.us.r-project.org', 'https://cran.rstudio.org'));
=======
                     lib='/home/cdsw/R',
                     repos=c('http://cran.us.r-project.org', 'https://cran.rstudio.org'));
>>>>>>> 5c0731f89204535ab85049bab1b1437a6e99bb8b
  }

  for(package_name in pkgList) {
    library(package_name, character.only=TRUE, quietly=FALSE);
  }
}


startTime <- proc.time()
pkgs <- c("sparklyr", "dplyr", "ggplot2", "maps", "geosphere", "DBI", "cdsw", "shiny", "parallel")
setupInstallLoadPkgs(pkgs)
proc.time() - startTime
