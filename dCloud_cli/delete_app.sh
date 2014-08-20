#! /bin/bash

if [ "$#" -lt 1 ]; then
  echo "$0 app_name"
  exit 1
fi
base_dir=$(cd "$(dirname "$0")"; pwd)
source "${base_dir}/de.properties"
source "${base_dir}/utils.sh"
# make some init work
init

marathon_api="$marathon_api"
docker_host="$docker_host"
docker_port="$docker_port"
app_name="$1"
log_file="${log_dir}/delete_app.log"

status_code=`curl -o /dev/null -s -X GET -H "Content-Type: application/json" -w %{http_code} $marathon_api/v2/apps/$app_name`
if [ "$status_code" -eq "404" ]; then
  warning "app $app_name does not exist!"
  exit 0 
else
  status_code=`curl -o /dev/null -s -X DELETE -H "Content-Type: application/json" -w %{http_code} $marathon_api/v2/apps/$app_name`
  
  if [ "$status_code" -ge "200" -a "$status_code" -lt "300" ]; then
    status_code=`curl -o /dev/null -s -X GET -H "Content-Type: application/json" -w %{http_code} $marathon_api/v2/apps/$app_name`
    wait_times=0
    while [ "$status_code" -ne "404" ]
    do
      if [ "$wait_times" -gt "6" ]; then
        error "failed to delete app $app_name, please check it on ui!"
        exit 1
      fi
      status_code=`curl -o /dev/null -s -X GET -H "Content-Type: application/json" -w %{http_code} $marathon_api/v2/apps/$app_name`
      
      info "trying to delete app $app_name"
      sleep 5
      wait_times=$(($wait_times + 1))
    done

    succeed "succeed to delete app $app_name"
    exit 0
  else
    error "failed to delete app $app_name, and status_code is $status_code"
    exit 1
  fi

fi
