from os import path, environ

# set environment variable for current home directory
#def cur_project_home():
#  cur_project_home =  environ.get('CUR_PROJECT_HOME')
#  if cur_project_home is None:
#      cur_project_home = environ['HOME']
#  return cur_project_home

cur_project_home =  environ.get('CUR_PROJECT_HOME')
if cur_project_home is None:
    cur_project_home = environ['HOME']

# set app name
from datetime import datetime
import pytz
import sys
def set_app_name(func_name="My Python Function"):
  # hack for CST until I get server timezones adjusted
  cur_dt = str(datetime.strftime(datetime.now(pytz.timezone("America/Chicago")),"%Y-%m-%d %H:%M:%S %Z"))
  return ": ".join(str for str in (func_name, environ.get("CDSW_CREATOR"), cur_dt))
