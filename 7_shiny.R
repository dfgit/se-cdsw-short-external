# install / load packages
source("UTILS/env_utils.R")
installLoadPkgs(c('cdsw','shiny','parallel'))

mcparallel(runApp(host="0.0.0.0", port=8080, launch.browser=FALSE,
  appDir=cur_project_home, 
  display.mode="auto"))
service.url <- paste("http://", Sys.getenv("CDSW_ENGINE_ID"), ".",
Sys.getenv("CDSW_DOMAIN"), sep="")
Sys.sleep(5)

# inline in command console
iframe(src=service.url, width="640px", height="480px")

# launch web page
html(paste("<a href='", service.url, "'>click here for web page</a>"))

## Sleep Mode
#* bad idea
#message("Going into sleeping beauty mode. Click interrupt to stop")
#while(TRUE) { 
#  # message(sprintf("Still Here %s", format(Sys.time(), "%a %b %d %H:%M:%S %Y")))
#  Sys.sleep(600) 
#}
